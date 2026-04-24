---
name: github-actions-ci
description: Convenciones para workflows de GitHub Actions de CI con caching agresivo, jobs paralelos (lint / typecheck / test-smoke / build) y separación del gate de PR vs jobs nightly (test-heavy, e2e). Invocar cuando se genere o audite `.github/workflows/*.yml`, se agregue un gate de PR, o se optimice un CI lento. Objetivo: el path `lint + typecheck + test-smoke` corre en <1 min con caché tibio.
---

# GitHub Actions — CI performante

Esta skill define cómo se arma un workflow de CI que sirva de gate de PR sin tardar 10 minutos. Aplica a monorepos y a proyectos simples.

> **Detectar antes de imponer**: leé `package.json` / `pyproject.toml` / `pnpm-lock.yaml` / `poetry.lock` / `uv.lock` del proyecto **target** antes de decidir package manager y comandos. Si el proyecto ya usa npm, no introduzcas pnpm sin pedir permiso. Esta skill genera el workflow adaptado al stack real del proyecto, no al default del kit.

## Principios

1. **Cachear todo lo cacheable** — deps, builds intermedios, `.next/cache`, `.turbo`, `.vite`, `.mypy_cache`.
2. **Jobs paralelos pequeños** en vez de uno monolítico secuencial. `lint` y `typecheck` no dependen uno del otro.
3. **Fail fast**: `lint` y `typecheck` son los gates más rápidos; `test-smoke` más costoso pero aún <1 min.
4. **Separar heavy / e2e**: nunca en el gate de PR. Van en `nightly.yml` o `workflow_dispatch`.
5. **Lock file obligatorio** — `pnpm-lock.yaml` / `package-lock.json` / `uv.lock` / `poetry.lock` commiteado. Install usa `--frozen-lockfile` / `npm ci` / `uv sync --frozen` / `poetry install --no-root`.

## Caching obligatorio

### Node / pnpm

```yaml
- uses: pnpm/action-setup@v4
  with:
    version: 9

- uses: actions/setup-node@v4
  with:
    node-version: "20"
    cache: "pnpm"
    cache-dependency-path: pnpm-lock.yaml

- run: pnpm install --frozen-lockfile
```

### Node / npm

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: "20"
    cache: "npm"
    cache-dependency-path: package-lock.json

- run: npm ci
```

### Python / pip

```yaml
- uses: actions/setup-python@v5
  with:
    python-version: "3.12"
    cache: "pip"
    cache-dependency-path: |
      requirements.txt
      requirements-dev.txt

- run: pip install -r requirements-dev.txt
```

### Python / uv (opt-in, más rápido)

`uv` instala deps 10-100× más rápido que pip. Recomendado para proyectos con muchas deps, pero **es opt-in**: preguntar antes de introducirlo en un proyecto que ya usa pip/poetry.

```yaml
- uses: actions/setup-python@v5
  with:
    python-version: "3.12"

- uses: astral-sh/setup-uv@v4
  with:
    enable-cache: true
    cache-dependency-glob: "uv.lock"

- run: uv sync --frozen
```

### Caches adicionales por stack

```yaml
# Next.js
- uses: actions/cache@v4
  with:
    path: .next/cache
    key: nextjs-${{ runner.os }}-${{ hashFiles('pnpm-lock.yaml') }}-${{ hashFiles('**/*.ts', '**/*.tsx') }}
    restore-keys: nextjs-${{ runner.os }}-${{ hashFiles('pnpm-lock.yaml') }}-

# Turborepo
- uses: actions/cache@v4
  with:
    path: .turbo
    key: turbo-${{ runner.os }}-${{ github.sha }}
    restore-keys: turbo-${{ runner.os }}-

# Vite (proyectos no-Next)
- uses: actions/cache@v4
  with:
    path: node_modules/.vite
    key: vite-${{ runner.os }}-${{ hashFiles('pnpm-lock.yaml') }}

# mypy
- uses: actions/cache@v4
  with:
    path: .mypy_cache
    key: mypy-${{ runner.os }}-${{ hashFiles('pyproject.toml') }}
```

## Jobs del gate de PR (paralelos)

El gate de PR mínimo son **4 jobs**:

| Job | Qué corre | Target duración | Gate de PR |
|---|---|---|---|
| `lint` | ruff / eslint | 5-15s | ✅ |
| `typecheck` | mypy / tsc --noEmit | 15-40s | ✅ |
| `test-smoke` | pytest `-m "not heavy"` -n auto · vitest | 20-60s | ✅ |
| `build` | next build / python -m build | 30-90s | ✅ (solo si lint+typecheck OK) |

Jobs **fuera** del gate de PR:

| Job | Qué corre | Cuándo |
|---|---|---|
| `test-heavy` | pytest `-m heavy` (render real, LLM APIs reales) | `workflow_dispatch` + nightly schedule |
| `e2e` | playwright test | nightly + pre-deploy |
| `deploy` | deploy a host | push a `main` o tag |

## Template base (polyglot monorepo: Python backend + Node frontend)

Template completo en `templates/github/ci.yml`. Esqueleto:

```yaml
name: CI
on:
  push:
    branches: [main]
  pull_request:

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      # setup + cache según stack
      - run: <lint command>

  typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: <typecheck command>

  test-smoke:
    runs-on: ubuntu-latest
    needs: []  # paraleliza con lint/typecheck, no espera
    steps:
      - uses: actions/checkout@v4
      - run: <test command with -n auto / --reporter=dot>

  build:
    runs-on: ubuntu-latest
    needs: [lint, typecheck]  # solo si los gates rápidos pasan
    steps:
      - uses: actions/checkout@v4
      - run: <build command>
```

## `concurrency` obligatorio

Cancela runs duplicados cuando alguien pushea sobre el mismo PR:

```yaml
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
```

Sin esto, un force-push encima de otro deja dos runs compitiendo por runners = doble costo + feedback tardío.

## Jobs nightly / manuales

`nightly.yml` separado para tests heavy + E2E:

```yaml
name: Nightly
on:
  schedule:
    - cron: "0 3 * * *"  # 3 AM UTC
  workflow_dispatch:

jobs:
  test-heavy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      # ... setup idéntico al gate ...
      - run: pytest -m heavy -n auto

  e2e:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: pnpm playwright install --with-deps chromium
      - run: pnpm test:e2e
```

## Checklist de validación

Al generar o auditar un workflow, verificar:

1. **Caching presente** en setup-python / setup-node (`cache:` field).
2. **Lock file commiteado** y referenciado en `cache-dependency-path`.
3. **Install con `--frozen-lockfile`** (o `npm ci`, `uv sync --frozen`, `poetry install --no-root`).
4. **Jobs paralelos**: `lint`, `typecheck`, `test-smoke` sin dependencia entre sí.
5. **`concurrency` con `cancel-in-progress: true`**.
6. **Heavy / E2E fuera del gate de PR** (otro archivo o `if: github.event_name == 'schedule'`).
7. **Duración objetivo** con caché tibio: `lint + typecheck + test-smoke` < 1 min en runner estándar `ubuntu-latest`. Si no llega, auditar:
   - ¿Caché funcionando? Ver "Cache hit" en logs.
   - ¿Tests single-worker? Agregar `-n auto`.
   - ¿Install trayendo deps innecesarias? Separar `requirements.txt` de `requirements-dev.txt`.

## Anti-patterns

- **Un solo job monolítico** que hace `install → lint → typecheck → test → build` secuencial. Dividir.
- **Sin `cache:` en setup-python/setup-node** — cada run baja deps desde cero.
- **`pnpm install` sin `--frozen-lockfile`** — puede actualizar deps silenciosamente en CI.
- **Playwright en el job de unit tests** — tarda, es flaky, bloquea PRs.
- **Tests heavy (LLM, PDF real) en gate de PR** — minutos de wait + rate limits + costo.
- **Sin `concurrency`** — pushes sucesivos dejan runs zombie.
- **`runs-on: macos-latest` sin razón** — más lento y más caro que ubuntu.
- **Checkout con `fetch-depth: 0` innecesario** — baja todo el historial de git sin necesidad.

## Ver también

- `templates/github/ci.yml` — template completo con 4 jobs paralelos, caches por stack, comentarios para customizar.
- `pytest-style` — cómo estructurar tests Python para que `test-smoke` corra en <60s con `-n auto`.
- `vitest-patterns` — cómo estructurar tests JS/TS para el mismo objetivo, y por qué Playwright va en job aparte.
- `git-flow` — branching + PRs que consumen estos workflows.

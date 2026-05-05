# Claudio Agents Kit

Equipo reutilizable de agentes, skills y templates para Claude Code. Empaquetado como plugin para instalación y actualización vía GitHub.

## Qué trae

**21 agentes**
- Core (7): `orquestador`, `documentador`, `limpiador`, `optimizador`, `discovery-agent`, `product-analyst`, `design-researcher`
- Expertos (8): `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`
- UX/UI review (2): `navigator` (flujo entre páginas, links, back/refresh), `ui-reviewer` (crítica visual de una página: espacio, jerarquía, densidad)
- Productividad y planning (3): `project-manager`, `prompt-optimizer`, `code-council`
- Meta (1): `agent-manager` (gestión del kit)

**16 skills reutilizables**
`pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `pytest-style`, `vitest-patterns`, `github-actions-ci`, `react-query-patterns`, `git-flow`, `docstring-google-style`, `commit-message-format`, `epic-user-story-format`, `design-inspiration-lookup`, `proposal-writing`, `presentation-inspiration-lookup`, `prospect-branding-lookup`, `consultora-branding-lookup`

**5 templates de proyecto** (via slash command)
`platform` · `proposal` · `portfolio` · `automation` · `data`

**1 slash command**
`/claudio-agents-kit:new-project` — scaffolda proyecto nuevo por tipo

## Distribución de modelos

| Modelo | Agentes |
|---|---|
| Opus | data-expert, backend-expert, frontend-expert, devops-expert, code-council, ui-reviewer |
| Sonnet | orquestador, optimizador, qa-expert, db-architect, security-auditor, discovery-agent, product-analyst, design-researcher, navigator, project-manager, prompt-optimizer, agent-manager |
| Haiku | documentador, limpiador, client-reporter |

## Uso

### Invocar agentes manualmente
```
@orquestador necesito armar un proyecto de ETL para FarmaX
@discovery-agent arrancá con este brief: [...]
@design-researcher buscá inspiración para un portfolio de fotógrafo
```

### Invocación automática
Los agentes se activan solos cuando el contexto matchea con su `description`. Por ejemplo, si pedís "diseñá un schema de PostgreSQL", Claude Code invoca `db-architect`.

### Crear proyecto nuevo
```
/claudio-agents-kit:new-project
```
Te pregunta nombre, tipo y destino, y scaffolda todo.

## Flujos por tipo de proyecto

**Platform (PaaS)** — el más completo
```
discovery-agent → product-analyst → design-researcher →
expertos técnicos → limpiador → optimizador → qa-expert →
security-auditor → documentador → client-reporter
```

**Proposal**
```
discovery-agent (mini) → client-reporter (redacta) → Claudio revisa → envía
```

**Portfolio**
```
discovery-agent → design-researcher (CRÍTICO) → frontend-expert → devops-expert → client-reporter
```

**Automation**
```
discovery-agent (mini) → data/backend-expert → devops-expert (scheduler) → qa-expert → documentador
```

**Data analysis**
```
discovery-agent → data-expert (EDA) → supuestos aprobados → data-expert (análisis) → documentador → client-reporter
```

## Estructura del plugin

```
claudio-agents-kit/
├── .claude-plugin/
│   └── plugin.json
├── agents/                    ← 15 agentes
├── skills/                    ← 11 skills
├── commands/
│   └── new-project.md         ← slash command
├── scripts/
│   └── new-project.sh
├── templates/
│   ├── CLAUDE-global.md       ← referencia para ~/.claude/CLAUDE.md
│   └── project-types/         ← 5 templates
└── README.md
```

## Primera instalación: CLAUDE global

Al instalar el plugin por primera vez, te recomiendo copiar el CLAUDE global de referencia a tu `~/.claude/CLAUDE.md`:

```bash
cp ~/.claude/plugins/*/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
```

(La ruta exacta puede variar según dónde Claude Code instale el plugin.)

## Actualización

Cada vez que haya versión nueva en el marketplace de GitHub:

```bash
claude plugin update claudio-agents-kit
```

## Performance Requirements (tests + CI)

El kit impone estándares no negociables para generación de tests y workflows de CI. Los agents `qa-expert`, `backend-expert` y `devops-expert` aplican estas reglas por default a través de los skills `pytest-style`, `vitest-patterns` y `github-actions-ci`.

### Números objetivo

| Métrica | Target |
|---|---|
| Suite de tests Python (<500 tests) | **< 60s** con `pytest -n auto` |
| Test individual (sin marker) | **< 2s** |
| Suite de tests JS/TS (<300 tests) | **< 30s** con Vitest |
| Gate de PR (`lint + typecheck + test-smoke`) | **< 1 min** con caché tibio, runner `ubuntu-latest` |
| Test heavy (render real / LLM / S3) | Fuera del gate de PR, corre en `nightly.yml` o `workflow_dispatch` |
| E2E (Playwright) | Fuera del gate de PR, job separado |

### Reglas que los skills aplican por default

**Python / pytest (`pytest-style`)**
1. Engine session-scoped + `create_all` UNA vez por worker. Nunca `drop_all` per-test.
2. `db_session` function-scoped con **SAVEPOINT (nested transaction) + rollback**.
3. `pytest-xdist` por default: `pytest -n auto --dist loadfile`.
4. Mocks `autouse=True` para PDF/LLM/S3/email; tests que quieran el real usan `@pytest.mark.heavy`.
5. `BCRYPT_ROUNDS=4`, JWT hardcodeado de test, Celery eager, Redis fake.
6. Markers registrados: `heavy`, `slow`, `integration`.
7. Cero `time.sleep` / `asyncio.sleep` real — `freezegun` o monkeypatch del reloj.
8. Template de referencia: `templates/pytest/conftest.py`.

**JS/TS / Vitest (`vitest-patterns`)**
1. Vitest preferido para proyectos nuevos (no migrar Jest existente).
2. MSW con `onUnhandledRequest: "error"` — falla si hay fetch no mockeado.
3. Mocks globales de SDKs (`vi.mock("openai")`, `vi.mock("@/lib/analytics")`) en `tests/setup.ts`.
4. Nunca levantar `next dev` en tests — usar RTL, `renderHook`, imports directos de route handlers.
5. Playwright siempre en job aparte (`tests/e2e/` excluido del runner principal).

**GitHub Actions (`github-actions-ci`)**
1. Caching obligatorio: `cache:` en `setup-python`/`setup-node` + `actions/cache` para `.next/cache`, `.mypy_cache`, `.turbo`.
2. Lock file commiteado + `--frozen-lockfile` / `npm ci` / `uv sync --frozen`.
3. Jobs paralelos: `lint`, `typecheck`, `test-smoke` independientes. `build` depende de lint+typecheck.
4. `concurrency` con `cancel-in-progress: true` en todos los workflows.
5. Heavy y E2E separados en `nightly.yml` o `workflow_dispatch`.
6. Template de referencia: `templates/github/ci.yml`.

### Checklist de validación (qa-expert lo corre antes de cerrar tarea)

Antes de declarar "tests listos":

1. `pytest --collect-only -q` → reportar total de tests.
2. `time pytest -n auto --durations=10 -q` → reportar duración total + top-10 más lentos.
3. **Bloqueos duros** (NO cerrar si alguno aplica):
   - Test > 2s sin marker `heavy` / `slow` → propuesta concreta (mockear X, fixture Y, o mover a `@pytest.mark.heavy`).
   - Suite > 60s para <500 tests → revisar fixtures, SAVEPOINT, xdist.
   - `pytest -n auto` falla pero single-worker pasa → fixture no es thread-safe.
4. Para frontend: `vitest run` con `onUnhandledRequest: "error"` pasa — si no, hay fetches reales escondidos.

### Detección de stack (regla transversal)

Los skills **no imponen** stack. Antes de scaffoldear, leen:
- `pyproject.toml` / `requirements*.txt` / `uv.lock` / `poetry.lock` para Python.
- `package.json` / `pnpm-lock.yaml` / `package-lock.json` para Node.

Si el proyecto ya usa pip, no se introduce uv sin pedir permiso. Si ya usa Jest, no se migra a Vitest. Si ya usa npm, no se impone pnpm. Los skills se adaptan; la migración es decisión del humano.

## Changelog

Ver `CHANGELOG.md` en el root del marketplace.

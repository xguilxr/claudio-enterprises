# Claudio-Enterprises

Familia de **cuatro marcos de trabajo** y el paquete que los opera.

| | Qué gobierna | Requisitos |
|---|---|---|
| **MFB** | Cómo se construye un marco | 52 |
| **MCA** | Cómo trabaja Claude sobre un repositorio | 48 |
| **MCC** | Cómo se conduce un encargo de cliente | 92 |
| **MCS** | Cómo se construye software de calidad | 204 |

**Empezá por [`docs/ORQUESTADOR.md`](docs/ORQUESTADOR.md).** Son 396 requisitos y no se
cargan nunca todos: el orquestador dice qué entra y cuándo. Por defecto, nada.

- [`docs/README.md`](docs/README.md) — qué existe
- [`docs/AUDITORIA.md`](docs/AUDITORIA.md) — cómo se audita un proyecto: MCA → MCC → MCS
- [`docs/conocimiento/glosario.yaml`](docs/conocimiento/glosario.yaml) — el único eje común

## El paquete

## Instalación (one-liner)

En cualquier máquina donde uses Claude Code, una sola vez:

```bash
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

Verificá:

```bash
claude plugin list
```

Dentro de Claude Code, `/skills` debería listar 21 skills. Los agentes se retiraron en la v6.0.0: ver `docs/migracion/03-disposicion.md`.

### (Recomendado) Linkear el CLAUDE.md global

Para que las reglas globales (stack preferido, agentes core, flujo por tipo de proyecto, reporte post-cambio obligatorio, karpathy-principles) se actualicen automáticamente con cada `plugin update`:

```bash
mkdir -p ~/.claude
ln -sf ~/.claude/plugins/claudio-enterprises/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
```

Si preferís editar el archivo con reglas personales (ej: cambiar "Soy Claudio" → "Soy David" como hizo David en su global), usá `cp` en vez de `ln -sf` y re-copiá manualmente cuando el kit evoluciona.

## Dos comandos para dos cosas distintas

Desde v5.1.0, el plugin tiene un solo slash command (`/setup`) que **NO** crea proyectos nuevos. Esa responsabilidad la tiene `/scaffold` del vault de David. La distinción importa:

| Acción | Dónde corre | Qué hace |
|---|---|---|
| **Crear proyecto nuevo del portafolio de David** | `/scaffold` del vault (`portfolio-mgmt/scaffolding/scaffold.py`) | Operación atómica: crea repo en GitHub + carpeta en `portfolio-mgmt/projects/<slug>/` + clone local + entrada en `99-meta/repos-inventario.md` |
| **Crear proyecto externo (no portafolio)** | Manual | Copiar `templates/project-types/<tipo>.md` a mano y editar |
| **Bootstrappear agentes/skills LOCALES en un proyecto existente** | `/claudio-agents-kit:setup` (este plugin) | Crea `.claude/agents/<nombre>.md` o `.claude/skills/<nombre>/SKILL.md` en el CWD. Útil para forkear un agente del kit y customizarlo, o crear un agente específico del proyecto |

## Uso — `/claudio-agents-kit:setup`

El comando bootstrappea agentes y skills LOCALES del proyecto donde estás parado. Cuatro opciones:

| Opción | Qué hace |
|---|---|
| **A — Agente nuevo desde cero** | Crea `.claude/agents/<nombre>.md` con skeleton (frontmatter + secciones de cuándo invocarlo / qué hace / qué no hace / output / reglas). |
| **B — Agente forkeado del kit** | Copia un agente del marketplace (ej: `frontend-expert`) a `.claude/agents/<nombre>.md` local para customizarlo sin tocar el kit global. El local sobrescribe al global cuando se invoca. |
| **C — Skill nuevo desde cero** | Crea `.claude/skills/<nombre>/SKILL.md` con skeleton (cuándo aplicar / la regla / ejemplos bien y mal / por qué importa). |
| **D — Listar** | Tabla de lo que ya existe en `.claude/agents/` y `.claude/skills/`. |

NO genera `CLAUDE.md` de proyecto. Si lo necesitás, usá `/scaffold` (vault) o copiá `templates/project-types/<tipo>.md` a mano.

Después de bootstrap, reiniciá la sesión para que Claude Code cargue el archivo nuevo.

## Contenido del kit

### 22 agentes

**Core (siempre activos)**: `orquestador`, `documentador`, `limpiador`, `optimizador`.

**Planning**: `discovery-agent`, `product-analyst`, `project-manager`, `design-researcher`.

**Expertos técnicos (opt-in por proyecto)**: `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`.

**UX/UI review (opt-in)**: `navigator` (flujo de navegación entre páginas), `ui-reviewer` (crítico visual de una página).

**Productividad y revisión**: `prompt-optimizer` (prompts crudos → prompts optimizados de 6 modos), `code-council` (consejo de expertos para cambios cross-domain).

**Ejecución headless**: `task-executor` (persona para `claude -p` spawneados por warroom; parsea task contract, trabaja al DoD, emite report-back estructurado).

**Meta**: `agent-manager` (gestiona ciclo de vida de agentes/skills dentro de este repo: crear/modificar/remover con bump + CHANGELOG + commit).

### 21 skills

**Convenciones de código**: `commit-message-format`, `git-flow`, `docstring-google-style`, `pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `react-query-patterns`.

**Testing y CI**: `pytest-style` (extendido con reglas de performance), `vitest-patterns`, `github-actions-ci`.

**Producto y propuestas**: `epic-user-story-format`, `proposal-writing`.

**Branding e inspiración**: `consultora-branding-lookup`, `design-inspiration-lookup`, `presentation-inspiration-lookup`, `prospect-branding-lookup`.

**Principios transversales**: `karpathy-principles` (4 reglas: Think Before Coding / Simplicity First / Surgical Changes / Goal-Driven Execution).

**Integración con ecosistema de David (v5.0+)**:
- `obsidian-vault-conventions` — pointer al spec del vault de Obsidian de David (paths, frontmatter, convención `## Para David`).
- `github-repo-inventory` — pointer al inventario único de repos en `99-meta/repos-inventario.md`.
- `warroom-task-contract` — formato YAML del task contract planner → executor.
- `executor-discipline` — 5 reglas para sesiones `claude -p` headless.

### 5 templates de proyecto

Un `CLAUDE.md` diferenciado por tipo: `platform`, `proposal`, `portfolio-website`, `automation`, `data-analysis`. Usar como base para `CLAUDE.md` de proyectos externos (los del portafolio de David usan los archetypes del vault, no estos).

## Actualizar el kit en tus máquinas

```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

Si linkeaste con `ln -sf`, el `CLAUDE.md` global se actualiza solo.

## Evolucionar el kit (solo dentro de este repo)

Dentro del repo del marketplace, pedile al meta-agente:

```
> Usá agent-manager para crear un agente llamado sales-expert que analice pipelines de ventas
```

`agent-manager` hace todo el bookkeeping: crea desde plantilla, valida frontmatter, bumpea `plugin.json` + `marketplace.json`, actualiza `CHANGELOG.md`, commitea con Conventional Commits y pushea a una branch.

Reglas de versionado (SemVer):
- **MAJOR** (4.x → 5.0): cambio que rompe flujos existentes (ej: rename de slash command, redefinición de comportamiento).
- **MINOR** (5.0 → 5.1): agente/skill/comando nuevo o redefinición de uno existente sin remover funcionalidad.
- **PATCH** (5.1.0 → 5.1.1): typos, ajustes menores de descripción.

**Importante**: si no bumpeás versión, los consumidores no ven el cambio (caching por versión).

## Estructura del repo

```
claudio-enterprises/
├── .claude-plugin/
│   └── marketplace.json          ← índice público del marketplace
├── plugins/
│   └── claudio-agents-kit/
│       ├── .claude-plugin/plugin.json
│       ├── agents/               ← 22 .md
│       ├── skills/               ← 21 carpetas con SKILL.md
│       ├── commands/setup.md     ← único slash command (bootstrap local)
│       ├── scripts/setup.sh      ← orphan desde v5.1.0 (deprecated, no se invoca)
│       ├── templates/
│       │   ├── CLAUDE-global.md
│       │   ├── STYLE.md
│       │   ├── prompt-system-reference.md
│       │   ├── chrome-site-classification-prompt.md
│       │   ├── project-types/    ← 5 templates
│       │   ├── pytest/conftest.py
│       │   └── github/ci.yml
│       └── README.md
├── CHANGELOG.md
├── CLAUDE.md                     ← reglas para trabajar DENTRO del repo
└── README.md
```

## Desarrollo local

Para probar cambios sin pushear:

```bash
cd ~/claudio-enterprises
claude plugin marketplace add "$(pwd)"
claude plugin install claudio-agents-kit

# Al terminar:
claude plugin uninstall claudio-agents-kit
claude plugin marketplace remove claudio-enterprises
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

## Troubleshooting

**"No veo los cambios después de editar"** → olvidaste bumpear versión. Claude Code cachea por versión.

**"El slash command `/setup` no genera el CLAUDE.md como antes"** → es esperado desde v5.1.0. `/setup` ahora bootstrappea agentes/skills LOCALES, no genera CLAUDE.md de proyecto. Para CLAUDE.md, usá `/scaffold` (vault de David) o copiá `templates/project-types/<tipo>.md` a mano.

**"Los agentes no aparecen en `/agents`"** → los `.md` tienen que estar directo en `plugins/claudio-agents-kit/agents/`, no en subcarpetas.

## Versionado público

El CHANGELOG sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Cada release incluye migration notes cuando rompe algo.

Versión actual: **5.1.0** (ver `CHANGELOG.md`).

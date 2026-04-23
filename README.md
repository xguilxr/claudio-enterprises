# Claudio-Enterprises Marketplace

Marketplace público de Claude Code para la agencia Claudio-Enterprises: **19 agentes + 14 skills + 5 templates de proyecto + comando unificado `/setup` + sistema de prompts de 6 modos**.

## Instalación (one-liner)

En cualquier máquina donde uses Claude Code, una sola vez:

```bash
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

Verificá:

```bash
claude plugin list   # debe mostrar claudio-agents-kit con versión 4.1.0+
```

Dentro de Claude Code, `/agents` debería listar los 19 agentes.

### (Recomendado) Linkear el CLAUDE.md global

Para que tus reglas globales (stack preferido, agentes core, flujo por tipo de proyecto) se actualicen automáticamente con cada `plugin update`:

```bash
mkdir -p ~/.claude
ln -sf ~/.claude/plugins/claudio-enterprises/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
```

Si preferís editar el archivo con reglas personales, usá `cp` en vez de `ln -sf` (pero entonces tenés que re-copiar manualmente cuando el kit evoluciona).

## Uso — un solo comando: `/claudio-agents-kit:setup`

El comando `/setup` acopla el kit a cualquier proyecto. Detecta en qué estado está el directorio actual y ramifica solo:

| Estado del CWD | Qué hace |
|---|---|
| Vacío o solo `.git` sin commits | **Rama A — Nuevo**: pregunta nombre, tipo (platform / proposal / portfolio / automation / data) y destino. Scaffoldea estructura de carpetas, `CLAUDE.md`, `README.md`, `.gitignore`, `STYLE.md` si aplica, y hace `git init` + commit inicial. |
| Ya tiene `CLAUDE.md` | **Rama B — Enriquecer**: lee el CLAUDE.md, diagnostica secciones faltantes o inconsistentes (ej: declarás Python pero hay `package.json`), propone `Edit` puntuales con confirmación. Nunca sobrescribe. |
| Tiene código (`pyproject.toml` / `package.json` / `src/`) pero sin `CLAUDE.md` | **Rama C — Adoptar**: lee README y manifests, infere tipo (con señales como "React + Vite" → platform/portfolio; "pyproject + notebooks/" → data), propone tipo, genera CLAUDE.md con el stack real detectado. |

Después del setup, primer mensaje recomendado:

> *"Leé el CLAUDE.md y llamá a `discovery-agent` para arrancar"*

o directo:

> *"@orquestador: <brief>"*

## Contenido del kit

### 19 agentes

**Core (siempre activos)**: `orquestador`, `documentador`, `limpiador`, `optimizador`.

**Planning**: `discovery-agent`, `product-analyst`, `project-manager`, `design-researcher`.

**Expertos técnicos (opt-in por proyecto)**: `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`.

**Productividad y revisión**: `prompt-optimizer` — convierte prompts en crudo a prompts optimizados según el sistema de 6 modos. `code-council` — convoca consejo de expertos técnicos para evaluar cambios complejos o decisiones de arquitectura cruzadas.

**Meta**: `agent-manager` — gestiona el ciclo de vida de agentes/skills del marketplace (crear/modificar/remover con bump + CHANGELOG + commit). Solo opera dentro de este repo.

### 14 skills

Convenciones y patrones reusables: `commit-message-format`, `git-flow`, `pytest-style`, `docstring-google-style`, `pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `react-query-patterns`, `epic-user-story-format`, `proposal-writing`, `consultora-branding-lookup`, `design-inspiration-lookup`, `presentation-inspiration-lookup`, `prospect-branding-lookup`.

### 5 templates de proyecto

Un `CLAUDE.md` diferenciado por tipo: `platform`, `proposal`, `portfolio-website`, `automation`, `data-analysis`. El comando `/setup` los usa como base.

## Actualizar el kit en tus máquinas

```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

Si linkeaste con `ln -sf`, el CLAUDE.md global se actualiza solo.

## Evolucionar el kit (solo dentro de este repo)

Dentro del repo del marketplace, pedile al meta-agente:

```
> Usá agent-manager para crear un agente llamado sales-expert que analice pipelines de ventas
```

`agent-manager` hace todo el bookkeeping: crea desde plantilla, valida frontmatter, bumpea `plugin.json` + `marketplace.json`, actualiza `CHANGELOG.md`, commitea con Conventional Commits y pushea a una branch.

Reglas de versionado (SemVer):
- **MAJOR** (3.x → 4.0): cambio que rompe flujos existentes (ej: rename de slash command).
- **MINOR** (3.0 → 3.1): agente/skill nuevo sin romper.
- **PATCH** (3.1.0 → 3.1.1): typos, ajustes menores de descripción.

**Importante**: si no bumpeás versión, los consumidores no ven el cambio (caching por versión).

## Estructura del repo

```
claudio-enterprises/
├── .claude-plugin/
│   └── marketplace.json          ← índice público del marketplace
├── plugins/
│   └── claudio-agents-kit/
│       ├── .claude-plugin/plugin.json
│       ├── agents/               ← 17 .md
│       ├── skills/               ← 14 carpetas con SKILL.md
│       ├── commands/setup.md     ← único slash command
│       ├── scripts/setup.sh      ← invocado por setup.md en Rama A
│       ├── templates/
│       │   ├── CLAUDE-global.md
│       │   ├── STYLE.md
│       │   └── project-types/    ← 5 templates
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

**"El slash command `/setup` no funciona"** → el script `scripts/setup.sh` puede haber perdido el bit ejecutable:

```bash
chmod +x plugins/claudio-agents-kit/scripts/setup.sh
git update-index --chmod=+x plugins/claudio-agents-kit/scripts/setup.sh
git commit -m "fix: restore executable bit"
```

**"Los agentes no aparecen en `/agents`"** → los `.md` tienen que estar directo en `plugins/claudio-agents-kit/agents/`, no en subcarpetas.

## Versionado público

El CHANGELOG sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Cada release incluye migration notes cuando rompe algo.

Versión actual: **4.1.0** (ver `CHANGELOG.md`).

# Changelog

Todos los cambios notables del plugin `claudio-agents-kit` se registran acá.

El formato sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
y el versionado sigue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.1.0] — 2026-04-18

### Added
- **Meta-agente `agent-manager`** — gestiona el ciclo de vida de agentes y skills del marketplace (crear desde plantilla, listar/auditar, modificar, renombrar, remover con limpieza). Maneja bump SemVer de `plugin.json` y `marketplace.json`, actualiza `CHANGELOG.md` y crea commits con formato Conventional Commits.
- **Plantillas de scaffolding** en `templates/`:
  - `agent-template.md` — estructura base para crear un agente nuevo.
  - `skill-template.md` — estructura base para crear una skill nueva.
- **`CLAUDE.md` raíz del repo** — reglas para cuando Claude Code trabaja DENTRO del marketplace (convenciones del plugin, cómo bumpear, invocar agent-manager).
- Campo `version` en `plugin.json` (antes solo estaba en `marketplace.json`).

### Changed
- `templates/CLAUDE-global.md` refinado:
  - Stack desglosado en Python / Node-TS / SQL / Infra (antes mezclado).
  - Agregado `agent-manager` a la lista de agentes del equipo.
  - Nota sobre MCPs no conectados.

---

## [2.0.0] — 2026-04-18

### Added
- **3 agentes de planning**:
  - `discovery-agent` — interroga con una pregunta por turno, 7 capas de discovery
  - `product-analyst` — descompone en Epic → User Story → Test Case (nivel intermedio)
  - `design-researcher` — consulta vault Notion para inspiración visual
- **3 skills nuevas**:
  - `epic-user-story-format` — formato de artefactos de producto
  - `design-inspiration-lookup` — cómo consultar vault de Notion
  - `proposal-writing` — estructura de propuestas comerciales
- **5 templates de proyecto** (uno por tipo): `platform`, `proposal`, `portfolio-website`, `automation`, `data-analysis`
- **Slash command** `/claudio-agents-kit:new-project` para scaffolding guiado
- **Script** `new-project.sh` con `${CLAUDE_PLUGIN_ROOT}` para portabilidad

### Changed
- Los agentes core crecieron de 4 a 7
- `new-project.sh` ahora requiere argumento `<tipo>` además de `<nombre>`
- Estructura de carpetas de cada tipo de proyecto diferenciada (data tiene `data/raw`, automation tiene `.github/workflows/`, etc.)

### Migration from v1
Si estabas usando el kit v1 via `install.sh` manual:
1. Remover agentes viejos de `~/.claude/agents/` (backup antes)
2. Instalar el plugin desde el marketplace
3. Copiar `templates/CLAUDE-global.md` del plugin a `~/.claude/CLAUDE.md`

---

## [1.0.0] — 2026-04-18 (pre-plugin)

### Added
- 4 agentes core: `orquestador`, `documentador`, `limpiador`, `optimizador`
- 8 expertos: `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`
- 8 skills: `pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `pytest-style`, `react-query-patterns`, `git-flow`, `docstring-google-style`, `commit-message-format`
- Template CLAUDE-global.md y template genérico por proyecto
- Scripts `install.sh` y `new-project.sh`

### Notes
Distribuído como ZIP con `install.sh` manual. Reemplazado por plugin en v2.0.0.

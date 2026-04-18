# Claudio Agents Kit

Equipo reutilizable de agentes, skills y templates para Claude Code. Empaquetado como plugin para instalación y actualización vía GitHub.

## Qué trae

**15 agentes**
- Core (7): `orquestador`, `documentador`, `limpiador`, `optimizador`, `discovery-agent`, `product-analyst`, `design-researcher`
- Expertos (8): `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`

**11 skills reutilizables**
`pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `pytest-style`, `react-query-patterns`, `git-flow`, `docstring-google-style`, `commit-message-format`, `epic-user-story-format`, `design-inspiration-lookup`, `proposal-writing`

**5 templates de proyecto** (via slash command)
`platform` · `proposal` · `portfolio` · `automation` · `data`

**1 slash command**
`/claudio-agents-kit:new-project` — scaffolda proyecto nuevo por tipo

## Distribución de modelos

| Modelo | Agentes |
|---|---|
| Opus | data-expert, backend-expert, frontend-expert, devops-expert |
| Sonnet | orquestador, optimizador, qa-expert, db-architect, security-auditor, discovery-agent, product-analyst, design-researcher |
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

## Changelog

Ver `CHANGELOG.md` en el root del marketplace.

# CLAUDE.md — Configuración global de Claudio-Enterprises (v2)

Este archivo vive en `~/.claude/CLAUDE.md` y se aplica a TODOS mis proyectos salvo que el CLAUDE.md de un proyecto específico lo sobrescriba.

## Quién soy

Soy Claudio, Business Analyst y especialista en Data Science. Trabajo solo, armando proyectos para PyMES. Mi agencia se llama Claudio-Enterprises. Trabajo en 5 tipos de proyecto con frecuencias distintas:

1. **Platform as a Service** (full-stack) — el más frecuente
2. **Propuestas comerciales / cotizaciones**
3. **Portfolio websites** (creativos / profesionales)
4. **Automatizaciones Python**
5. **Data analysis / reportes**

## Stack preferido

### Python (principal para data + backend)
- **Gestor**: uv (preferido) o poetry
- **Data**: Pandas primero, Polars si >5M filas
- **Backend**: FastAPI + SQLAlchemy async
- **Testing**: pytest, pytest-asyncio
- **Lint/format**: ruff (reemplaza black + isort + flake8)

### Node / TypeScript (frontend + scripts)
- **Gestor**: pnpm
- **Frontend**: React + Vite + Tailwind + TanStack Query (o Astro para sitios de contenido)
- **Scripts**: tsx para ejecutar TS directamente (sin compilar)
- **Testing**: Vitest + React Testing Library
- **Lint/format**: eslint + prettier (configs compartidas via preset)

### SQL / DB
- **Principal**: PostgreSQL 15+
- **Migraciones**: Alembic (Python) o Prisma (Node)
- **Convenciones**: snake_case en DB, CTEs para queries complejas, índices por acceso real (ver skill `postgres-query-patterns`)

### Infra
- **Deploy**: Cloudflare Pages (frontend) + Fly.io/Railway (backend) + GitHub Actions
- **Secrets**: `.env.local` nunca commiteado, `.env.example` en el repo

## Mi equipo de agentes

### Core (siempre activos)
- `orquestador` — punto de entrada, delega
- `documentador` — docs, README, CHANGELOG
- `limpiador` — refactor para legibilidad
- `optimizador` — performance, N+1, Pandas, SQL

### Agentes de planning
- `discovery-agent` — fuerza clarificar antes de construir (tipo "Grill Me")
- `product-analyst` — Epics / User Stories / Test Cases (nivel intermedio)
- `design-researcher` — consulta vault Notion para inspiración visual

### Biblioteca de expertos (opt-in por proyecto)
- `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`
- `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`

### Meta (gestión del kit)
- `agent-manager` — crea/modifica/remueve agentes y skills del marketplace con bump + CHANGELOG + commit. Invocar solo cuando trabajás en el repo del marketplace.

Cada proyecto tiene su propio `CLAUDE.md` (copiado de un template según tipo de proyecto) que lista qué agentes están activos.

## Vault de Notion (inspiración visual)

- Organización: por proyecto/referencia (no por tipo de recurso)
- Cómo consultarlo: skill `design-inspiration-lookup`
- Quién lo consulta: `design-researcher` antes de que frontend arranque

## Flujo de trabajo por tipo de proyecto

### Platform (PaaS)
```
discovery-agent → product-analyst → design-researcher (si hay UI) →
expertos técnicos → limpiador → optimizador → qa-expert →
security-auditor → documentador → client-reporter (update semanal)
```

### Proposal
```
discovery-agent (mini) → client-reporter (redacta propuesta) → Claudio revisa → envía
```

### Portfolio website
```
discovery-agent → design-researcher (CRÍTICO) → Claudio aprueba dirección →
frontend-expert → devops-expert (Cloudflare) → client-reporter (manual)
```

### Automatización Python
```
discovery-agent (mini) → data-expert / backend-expert → devops-expert (scheduler) →
qa-expert (tests básicos) → documentador
```

### Data analysis
```
discovery-agent → data-expert (EDA) → Claudio aprueba supuestos →
data-expert (análisis) → documentador (diccionario/supuestos) → client-reporter (resumen ejecutivo)
```

## Reglas globales para todos los agentes

1. **Español en comunicación conmigo, idioma del proyecto en código/docs.**
2. **Nunca ejecutar algo destructivo sin confirmación explícita.** (drop de tabla, force push, rm -rf, deploy a prod, envío de email al cliente).
3. **Discovery antes que código.** Todo proyecto arranca con `discovery-agent`, aunque sea mini.
4. **Skills antes que reinventar.** Si hay skill relevante, úsenla.
5. **Preguntas > asumir.** Ambigüedad se clarifica, no se adivina.
6. **Commits atómicos y mensajes según `commit-message-format`.**
7. **Nunca commitear secrets.**
8. **Para proyectos PaaS**: usar formato Epic/US/TC (skill `epic-user-story-format`).
9. **Moodboard antes de CSS.** En cualquier proyecto con UI significativa, consultar vault Notion antes de escribir HTML.

## Conectores MCP habituales

- **GitHub**: repos, PRs, issues, workflows
- **Notion**: brief de proyectos, vault de inspiración, updates
- **Gmail**: comunicación con clientes
- **PostgreSQL**: cuando esté disponible, queries directas a DBs de proyectos

Si un agente necesita un MCP que no está conectado, lo avisa; nunca inventa respuestas.

## Memoria de agentes

Todos los agentes usan `memory: user` — acumulan aprendizajes entre sesiones (patrones del código, convenciones específicas que voy adoptando, preferencias visuales recurrentes).

## Tipos de proyecto y sus templates

Al crear un proyecto nuevo con `new-project.sh`, elegís el tipo y se copia el template correcto:

| Tipo | Template | Agentes clave |
|---|---|---|
| platform | `platform.md` | discovery + product-analyst + todos los técnicos |
| proposal | `proposal.md` | discovery (mini) + client-reporter |
| portfolio | `portfolio-website.md` | discovery + design-researcher + frontend + devops |
| automation | `automation.md` | discovery (mini) + data/backend + devops + qa |
| data | `data-analysis.md` | discovery + data-expert + client-reporter + documentador |

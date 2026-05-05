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
- **Deploy frontend**: Vercel (default actual) — alternativas: Cloudflare Pages, Netlify
- **Deploy backend**: Fly.io / Railway (si requiere DB persistente o workers largos)
- **CI**: GitHub Actions; Vercel ya corre previews automáticos en cada PR
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
- `project-manager` — convierte comentarios sueltos en sprints, mantiene `PROJECT_QUEUE.md` en la raíz del proyecto (inbox → backlog → sprint actual → hecho)
- `design-researcher` — consulta vault Notion para inspiración visual

### Biblioteca de expertos (opt-in por proyecto)
- `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`
- `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`

### UX/UI review (opt-in en proyectos con UI)
- `navigator` — audita el flujo de navegación entre páginas: mapa de rutas (declaradas vs alcanzables vs huérfanas), recorrido de flujos críticos, prueba de "back" y "refresh", detección de dead-ends, loops, breadcrumbs rotos, profundidad excesiva. Output: lista priorizada de recomendaciones accionables. Invocar cuando un proyecto con UI llega a estado funcional, antes del QA final.
- `ui-reviewer` — crítico visual de una página individual (screenshot, URL o código JSX). Evalúa uso del espacio, densidad informativa, jerarquía visual, consistencia de tokens. Detecta cosas como "panel gigante con 2 KPIs adentro" o "5 niveles de gris arbitrarios" y propone reorganización concreta del layout. Una página por invocación.

### Productividad y revisión
- `prompt-optimizer` — recibe un prompt en crudo y devuelve prompt(s) optimizados listos para copiar/pegar, según el sistema de 6 modos (`templates/prompt-system-reference.md`). Invocar cuando armás un mensaje difuso o mezclás varios items en un solo prompt.
- `code-council` — convoca un consejo de expertos técnicos (backend, frontend, db, devops, security, qa, performance) para evaluar cambios complejos o decisiones de arquitectura cruzadas; emite veredicto consolidado con votos individuales y próximos pasos. Invocar cuando un cambio toca 2+ dominios o querés validar el approach antes de codear.

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
frontend-expert → devops-expert (Vercel por default) → client-reporter (manual)
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
10. **Reporte post-cambio obligatorio.** Todo turno que modifica archivos cierra con el bloque "Cambios aplicados" (commits + archivos + cómo replicar). Ver sección dedicada más abajo.

## Reporte post-cambio (obligatorio)

Cada vez que cualquier agente (o Claude directamente) termina un cambio que toca archivos del proyecto, debe cerrar el turno con este reporte. No es opcional; no es negociable.

### Formato

El reporte se escribe en **Markdown normal**, NO envuelto en un bloque de código. Razón: así la prosa queda legible y cada comando copiable va en su propio bloque (o inline con backticks simples) y se renderiza con botón de copiar. Si envolvés todo en triple-backticks, se invierte: la prosa queda monoespaciada y los comandos no son copiables.

Estructura exacta (pegá esta plantilla y completala en Markdown plano):

> **📦 Cambios aplicados**
>
> **Commits**
> - `<hash corto>` &lt;mensaje&gt;
> - `<hash corto>` &lt;mensaje&gt;
>
> (si no hubo commits todavía, escribir "ninguno (cambios sin commitear)")
>
> **Archivos modificados**
> - `<ruta>` (+N −M)
> - `<ruta>` (creado)
> - `<ruta>` (borrado)
>
> **Cómo replicar en el ambiente**
> 1. (Terminal) `<comando copiable>`
> 2. (GitHub web) &lt;acción manual con URL&gt;
> 3. (PowerShell) `<comando copiable>`

Reglas de formato:
- Encabezados como `## 📦 Cambios aplicados` y `### Commits` en Markdown real (no dentro de un fence).
- **Comandos**: backticks inline (`` `git pull` ``) para uno corto, o fenced code block con lenguaje (` ```bash ... ``` `) para bloques multilínea.
- **Prosa**: texto plano, listas con `-`, numeración con `1.`.
- **Nunca** envolver todo el reporte en un fence exterior.

### Cómo armar cada sección

**Commits** — `git log <base>..HEAD --oneline` desde el último punto conocido (por defecto, los commits de este turno).

**Archivos modificados** — `git diff --stat <base>..HEAD` para cambios commiteados, o `git status --short` para cambios sin commiteados.

**Cómo replicar** — pensá el camino más corto desde que el cambio está en el branch hasta que corre en donde tiene que correr. **Para cada paso indicá SIEMPRE la terminal/herramienta donde correrlo** entre paréntesis al principio: `(Git Bash)`, `(PowerShell)`, `(CMD)`, `(WSL)`, `(zsh/bash en macOS/Linux)`, `(Docker Desktop)`, `(navegador)`, `(Claude Code CLI)`. Si el paso es GUI (ej: crear PR en GitHub), decilo explícito: `(GitHub web)`.

Ejemplo bien formateado (Markdown real, sin fence exterior):

**Cómo replicar en el ambiente**
1. (GitHub web) mergear PR → https://github.com/xguilxr/foo/pull/123
2. (Git Bash o WSL) `git pull origin main`
3. (PowerShell, desde la raíz del proyecto) `pnpm install` si cambió el lockfile
4. (Git Bash) `uv sync` si cambió `pyproject.toml`
5. (PowerShell) `pnpm dev` para levantar el front (puerto 5173)
6. (Claude Code CLI, en otra ventana) reiniciar sesión para recargar CLAUDE.md

Ejemplos de pasos típicos por situación:

| Situación | Pasos típicos |
|---|---|
| Cambio de código backend (FastAPI) en dev | `git pull`, reinstalar deps si cambió `pyproject.toml` (`uv sync`), reiniciar `uvicorn` |
| Cambio de frontend (Vite/React) | `git pull`, `pnpm install` si cambió lockfile, reiniciar `pnpm dev` |
| Cambio de DB schema | `git pull`, correr migración (`alembic upgrade head` o `prisma migrate deploy`), reiniciar backend |
| Cambio que ya está en branch y falta merge | Armar PR: `gh pr create ...` (o dar URL), esperar CI, merge a `develop`/`main` |
| Cambio con dependencias nuevas | Mencionar el gestor exacto (`uv sync`, `pnpm install`, `cargo build`) |
| Cambio de config de env (`.env`) | Listar las variables nuevas/modificadas con un ejemplo de valor |
| Deploy a prod | Tag + push del tag si dispara CD, o pasos manuales |
| Sin impacto en runtime (solo docs) | "Ninguno — solo documentación" |

### Reglas

- **Pasos específicos, no genéricos.** "Reiniciar el server" no sirve; `pkill -f uvicorn && uv run uvicorn app.main:app --reload` sí.
- **Un paso por línea, en orden de ejecución.**
- **Cada paso arranca con la terminal/herramienta entre paréntesis.** Si un comando funciona en varias (ej: git), listar las compatibles: `(Git Bash o PowerShell)`.
- **Si hay más de un ambiente a actualizar** (dev + staging + prod), separar en bloques.
- **Si el cambio está en una branch sin merge**, el primer paso SIEMPRE es el PR (URL o comando para crearlo).
- **Nunca inventes pasos.** Si no sabés cómo se despliega un proyecto, preguntá y registrá la respuesta en el `CLAUDE.md` del proyecto para la próxima.

### Cuándo NO emitir el reporte

- El turno fue solo lectura (exploración, preguntas) y no se modificó nada.
- El usuario está en un diálogo de discovery y el reporte interrumpe el flujo.

## Conectores MCP habituales

- **GitHub**: repos, PRs, issues, workflows
- **Notion**: brief de proyectos, vault de inspiración, updates
- **Gmail**: comunicación con clientes
- **PostgreSQL**: cuando esté disponible, queries directas a DBs de proyectos

Si un agente necesita un MCP que no está conectado, lo avisa; nunca inventa respuestas.

## Memoria de agentes

Todos los agentes usan `memory: user` — acumulan aprendizajes entre sesiones (patrones del código, convenciones específicas que voy adoptando, preferencias visuales recurrentes).

## Tipos de proyecto y sus templates

Al acoplar el kit a un proyecto con `/claudio-agents-kit:setup` (sea nuevo, con CLAUDE.md previo, o adoptando un repo existente con código), elegís o confirmás el tipo y se copia / enriquece el template correcto:

| Tipo | Template | Agentes clave |
|---|---|---|
| platform | `platform.md` | discovery + product-analyst + todos los técnicos |
| proposal | `proposal.md` | discovery (mini) + client-reporter |
| portfolio | `portfolio-website.md` | discovery + design-researcher + frontend + devops |
| automation | `automation.md` | discovery (mini) + data/backend + devops + qa |
| data | `data-analysis.md` | discovery + data-expert + client-reporter + documentador |

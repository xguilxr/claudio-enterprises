# CLAUDE.md — Configuración global de Claudio-Enterprises (v3)

Este archivo vive en `~/.claude/CLAUDE.md` y se aplica a TODOS mis proyectos salvo que el
CLAUDE.md de un proyecto lo sobrescriba.

**Es contexto permanente: se paga en cada turno de cada sesión.** Lo que se use a veces no va
acá, va en una skill (MCA CTX-01, CTX-02). Si algo de este archivo no cambia una decisión en
la mayoría de las sesiones, sobra.

## Quién soy

Soy Claudio, Business Analyst y especialista en Data Science. Trabajo solo, armando proyectos
para PyMES. Mi agencia se llama Claudio-Enterprises. Cinco tipos de proyecto:

1. **Platform as a Service** (full-stack) — el más frecuente
2. **Propuestas comerciales / cotizaciones**
3. **Portfolio websites**
4. **Automatizaciones Python**
5. **Data analysis / reportes**

## Stack preferido

- **Python**: uv (preferido) o poetry · Pandas, Polars si >5M filas · FastAPI + SQLAlchemy
  async · pytest · ruff
- **Node/TypeScript**: pnpm · React + Vite + Tailwind + TanStack Query, o Astro para
  contenido · tsx · Vitest · eslint + prettier
- **SQL**: PostgreSQL 15+ · Alembic o Prisma · snake_case, CTEs, índices por acceso real
- **Infra**: Vercel (front) · Fly.io / Railway (back con DB o workers) · GitHub Actions ·
  `.env.local` nunca commiteado, `.env.example` sí

## Cómo trabajo con el kit

**No hay agentes.** Los 22 se retiraron en la v6.0.0 del kit: uno solo superó la rúbrica de
autonomía y los otros 21 se descompusieron en skills. Todo lo que se invoca es una skill.

Las del kit llevan el prefijo del plugin: **`/claudio-agents-kit:<nombre>`**. Sin el prefijo,
Claude Code responde `Unknown command` — `/nombre` a secas solo resuelve skills locales del
proyecto, en `.claude/skills/`. Lo normal igual es pedirlo en prosa: cada skill tiene su
`description` escrita para activar sola.

Las cuatro que uso todo el tiempo:

| Quiero… | Skill |
|---|---|
| Saber en qué estado está un proyecto | `auditar-proyecto` |
| Que Claude trabaje bien en un repo | `andamiaje-entorno` |
| Ver qué tiene un repo que no conozco | `quick-scan` |
| Encuadrar lo que un cliente pide | `encuadrar-encargo` |

`andamiaje-entorno` es la que monta un proyecto: escribe su `CLAUDE.md`, define los comandos
de verificación y **copia al proyecto solo las skills de stack que le correspondan**. Las de
stack —pytest, FastAPI, Pandas, git-flow, formato de commits— viven en `plantillas-skill/` y
no se cargan nunca desde el kit: un proyecto de datos no paga el contexto de React.

El inventario completo de skills está en `docs/README.md` §4 del repo del marketplace.

## Reglas globales

1. **Español conmigo, idioma del proyecto en código y docs.**
2. **Nada destructivo sin confirmación explícita**: drop de tabla, force push, `rm -rf`,
   deploy a prod, envío de email a un cliente.
3. **Preguntas > asumir.** La ambigüedad se clarifica, no se adivina.
4. **Skills antes que reinventar.** Si hay una skill que aplica, se usa.
5. **Commits atómicos** en Conventional Commits.
6. **Nunca commitear secrets.**
7. **Evidencia o nada.** Un control que existe y no corre es PARCIAL, nunca CONFORME. Lo no
   verificado se marca como tal.
8. **Reporte post-cambio obligatorio.** Todo turno que modifica archivos cierra con el bloque
   de abajo.

## Reporte post-cambio (obligatorio)

Cada vez que Claude termina un cambio que toca archivos del proyecto, cierra el turno con
este reporte. No es opcional.

### Formato

Se escribe en **Markdown normal, NO envuelto en un bloque de código.** Razón: así la prosa
queda legible y cada comando copiable va en su propio bloque (o inline con backticks) y se
renderiza con botón de copiar. Si envolvés todo en triple-backticks se invierte: la prosa
queda monoespaciada y los comandos no se pueden copiar.

Estructura exacta:

> **📦 Cambios aplicados**
>
> **Commits**
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

Reglas de formato:

- Encabezados como `## 📦 Cambios aplicados` y `### Commits` en Markdown real, no dentro de
  un fence.
- **Comandos**: backticks inline para uno corto, o fenced block con lenguaje para varios.
- **Prosa**: texto plano, listas con `-`, numeración con `1.`.
- **Nunca** envolver todo el reporte en un fence exterior.

### Cómo armar cada sección

**Commits** — `git log <base>..HEAD --oneline` desde el último punto conocido.

**Archivos modificados** — `git diff --stat <base>..HEAD` si está commiteado, o
`git status --short` si no.

**Cómo replicar** — el camino más corto desde que el cambio está en la rama hasta que corre
donde tiene que correr. **Cada paso arranca con la terminal o herramienta entre paréntesis**:
`(Git Bash)`, `(PowerShell)`, `(CMD)`, `(WSL)`, `(zsh/bash)`, `(Docker Desktop)`,
`(navegador)`, `(Claude Code CLI)`. Si es GUI, decilo: `(GitHub web)`.

Ejemplo bien formateado:

**Cómo replicar en el ambiente**
1. (GitHub web) mergear PR → https://github.com/xguilxr/foo/pull/123
2. (Git Bash o WSL) `git pull origin main`
3. (PowerShell, desde la raíz) `pnpm install` si cambió el lockfile
4. (PowerShell) `pnpm dev` para levantar el front (puerto 5173)

Pasos típicos por situación:

| Situación | Pasos típicos |
|---|---|
| Backend FastAPI en dev | `git pull`, `uv sync` si cambió `pyproject.toml`, reiniciar `uvicorn` |
| Frontend Vite/React | `git pull`, `pnpm install` si cambió el lockfile, reiniciar `pnpm dev` |
| Cambio de schema | `git pull`, `alembic upgrade head` o `prisma migrate deploy`, reiniciar backend |
| Falta merge | Primer paso siempre el PR: URL o comando para crearlo |
| Dependencias nuevas | Nombrar el gestor exacto: `uv sync`, `pnpm install` |
| Config de env | Listar las variables nuevas con un ejemplo de valor |
| Cambio en el kit | `claude plugin marketplace update && claude plugin update claudio-agents-kit`, **con Claude Code cerrado** |
| Solo documentación | "Ninguno — solo documentación" |

### Reglas

- **Pasos específicos, no genéricos.** "Reiniciar el server" no sirve;
  `pkill -f uvicorn && uv run uvicorn app.main:app --reload` sí.
- **Un paso por línea, en orden de ejecución.**
- **Si hay más de un ambiente** (dev + staging + prod), separar en bloques.
- **Si el cambio está en una rama sin merge**, el primer paso es siempre el PR.
- **Nunca inventes pasos.** Si no sabés cómo se despliega un proyecto, preguntá y registrá la
  respuesta en el `CLAUDE.md` de ese proyecto.

### Cuándo NO emitirlo

- El turno fue solo lectura y no se modificó nada.
- Estamos en discovery y el reporte corta el flujo.

## Conectores MCP habituales

GitHub (repos, PRs, issues) · Notion (briefs, vault, updates) · Gmail (clientes) ·
PostgreSQL cuando esté disponible.

Si falta un MCP que hace falta, Claude lo avisa. Nunca inventa la respuesta.

# CLAUDE.md — claudio-enterprises

Dos cosas viven acá:

- **`docs/`** — la familia de marcos: **MFB** (cómo se construye un marco), **MCC**
  (consultoría), **MCS** (software), **MCA** (entorno agéntico). Es el contenido normativo.
- **`plugins/claudio-agents-kit/`** — el plugin que los pone a trabajar: skills de marco,
  plantillas de proyecto, corpus y un rol.

Si tu tarea no toca ninguna de las dos, estás en el repo equivocado.

## Economía de tokens

**Es una filosofía del repo, no una preferencia de estilo.** Aplica a lo que se escribe y a
cómo se contesta.

- Frases cortas, voz activa, sin decoración. Nada de repetir lo ya dicho en el mismo turno.
- No cargues un marco completo para responder una pregunta. `docs/ORQUESTADOR.md` rutea por
  nivel: L0 nada, L1 instrucciones, L2 la guía del marco, L3 la normativa.
- Este archivo es contexto permanente: se paga en cada turno de cada sesión. **Presupuesto
  declarado: 5 000 caracteres.** Lo que se use a veces no vive acá (MCA CTX-01, CTX-02).
- Nada de cifras ni inventarios que deriven del contenido real. Los conteos viven en
  `docs/README.md` y se verifican ahí (MCA CTX-03).

## Estructura del plugin

```
plugins/claudio-agents-kit/
├── .claude-plugin/plugin.json    ← metadata + versión
├── skills/<name>/SKILL.md        ← skills para operar los marcos de ESTE repo
├── plantillas-skill/<name>/      ← skills de stack, para copiar a proyectos
├── corpus/<name>.md              ← conocimiento de referencia, no procedimiento
├── roles/<name>/AGENT.md         ← rol + catálogo, permisos, traza y evaluación
└── templates/                    ← plantillas de proyecto y CLAUDE-global.md
```

Un **rol** es lo que supera la rúbrica de autonomía de MCS-G04 track E. Todo lo demás es
skill, plantilla o corpus. Hoy hay un solo rol.

## Cómo se cambia el contenido

La skill `mantener-marketplace` enruta a este procedimiento; el procedimiento es este
(TRZ-02: un hecho vive en un solo documento).

1. **Rama dedicada.** `git checkout -b claude/<tema>`. Nunca directo a `main`.
2. **Plantilla, no folio en blanco.** `docs/mfb/plantillas/`: T01 normativa · T02 guía ·
   T03 prompt · T04 operativa · T05 skill · T06 ADR.
3. **Validar el frontmatter** antes de escribir. Esquema en `docs/CONVENCIONES.md`.
4. **Buscar referencias antes de renombrar o quitar** algo: `docs/`, `README.md` y
   `templates/CLAUDE-global.md`.
5. **Bumpear versión** en `plugin.json` **y** `.claude-plugin/marketplace.json`. Sin bump,
   el caché deja a los consumidores en la versión vieja.
6. **`CHANGELOG.md`** con fecha y entrada Keep a Changelog.
7. **Probar**: `claude plugin marketplace add $(pwd) && claude plugin install claudio-agents-kit`
8. **Commit en Conventional Commits** y `git push -u origin <rama>`.

| Cambio | Bump |
|---|---|
| Typo, ajuste de descripción | PATCH |
| Skill, plantilla o documento nuevo, sin romper | MINOR |
| Renombrar o quitar algo existente; cambio que rompe flujos | MAJOR |

## Formato

```yaml
# skills/<name>/SKILL.md
---
name: <kebab-case>
description: <qué hace y cuándo usarla, en las palabras de quien la necesita (MFB ACT-04)>
---
```

```yaml
# roles/<name>/AGENT.md
---
name: <kebab-case>
description: <cuándo delegarle una tarea>
model: sonnet | opus | haiku
version: <semver>
estado: candidato | vigente
---
```

Un rol exige además catálogo, límites, traza y evaluación: MCA dominio AUT.

## Reporte post-cambio (obligatorio)

Cuando modifiques archivos, cerrás el turno con un reporte en **Markdown plano — nunca
envuelto en un fence exterior**. Envolverlo todo deja la prosa monoespaciada y los comandos
sin poder copiarse: se invierte el efecto.

Secciones: **Cambios aplicados** · **Commits** (`hash` + mensaje) · **Archivos modificados**
(ruta, +N −M) · **Cómo replicar** (PR si falta merge; `claude plugin marketplace update &&
claude plugin update claudio-agents-kit`; recopiar `CLAUDE-global.md` si cambió).

Comandos en backticks o en bloque con lenguaje. Regla completa en
`plugins/claudio-agents-kit/templates/CLAUDE-global.md`.

## No hacer

- ❌ Tocar `plugin.json` o `marketplace.json` sin bumpear.
- ❌ Quitar o renombrar algo sin buscar sus referencias primero.
- ❌ Declarar conformidad sin evidencia ejecutada. Un control que existe y no corre es
  PARCIAL, nunca CONFORME.
- ❌ Inventar requisitos, normas o rutas. Lo no verificado se marca como tal (TRZ-09).
- ❌ Commits fuera de Conventional Commits.
- ❌ Push directo a `main`. Siempre rama + PR.

## Stack por defecto

- **Python**: pytest, ruff, uv (preferido) o poetry
- **Node/TypeScript**: pnpm, vitest, eslint, prettier, tsx
- **SQL**: PostgreSQL 15+, SQLAlchemy async desde Python
- **MCP**: GitHub, Notion, Gmail, PostgreSQL cuando esté disponible

Una skill nueva respeta este stack. Otro stack va como plantilla opt-in en
`plantillas-skill/`.

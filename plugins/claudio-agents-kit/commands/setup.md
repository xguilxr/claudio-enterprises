---
description: Acopla el marketplace claudio-agents-kit a un proyecto, sea nuevo o existente. Detecta el estado del CWD (repo vacío, repo con CLAUDE.md, repo con código sin CLAUDE.md), pregunta lo mínimo necesario (tipo de proyecto, nombre, stack si no es detectable), y genera o enriquece el CLAUDE.md acoplando los agentes correctos. Nunca sobrescribe datos del usuario sin confirmación explícita.
---

# /claudio-agents-kit:setup — Acoplar agentes al proyecto

Este comando reemplaza al antiguo `/new-project` y unifica 3 escenarios en un solo flujo.

## Tu rol

Sos el asistente de setup del kit. Tu trabajo es dejar el proyecto listo para que Claudio arranque a trabajar con los agentes correctos, sin pedirle que repita información que ya existe en el repo.

**Regla innegociable**: nunca sobrescribís archivos del usuario sin mostrarle el cambio propuesto y recibir un "sí" explícito. Para modificar `CLAUDE.md` existente, usá `Edit` con `old_string`/`new_string` en secciones puntuales; nunca `Write` sobre un CLAUDE.md ya presente.

## Paso 1 — Detectar el estado del CWD

Usá `Bash` / `Glob` / `Read` para relevar en paralelo:

- `ls -la` de la raíz — hay `.git`? ¿cuántos archivos hay?
- `Glob` para: `CLAUDE.md`, `README.md`, `pyproject.toml`, `package.json`, `requirements.txt`, `Cargo.toml`, `go.mod`, `vite.config.*`, `next.config.*`, `astro.config.*`, `.claude/settings.json`, `.claude-plugin/`
- Si `.git` existe: `git log --oneline -5` para ver si tiene historia

Con ese relevo, clasificá el proyecto en una de 3 ramas:

| Rama | Condición | Estado |
|---|---|---|
| **A — Nuevo** | Dir vacío o solo `.git` sin commits | No hay nada que leer |
| **B — Enriquecer** | Ya existe `CLAUDE.md` en la raíz | Respetar lo escrito, completar huecos |
| **C — Adoptar** | Hay código (manifests, `src/`, `README.md`) pero NO hay `CLAUDE.md` | Inferir tipo del stack y proponer |

Anunciale a Claudio qué rama detectaste, con 1-2 frases del contexto observado. Ejemplo:

> 🔍 Detecté **Rama C (Adoptar)**: hay `package.json` con React + Vite, un `src/` con 8 archivos, `README.md` presente. No existe `CLAUDE.md` en la raíz.

## Paso 2 — Ramificar

### Rama A — Proyecto nuevo

1. Preguntá (una sola vez, todo junto):
   - **Nombre** del proyecto (kebab-case, ej: `farmax-inventario`)
   - **Tipo** — mostrá las 5 opciones con descripción:
     - `platform` — PaaS full-stack (backend + frontend + DB)
     - `proposal` — Propuesta comercial / cotización
     - `portfolio` — Website de portafolio (creativo o profesional)
     - `automation` — Automatización Python (script / scheduled job)
     - `data` — Data analysis / reportes
   - **Carpeta destino** (default: el CWD actual si está vacío; si no, preguntar)

2. Corré el script:

   ```bash
   bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh <nombre> <tipo> <destino>
   ```

3. Saltá al **Paso 3** (reporte final).

### Rama B — Enriquecer CLAUDE.md existente

1. Leé `CLAUDE.md` entero con `Read`.

2. Mapeá lo que tiene contra el template estándar `templates/project-types/<tipo>.md`. Para inferir el tipo actual:
   - Buscá línea `> Tipo de proyecto: **X**` o similar.
   - Si no está explícito, inferilo de las secciones presentes.
   - Si ambiguo, preguntá.

3. Relevá stack real desde manifests (pyproject.toml → Python; package.json → Node + qué deps; etc.).

4. Producí un diagnóstico corto, tipo:

   > **Diagnóstico de tu CLAUDE.md**
   >
   > ✅ Configurado: sección Cliente, Brief, Stack (FastAPI + Postgres).
   > ⚠️ Incompleto: "Métrica de éxito" dice `[número concreto]` (placeholder sin llenar).
   > ❓ Inconsistente: declarás "Python + Pandas" pero hay `package.json` con React. ¿Agrego sección Frontend?
   > 🆕 Faltante: no hay sección "Agentes activos en este proyecto" (la del template actual).

5. Por cada item, preguntá si lo completás/corregís. **Una pregunta por item o agrupadas si son del mismo bloque**. Mostrá el `old_string` / `new_string` concreto antes de cada `Edit`.

6. Si el usuario dice "sí a todo", aplicá los `Edit` en orden. Si dice "solo X e Y", aplicá esos.

7. Si falta la sección "Agentes activos en este proyecto", agregala al final del CLAUDE.md con la lista correspondiente al tipo (ver **Paso 3 — Mapeo tipo→agentes**).

8. Saltá al **Paso 3** (reporte final).

### Rama C — Adoptar repo existente sin CLAUDE.md

1. Leé `README.md` si existe y relevá manifests.

2. Inferí el tipo de proyecto usando estas señales (en orden de prioridad):

   | Señal observada | Tipo propuesto |
   |---|---|
   | `pyproject.toml` + `src/` + `tests/` + `.github/workflows/` | `automation` |
   | `pyproject.toml` + `notebooks/` o `data/` | `data` |
   | `package.json` con React + Vite + `src/pages/` o `src/routes/` | `platform` (frontend) |
   | `package.json` con Astro/Next + `content/` o pocas rutas | `portfolio` |
   | `package.json` backend (express/fastify) + `pyproject.toml` o `package.json` frontend | `platform` (full-stack) |
   | Solo `.md` + `drafts/` + sin código | `proposal` |
   | Ambiguo | Preguntar |

3. Preguntá (agrupadas):
   - **Tipo propuesto: X** — ¿confirmás o elegís otro de los 5?
   - **Nombre del proyecto** — default: el nombre del dir actual.
   - **Cliente / contexto breve** — 1-2 líneas (para la sección "Cliente" del template).

4. Generá `CLAUDE.md` copiando `templates/project-types/<tipo>.md` y reemplazando:
   - `[NOMBRE_PROYECTO]` → nombre confirmado.
   - Sección de **Stack** → llenar con lo detectado desde manifests, no con el stack default del template (ej: si el template dice "FastAPI + Postgres" pero detectaste "Flask + SQLite", escribí Flask + SQLite).
   - Campos del Cliente → lo que respondió Claudio.
   - Dejá los placeholders `[ ]` que Claudio no completó, para que los rellene después.

5. **No** corras `git init` ni hagas commit (el repo ya existe y puede tener su propio flujo). Solo `Write` del `CLAUDE.md`.

6. Si el tipo elegido es `platform` o `portfolio` y no hay `STYLE.md`, preguntá si lo copiás desde `${CLAUDE_PLUGIN_ROOT}/templates/STYLE.md`.

7. Saltá al **Paso 3** (reporte final).

## Paso 3 — Mapeo tipo → agentes (para la sección "Agentes activos")

Fuente de verdad: tabla de `templates/CLAUDE-global.md`. Reusá esta lista cuando generes o enriquezcas la sección del CLAUDE.md del proyecto:

| Tipo | Agentes activos |
|---|---|
| `platform` | `orquestador`, `discovery-agent`, `product-analyst`, `project-manager`, `design-researcher` (si hay UI), `backend-expert`, `frontend-expert`, `db-architect`, `devops-expert`, `qa-expert`, `security-auditor`, `documentador`, `limpiador`, `optimizador`, `client-reporter` |
| `proposal` | `orquestador`, `discovery-agent` (mini), `client-reporter`, `documentador` |
| `portfolio` | `orquestador`, `discovery-agent`, `design-researcher`, `frontend-expert`, `devops-expert`, `documentador`, `client-reporter` |
| `automation` | `orquestador`, `discovery-agent` (mini), `data-expert`, `backend-expert`, `devops-expert`, `qa-expert`, `documentador` |
| `data` | `orquestador`, `discovery-agent`, `data-expert`, `client-reporter`, `documentador` |

En todos los casos, `project-manager` queda disponible cuando Claudio quiera arrancar sprints (no lo pongas como "core siempre activo"; mencionalo como "invocable cuando necesites planificar").

## Paso 4 — Reporte final

Respondé con este formato exacto:

```
✅ Setup listo — <nombre>

Rama ejecutada: <A | B | C>
Tipo: <tipo>
Stack detectado: <lista corta>
Agentes activados: <lista>

Archivos tocados:
- <ruta> (creado | modificado | sin cambios)

Próximos pasos:
1. Invocá @orquestador con tu primer brief para arrancar.
2. Si el alcance está difuso, @discovery-agent te hace preguntas hasta cerrarlo.
3. Si querés planear sprints y mantener un queue, @project-manager lo arranca.
```

Y siempre cerrá con el bloque de **📦 Cambios aplicados** (según la regla global de reporte post-cambio del CLAUDE.md del repo), listando commits si hubo e instrucciones de cómo retomar.

## Reglas estrictas

1. **Nunca** sobrescribís `CLAUDE.md` existente con `Write`. Solo `Edit` puntuales aprobados.
2. **Nunca** asumís el tipo de proyecto en Rama C: siempre mostrás la propuesta y pedís confirmación.
3. **Nunca** corrés `git init` en Rama B o C (el repo ya existe).
4. **Nunca** pisás un `STYLE.md` existente. Si existe y el template ofrece uno, mencionalo pero no copiés.
5. **Una sola pregunta por vez** si son decisiones separadas; **agrupadas** si comparten contexto (ej: nombre+tipo+destino en Rama A).
6. Si detectás stack que NO está en el template estándar (ej: Rust, Go), igual generás el CLAUDE.md pero marcás la sección Stack como `[detectado: <lenguaje> — ajustá convenciones a mano, no hay skill default del kit]`.
7. Si Claudio cancela a mitad del flujo, **no dejás archivos a medias**: o completás el CLAUDE.md mínimo, o no escribís nada.
8. Respondés siempre en **español**.

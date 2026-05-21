---
name: warroom-task-contract
description: Formato YAML del task contract que warroom (desktop app de Claudio bajo diseño) emite a un executor Claude headless. Invocar cuando se diseña la API planner↔executor, cuando se redacta un contrato, o cuando un executor debe parsearlo.
---

# Warroom Task Contract

Formato del contrato que el planner de warroom emite a cada executor headless. Sin este contrato, el humano sigue siendo el intermediario entre planner y executor. Con él, el executor trabaja autónomamente.

## Contexto

Warroom separa dos roles:

- **Planner** — Claude Sonnet 4.6 persistente. Entiende el objetivo global, planifica, descompone en tareas atómicas, y despacha executors.
- **Executor** — `claude -p` headless en un git worktree dedicado. Recibe un contrato, ejecuta, reporta. No interactúa con el humano durante la ejecución.

El task contract es la pieza que hace autónomo al executor. Un contrato mal escrito produce trabajo que el planner tiene que tirar o corregir.

## Formato YAML

```yaml
goal: <una frase clara, accionable>
context_files:
  - <path/al/file.md>      # archivos que el executor lee primero
  - <path/al/file.rs>
constraints:
  - <qué NO tocar>           # "no modificar tests existentes"
  - <restricciones de scope>
definition_of_done:
  - <criterio verificable>   # "cargo test pasa sin errores"
  - <criterio verificable>   # "ruff check sin errores"
model: <opus|sonnet|haiku>   # default opus
report_back:
  - <qué resumir al terminar>
  - <métricas a incluir si aplica>
```

## Qué importa de cada campo

**`goal`** — accionable en una frase. Si no se puede escribir en una frase, el contrato está mal desglosado: dividir en subtareas.

**`context_files`** — explícito > implícito. Listar TODO lo que el executor necesita leer. Sin esta lista, el executor hace lecturas exploratorias caras o asume cosas que no corresponden.

**`constraints`** — lo NO obvio. Si algo no tocar ya está implicado por el goal, no repetirlo. Solo restricciones que el executor razonablemente podría violentar sin saberlo.

**`definition_of_done`** — comandos concretos o outputs verificables, no "que funcione". Cada ítem debe ser checkeable: correr un comando, abrir una URL, ver un output. Un DoD ambiguo produce un executor que no sabe cuándo terminar.

**`model`** — opus por defecto (calidad de razonamiento autónomo). sonnet para refactor mecánico o tareas de bajo riesgo. haiku solo para triviales (rename de archivo, fix de typo).

**`report_back`** — qué información necesita el planner para tomar la siguiente decisión. Ver formato completo en skill `executor-discipline`.

## Cuándo usar

- Al redactar un contrato en nombre del planner.
- Al implementar el planner (el código que serializa contratos a YAML).
- Al implementar el executor (el código que parsea y valida contratos recibidos).
- Al revisar un contrato existente para detectar por qué un executor falló.

## Cuándo NO usar

- Sesiones interactivas normales de Claude Code donde el humano está presente. El flujo normal de Claude Code no usa contratos.

## Ejemplo bueno

```yaml
goal: Agregar endpoint GET /users/{id} que devuelva UserOut o 404
context_files:
  - src/api/routers/users.py
  - src/models/user.py
  - src/schemas/user.py
constraints:
  - No modificar tests existentes en tests/test_users.py
  - No cambiar el schema UserOut (ya está acordado con el frontend)
definition_of_done:
  - pytest tests/test_users.py::test_get_user_by_id -v pasa en verde
  - pytest tests/test_users.py::test_get_user_not_found -v pasa en verde
  - ruff check src/api/routers/users.py sin errores
model: sonnet
report_back:
  - Nombre del handler agregado y su ruta registrada
  - Si encontró algo raro en el schema existente
```

## Ejemplo malo

```yaml
goal: mejorar el código de usuarios        # vago — ¿qué significa "mejorar"?
context_files: []                          # vacío — executor explora ciegamente
constraints: []                            # sin restricciones — scope abierto
definition_of_done:
  - que funcione                           # no verificable
model: haiku                               # haiku para trabajo con razonamiento autónomo
report_back:
  - lo que hiciste                         # el planner no sabe qué esperar
```

El contrato malo produce un executor que improvisa el scope, hace cambios no pedidos, y devuelve un report-back que no sirve para la siguiente tarea.

## Ver también

- `executor-discipline` — cómo se comporta el executor al recibir este contrato.
- `karpathy-principles` — principios #1 (pensar antes de codear) y #4 (verificar DoD) aplican al planner que escribe el contrato.
- Agente `task-executor` — el agente que encarna el comportamiento del executor.

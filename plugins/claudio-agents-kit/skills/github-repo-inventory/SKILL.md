---
name: github-repo-inventory
description: Pointer al inventario único de repos GitHub de Claudio (99-meta/repos-inventario.md del vault). Invocar al mapear un repo a su proyecto vault, clasificar repos para analytics, o crear un repo nuevo.
---

# GitHub Repo Inventory

El inventario de repos es la fuente de verdad para saber qué existe, en qué estado está, y a qué proyecto de vault pertenece. Sin leerlo, un agente asume o inventa — ambas opciones rompen el sistema de tracking.

## Punto de partida

- **Inventario**: `~/Documents/Obsidian Vault/99-meta/repos-inventario.md`
- Leer ANTES de asumir qué repos existen, su estado, o su proyecto asociado.

## Estados (resumen)

| Estado | Significado |
|---|---|
| `activo-proyecto` | Ligado a `scaffolding/projects/<slug>/`. Foco diario de trabajo. |
| `activo-personal` | Corriendo, sin folder de proyecto vault todavía. |
| `activo-cliente` | Trabajo de cliente, sin folder de proyecto vault todavía. |
| `meta` | Infra del sistema (marketplace, scripts, dotfiles). No es un entregable. |
| `pausado` | Trabajo iniciado, sin actividad reciente, retomable cuando sea. |
| `archivado` | Legacy. No retomar. |

## Cómo se lee

El inventario tiene una tabla principal con columnas:

- **Repo** — URL o nombre corto del repo GitHub.
- **Proyecto vault** — wikilink `[[../scaffolding/projects/<slug>/README]]`.
- **Rol** — para qué sirve el repo dentro del proyecto.
- **Estado** — uno de los estados de la tabla de arriba.
- **Última actividad** — fecha aproximada del último commit relevante.

Sección "Activos ligados a proyectos del vault" es el primer lugar a mirar para repos en foco activo.

## Cómo se escribe (caminos canónicos)

Hay dos caminos válidos. Solo estos dos.

**Camino 1 — operación atómica via script (preferido)**:
```
scaffolding/scripts/scaffold.py
```
Crea el repo en GitHub, genera el folder del proyecto en vault, y hace append automático al inventario en la misma operación.

**Camino 2 — manual**:
1. `gh repo create ...` — crear el repo en GitHub primero.
2. Editar `99-meta/repos-inventario.md` manualmente.

NUNCA editar el inventario a mano sin haber creado o movido el repo en GitHub primero. El inventario y GitHub deben estar sincronizados.

## Wikilinks

El campo "Proyecto vault" usa formato de wikilink relativo al inventario:

```
[[../scaffolding/projects/warroom/README]]
```

No usar URLs absolutas ni paths de sistema en este campo.

## Módulo repo-analytics

El submódulo `repo-analytics` lee el inventario para clasificar repos en reports mensuales de actividad. Solo lectura — no escribe al inventario. Al diseñar analytics, partir del inventario como fuente.

## Cuándo usar

- Al hablar de cualquier repo de Claudio y necesitar su estado o proyecto asociado.
- Al diseñar o revisar el módulo de analytics mensual.
- Al planificar un proyecto nuevo que requiera un repo GitHub.
- Al decidir si un repo es archivable (cruzar con estado y última actividad).

## Cuándo NO usar

- Turnos donde el CWD ya apunta al clone del repo y el contexto del proyecto ya está en memoria del turno.
- Turnos puramente internos de vault que no tocan repos GitHub.

## Ejemplos buenos

```
# correcto: antes de proponer crear un repo, leer el inventario
1. Leer 99-meta/repos-inventario.md
2. Verificar que no existe ya un repo para este proyecto
3. Decidir si usar scaffold.py o flujo manual
4. Actualizar el inventario en la misma operación que el repo
```

## Ejemplos malos

```
# incorrecto: asumir el estado del repo sin leer el inventario
- "El repo warroom está en activo-proyecto" sin haber leído el inventario
- Crear un repo y olvidar actualizar el inventario
- Editar el inventario antes de que el repo exista en GitHub
```

## Ver también

- `obsidian-vault-conventions` — naming y estructura del vault donde vive el inventario.
- `scaffold.py` en `scaffolding/scripts/` del vault — operación atómica de creación repo+proyecto.

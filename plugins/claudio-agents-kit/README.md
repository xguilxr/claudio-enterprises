# claudio-agents-kit

Opera los cuatro marcos de Claudio-Enterprises. **No los contiene**: los marcos viven en
`docs/` de este repositorio y se versionan por separado.

## Qué hay

| Carpeta | Qué es | Se carga |
|---|---|---|
| `skills/` | 21 skills que ejecutan los marcos | Su descripción, bajo demanda |
| `plantillas-skill/` | 27 skills que se instalan **en el proyecto** que las necesita | Nunca desde aquí |
| `corpus/` | 7 documentos de conocimiento declarativo | Cuando una skill los pide |
| `roles/` | 1 rol, `task-executor` | Al delegarle una tarea acotada |
| `templates/` | Plantillas de proyecto y de estilo | Al andamiar un proyecto |

## Instalación

```bash
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

## Por dónde empezar

| Quiero… | Skill |
|---|---|
| Que Claude trabaje bien en este repo | `andamiaje-entorno` |
| Saber en qué estado está un proyecto | `auditar-proyecto` |
| Ver qué tiene un repo en 20 minutos | `quick-scan` |
| Encuadrar lo que un cliente pide | `encuadrar-encargo` |
| Convertir algo que repito en una skill | `destilar-skill` |

## Las plantillas de skill no se cargan

`plantillas-skill/` existe para que el conocimiento de un stack no cueste contexto a los
proyectos que no usan ese stack. `andamiaje-entorno` copia al proyecto solo las que le
correspondan. Es el requisito MCA CAP-06.

## Roles

Uno. De 22 agentes previos, `task-executor` fue el único que superó la rúbrica de autonomía
de `MCS-G04` (11 sobre 12). Los otros 21 se descompusieron; el detalle y la puntuación de
cada uno están en `docs/migracion/03-disposicion.md`.

`task-executor` está **propuesto, no vigente**: le faltan las cinco puertas de MCA-N5.

# claudio-agents-kit

Opera los cuatro marcos de Claudio-Enterprises: MFB, MCS, MCC y MCA.

**Los marcos viajan adentro**, en `marcos/`. Desde la v6.2.0 las skills funcionan sobre
cualquier repositorio sin adjuntar nada. `docs/` del repo del marketplace sigue siendo la
fuente; `marcos/` es una copia de publicación que mantiene `scripts/sincronizar-marcos.sh`.

## Qué hay

| Carpeta | Qué es | Se carga |
|---|---|---|
| `skills/` | 22 skills que ejecutan los marcos | Su descripción, bajo demanda |
| `marcos/` | Los normativos, prompts, guías y glosario | Cuando una skill los lee |
| `plantillas-skill/` | 27 skills que se instalan **en el proyecto** que las necesita | Nunca desde aquí |
| `corpus/` | 7 documentos de conocimiento declarativo | Cuando una skill los pide |
| `roles/` | 1 rol, `task-executor` | Al delegarle una tarea acotada |
| `templates/` | Plantillas de proyecto y de estilo | Al andamiar un proyecto |
| `scripts/` | `sincronizar-marcos.sh` | Nunca en sesión; es de mantenimiento |

## Instalación

```bash
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

## Cómo se invoca

No hay slash commands propios desde la v6.0.0. Todo es skill, y una skill del plugin lleva el
prefijo del plugin:

```
/claudio-agents-kit:auditar-proyecto
```

Sin el prefijo no la encuentra. Lo normal, igual, es pedirlo en prosa: la `description` de
cada skill está escrita para que active sola.

## Por dónde empezar

| Quiero… | Skill |
|---|---|
| Saber en qué estado está un proyecto | `auditar-proyecto` |
| Que Claude trabaje bien en este repo | `andamiaje-entorno` |
| Ver qué tiene un repo en 20 minutos | `quick-scan` |
| Encuadrar lo que un cliente pide | `encuadrar-encargo` |
| Convertir algo que repito en una skill | `destilar-skill` |

`auditar-proyecto` es el punto de entrada: corre MCA → MCC → MCS y devuelve un solo plan. Las
tres skills por marco —`auditar-entorno`, `auditar-encargo`, `auditar-software`— existen para
auditar uno solo cuando ya sabés cuál te duele.

El inventario completo está en `docs/README.md` §4 del repo del marketplace.

## Las plantillas de skill no se cargan

`plantillas-skill/` existe para que el conocimiento de un stack no cueste contexto a los
proyectos que no usan ese stack. `andamiaje-entorno` copia al proyecto solo las que le
correspondan. Es el requisito MCA CAP-06.

## Roles

Uno. De 22 agentes previos, `task-executor` fue el único que superó la rúbrica de autonomía
de `MCS-G04` (11 sobre 12). Los otros 21 se descompusieron; el detalle y la puntuación de
cada uno están en `docs/migracion/03-disposicion.md`.

`task-executor` está **candidato, no vigente**. Las cinco puertas de diseño se cerraron en la
v6.1.0; quedan las dos de ejecución: una traza real producida y la evaluación corrida con su
resultado registrado. Un esquema de traza no es una traza; un conjunto de casos no es un
resultado.

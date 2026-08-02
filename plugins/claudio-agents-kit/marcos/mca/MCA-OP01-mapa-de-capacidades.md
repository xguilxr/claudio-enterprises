---
id: MCA-OP01
titulo: Mapa de capacidades de la plataforma
marco: MCA
capa: operativa
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 30d
uso: recurrente
depende_de: [MCA-CORE, MCA-G01]
cubre_codigo: []
---

# Mapa de capacidades de la plataforma

**Este es el único documento de MCA que nombra mecanismos concretos.** La normativa exige
resultados; aquí se registra qué mecanismo los satisface hoy.

Cuando la plataforma cambia, se actualiza este documento. `MCA-CORE` no se toca. Es lo que
impide que el marco caduque con la herramienta (MFB antipatrón 4).

| Campo | Valor |
|---|---|
| Fuente | `code.claude.com/docs` |
| Fecha de verificación | 2026-08-02 |
| Método | Consulta directa del índice de documentación y de la página del directorio de configuración |
| Próxima verificación | 2026-09-01 |

> **Limitación declarada (TRZ-09).** Se verificaron el inventario de páginas publicadas y el
> árbol del directorio de configuración. **No se verificaron** los campos exactos del
> encabezado de una capacidad ni los límites de longitud: esa página devolvió error de
> servicio en el momento de la consulta. Lo no verificado va marcado `NO VERIFICADO` y no
> debe darse por cierto.

---

# 1. Dónde vive cada cosa

Verificado contra la documentación del directorio de configuración.

## Repositorio

| Ruta | Qué es | Se carga |
|---|---|---|
| `CLAUDE.md` | Instrucciones del proyecto | **Siempre** |
| `.mcp.json` | Proveedores de herramientas externos, compartidos con el equipo | Al conectar |
| `.claude/settings.json` | Permisos, automatizaciones del ciclo, configuración | Siempre |
| `.claude/settings.local.json` | Sobrescrituras personales, no compartidas | Siempre |
| `.claude/rules/*.md` | **Instrucciones de alcance temático, con filtro por ruta de archivo** | Solo si la tarea toca esas rutas |
| `.claude/skills/<n>/SKILL.md` | Capacidad, con archivos de apoyo | Por descripción |
| `.claude/commands/*.md` | Peticiones reutilizables por nombre | Al invocar |
| `.claude/agents/*.md` | Subagentes con ventana de contexto propia | Al delegar |
| `.claude/workflows/` | Guiones que orquestan varios subagentes | Al invocar |
| `.claude/output-styles/` | Secciones de instrucción que ajustan el modo de trabajo | Según configuración |
| `.claude/agent-memory/<n>/MEMORY.md` | Memoria persistente de un subagente, que él mismo mantiene | Al invocar ese subagente |
| `.worktreeinclude` | Archivos ignorados que se copian a un árbol de trabajo nuevo | Al crear el árbol |

## Personal, fuera del repositorio

`~/.claude/` replica `rules/`, `skills/`, `commands/`, `agents/`, `workflows/`,
`output-styles/` y `agent-memory/` con alcance global, más `CLAUDE.md`, `settings.json`,
`keybindings.json` y `themes/`.

`~/.claude/projects/<proyecto>/memory/MEMORY.md` es **memoria automática que el asistente
escribe y mantiene solo**, con notas por tema cuando crece.

---

# 2. Correspondencia requisito → mecanismo

| Requisito | Mecanismo | Nota |
|---|---|---|
| CTX-01 stack, comandos, qué no tocar | `CLAUDE.md` | — |
| CTX-02 presupuesto declarado | `CLAUDE.md` + `mca.yaml` | Sin mecanismo nativo; se declara y se mide |
| CTX-03 sin cifras vivas | — | Verificación propia. No hay control de plataforma |
| **CTX-04 alcance temático** | **`.claude/rules/` con filtro por ruta** | **Mecanismo nativo. Ver §3.1** |
| CTX-05 presupuesto verificado | Automatización de sesión + script propio | La página del contexto documenta cómo inspeccionarlo |
| CTX-06 un hecho, un artefacto | — | Verificación propia |
| CTX-07 podar memoria | `~/.claude/projects/<p>/memory/` | El asistente la escribe; la poda es humana |
| CAP-01..07 capacidades | `.claude/skills/<n>/SKILL.md` | Campos exactos `NO VERIFICADO` |
| CAP-04 divulgación progresiva | Archivos de apoyo junto a `SKILL.md` | — |
| CAP-06 capacidades por stack | `.claude/skills/` del repositorio | Frente a `~/.claude/skills/` global |
| CAP-08 retirar sin uso | — | Verificación propia |
| FLU-01 comandos de verificación | `CLAUDE.md` + `.claude/settings.json` | — |
| FLU-02 definición de terminado | `CLAUDE.md` | Sin mecanismo nativo |
| **FLU-03 automatizar el ciclo** | **Automatizaciones de ciclo de vida** | Órdenes de consola, puntos HTTP o peticiones al modelo |
| **FLU-04 secuencia determinista** | **`.claude/workflows/`** | Orquesta varios subagentes de forma determinista |
| FLU-05 periodicidad y parada | Tareas programadas y rutinas | Tres mecanismos documentados; ver §3.2 |
| FLU-06 traza | Gestión de sesiones + observabilidad | — |
| AUT-01 confirmación en irreversible | Modos de permiso y permisos por herramienta | — |
| AUT-02 rúbrica de rol | MCS-G04 | Marco propio, no plataforma |
| AUT-03 catálogo y ámbito | Encabezado del subagente + permisos | Campo de herramientas `NO VERIFICADO` |
| AUT-04 límites | Seguimiento de coste y uso | — |
| AUT-05 traza de ejecución | Vista de agentes + observabilidad | — |
| AUT-06 evaluación previa | — | Sin mecanismo nativo. Construcción propia |
| AUT-07 memoria podable | `.claude/agent-memory/<n>/MEMORY.md` | Inspeccionable por ser un archivo del repositorio |
| **HER-01..07 herramientas externas** | **`.mcp.json`, permisos, entornos aislados** | Ver §3.3 |
| HER-04 permiso por herramienta | `.claude/settings.json` | Modos de permiso documentados |
| HER-07 producción temporal | Gestión centralizada de proveedores externos | Para organizaciones |
| EVA-01..06 evaluación | — | **Sin mecanismo nativo. Es la mayor carencia** |
| APR-01..07 aprendizaje | Automatización de cierre de sesión + registro propio | Ver §3.4 |

---

# 3. Cuatro cosas que conviene saber

## 3.1 Las instrucciones de alcance temático son el mecanismo infrautilizado

`.claude/rules/` permite escribir una convención y **filtrarla por ruta de archivo**: la
convención de pruebas solo entra en contexto cuando la tarea toca pruebas.

Es exactamente CTX-04, resuelto de forma nativa. Un repositorio que mete todas sus
convenciones en `CLAUDE.md` paga todas en cada turno; uno que las reparte en reglas con
filtro paga solo las que aplican.

**Es la corrección de mayor rendimiento y la más barata.**

## 3.2 Capacidades y peticiones por nombre son el mismo mecanismo

La documentación es explícita: *«Commands and skills are now the same mechanism. For new
workflows, use `skills/` instead: same `/name` invocation, plus you can bundle supporting
files.»*

**Consecuencia directa:** `commands/` sigue funcionando pero no es donde va lo nuevo. Una
capacidad se invoca igual por nombre y además admite archivos de apoyo, que es lo que exige
CAP-04.

## 3.3 El alcance externo tiene tres capas de acotación

Proveedores declarados en `.mcp.json`, permisos por herramienta en `.claude/settings.json`,
y entornos aislados para la ejecución de órdenes de consola. Las tres están documentadas y
son independientes.

HER-04 exige la segunda: **permiso por herramienta, nunca global por omisión**. Los modos de
permiso permiten lo contrario, y es la configuración que más se elige por comodidad.

## 3.4 No hay mecanismo nativo de evaluación de capacidades

El dominio EVA no tiene soporte de plataforma. Los casos de activación y de no-activación
hay que construirlos.

Es la carencia más relevante de este mapa, y la razón por la que EVA-01 y EVA-02 están en N3
y no antes: exigirlos en N1 haría que nadie alcanzara N1.

---

# 4. Capacidades documentadas sin requisito asignado

Existen y hoy MCA no las gobierna. Se registran para que la próxima revisión decida si
merecen requisito:

Puntos de restauración · árboles de trabajo en paralelo · equipos de sesiones · vista de
agentes · canales de eventos hacia una sesión en marcha · herramienta de escalado de
decisiones · búsqueda de herramientas a escala · salidas estructuradas · uso de computadora ·
revisión de código automatizada · integración con acciones de repositorio · modo rápido ·
almacenamiento en caché de instrucciones · publicación de resultados de sesión · perseguir un
objetivo entre turnos.

**Criterio para promoverlas:** solo entra en la normativa lo que produzca daño real por su
ausencia y sea verificable (MFB NIV-04). Que una capacidad exista no la hace un requisito.

---

# 5. Procedimiento de revisión

Cada 30 días, o cuando se publique algo relevante:

1. Consultar el índice de documentación y comparar con §1 y §4.
2. Añadir mecanismos nuevos a §4 sin asignarles requisito todavía.
3. Marcar como obsoleta toda correspondencia cuyo mecanismo haya desaparecido.
4. Resolver lo que siga `NO VERIFICADO`.
5. Si un mecanismo nuevo hace verificable un requisito que hoy no lo es, proponer el cambio
   a `MCA-CORE` — que es incremento de versión mayor (VER-03).

**Nunca al revés:** un mecanismo nuevo no justifica por sí solo un requisito nuevo. Primero
el daño verificable, después el requisito, después el mecanismo.

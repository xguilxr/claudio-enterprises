---
id: INDICE
titulo: Índice maestro de marcos
marco: —
capa: indice
version: 1.6.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
depende_de: [ORQUESTADOR, CONVENCIONES, glosario, MFB-CORE, MCS-CORE, MCC-CORE, MCA-CORE]
---

# claudio-enterprises — Índice maestro

Familia de marcos de trabajo interconectados. Cada marco codifica una disciplina
profesional en forma verificable: requisitos numerados, niveles de madurez,
prompts de aplicación y skills instalables.

**Antes de leer nada más, lee `ORQUESTADOR.md`.** Determina qué cargar y cuándo.
Este índice dice qué existe; el orquestador dice cuándo usarlo.

---

## 1. Catálogo de marcos

| Prefijo | Marco | Estado | Versión | Dominios | Requisitos |
|---|---|---|---|---|---|
| **MFB** | Construcción de Marcos | Vigente | 1.2.0 | 7 | 52 |
| **MCS** | Calidad de Software | Vigente | 2.0.0 | 17 | 204 |
| **MCC** | Consultoría de Tecnología | Vigente | 1.0.0 | 9 | 92 |
| **MCA** | Capacidades Agénticas | Vigente | 1.0.0 | 7 | 48 |

Conteos **verificados uno a uno**. MFB corrigió los suyos en v1.1.0 (errata F-01). MCS
publica 203 y su fila DAT no cuadra: ver `mcs/MCS-ERRATAS-2.0.0.md` E-01 y E-02. MCC y MCA son los únicos cuyos
anexos cuadraron a la primera.

**Total de la familia: 396 requisitos.** Por eso existe `ORQUESTADOR.md`: no se cargan
nunca todos.

### Marcos previstos

Ninguno. Antes de crear el siguiente, aplicar la rúbrica de MFB-G01 §3: casi siempre lo
que parece un marco nuevo es un dominio dentro de uno existente.

---

## 2. Mapa de documentos

Estado real del repositorio. Los directorios vacíos no se crean (CONVENCIONES §2), así que
la ausencia de una carpeta significa que su contenido no existe todavía.

```
docs/
├── README.md                  ← este archivo: qué existe
├── ORQUESTADOR.md             ← cuándo cargar cada cosa
├── CONVENCIONES.md            ← nomenclatura, estructura, front-matter
├── AUDITORIA.md               ← cómo se audita un proyecto: orden, nivel, registro
│
├── conocimiento/
│   ├── glosario.yaml          ← eje común de TODA la familia (27 términos)
│   └── README.md              ← su verificación contra los normativos
│
├── mfb/                       ← Construcción de Marcos · COMPLETO
│   ├── MFB-CORE.md · MFB-ERRATAS-1.0.0.md
│   ├── guias/     MFB-G01
│   ├── prompts/   MFB-P01 crear · MFB-P02 auditar
│   └── plantillas/ MFB-T01..T06
│
├── mcs/                       ← Calidad de Software · sin guías
│   ├── MCS-CORE.md · MCS-ERRATAS-2.0.0.md
│   ├── prompts/   MCS-P01 auditoría · MCS-P02 (reemplazado) · MCS-P03 quick scan
│   └── operativa/ MCS-OP01 cartera · MCS-OP02 reabsorción · MCS-OP03 evidencia
│
├── mca/                       ← Capacidades Agénticas · el entorno de trabajo
│   ├── MCA-CORE.md
│   ├── guias/     MCA-G01 entorno agéntico, niveles y destilación
│   ├── prompts/   MCA-P01 andamiaje · MCA-P02 auditoría de entorno
│   └── operativa/ MCA-OP01 mapa de capacidades de la plataforma (30d)
│
├── mcc/                       ← Consultoría de Tecnología · MFB-N2
│   ├── MCC-CORE.md · MCC-PARCHES-ENTORNO.md
│   ├── guias/     MCC-G01 proceso · MCC-G02 inmersión · MCC-G03 economía
│   └── prompts/   MCC-P01 conducción del encargo
│
└── migracion/                 ← salida de MCS-OP02, no es documento de marco
    ├── 01-inventario.md
    └── 02-arquitectura-multimarco.md   (REEMPLAZADO por MFB)
```

El **paquete instalable** vive fuera de `docs/`, en `plugins/claudio-agents-kit/`. Son dos
productos con ciclos de vida propios: el paquete implementa los marcos, los marcos no
dependen del paquete.

### 2.0 Lo que falta

| Falta | Consecuencia | Bloquea |
|---|---|---|
| `INSTRUCCIONES-PROYECTO.md` | Es el nivel L1 del orquestador, lo único permanente en contexto. Sin él no hay activación por disparador y la tabla de ruteo hay que consultarla a mano | La operación diaria |
| **MCS-G01…G03** | No existen. MCS-CORE §0.3 las declara como parte del marco | El razonamiento tras los requisitos de ciclo de vida, diseño e IA |
| Validación de MCS-G04 | La rúbrica del Track E se redactó desde §3.7, §3.8 e IA-06. CON-08 exige que la certifique una persona experta | Que la clasificación rol/skill sea autoritativa |
| MCC-P02, P03, P04 | Inmersión sectorial, propuesta y costeo, estimación | Operar los dominios INV, ECO y ESF sin leer las guías |
| MCC-T01, T02 | Ficha de encargo y propuesta (EST-09) | Que MCC llegue a MFB-N3 |
| Ejecución de la evaluación de `task-executor` | Los doce casos existen con umbral declarado; nadie los ha corrido. Sin resultado registrado el rol no pasa de `candidato` | Que el único rol sea vigente |

### 2.1 MFB — Marco de Construcción de Marcos

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MFB-CORE | Documento normativo | Normativa | 52 requisitos que todo marco de la familia debe cumplir | ✅ v1.2.0 |
| MFB-G01 | Diseño de marcos | Guía | Cómo se decide, estructura y redacta un marco | ✅ |
| MFB-P01 | Crear marco | Prompt | Construye un marco nuevo de principio a fin | ✅ |
| MFB-P02 | Auditar marco | Prompt | Verifica homogeneidad y conformidad con MFB | ✅ |
| MFB-T01..T06 | Plantillas | Plantilla | Normativa, guía, prompt, operativa, skill, ADR | ✅ |
| MFB-ERRATAS | Erratas v1.0.0 | Operativa | Cinco defectos; F-01 cerrado en v1.1.0 | ✅ |

### 2.2 MCS — Marco de Calidad de Software

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MCS-CORE | Documento normativo | Normativa | 204 requisitos, 17 dominios, niveles N1–N5 | ✅ |
| MCS-P01 | Auditoría | Prompt | Auditoría formal de conformidad, seis etapas | ✅ |
| MCS-P03 | Quick scan | Prompt | Reconocimiento rápido, una página, quick wins | ✅ |
| MCS-OP01 | Gestión de la cartera | Operativa | Inventario, prioridad, consolidación y cadencia entre proyectos | ✅ |
| MCS-OP02 | Reabsorción del repositorio | Operativa | Un solo uso: migrar los activos previos | ✅ |
| MCS-OP03 | Evidencia y certificación | Operativa | Conservación de evidencia y control de cambios | ✅ |
| MCS-ERRATAS | Erratas v2.0.0 | Operativa | Siete defectos pendientes de emitir v2.0.1 | ✅ |
| MCS-P02 | Consultoría | Prompt | **Reemplazado por MCC-P01** | ⛔ |
| MCS-G04 | Disciplinas transversales | Guía | **Track E, rúbrica de autonomía.** v0.1.0 pendiente de validación | ⚠️ |
| MCS-G01…G03 | Guías | Guía | Ciclo de vida, diseño, IA | ❌ |

### 2.3 MCC — Marco de Consultoría de Tecnología

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MCC-CORE | Documento normativo | Normativa | 92 requisitos, 9 dominios, niveles N1–N5 | ✅ |
| MCC-G01 | El proceso consultivo | Guía | Etapas E0–E5, del encuadre a la transferencia | ✅ |
| MCC-G02 | Inmersión sectorial | Guía | Dominar un rubro desconocido contra reloj | ✅ |
| MCC-G03 | Economía del encargo | Guía | Costeo y estimación de esfuerzos | ✅ |
| MCC-P01 | Conducción del encargo | Prompt | Reemplaza a MCS-P02 | ✅ v2.0.0 |
| MCC-PARCHES | Incorporación al entorno | Operativa | Un solo uso: los parches aplicados aquí | ✅ |
| MCC-P02 | Inmersión sectorial | Prompt | Ejecuta MCC-G02 con presupuesto de tiempo | ❌ |
| MCC-P03 / P04 | Propuesta y costeo · Estimación | Prompt | Cierran ECO, PRO y ESF | ❌ |
| MCC-T01 / T02 | Ficha de encargo · Propuesta | Plantilla | Cierran EST-09 | ❌ |

**Dominios de MCC:** CTR contratación · INV inmersión · ANA análisis · PRO propuesta ·
ECO economía · ESF esfuerzo · PLA planificación · ENT entrega · CLI relación con el cliente.

### 2.4 MCA — Marco de Capacidades Agénticas

Gobierna **la IA que construye el producto**; MCS §5.15 gobierna la que el producto expone.

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MCA-CORE | Documento normativo | Normativa | 48 requisitos, 7 dominios, niveles N1–N5 | ✅ |
| MCA-G01 | El entorno agéntico | Guía | Niveles, dónde va cada cosa, destilación | ✅ |
| MCA-OP01 | Mapa de capacidades | Operativa | Único documento que nombra mecanismos. Revisión cada 30 días | ✅ |
| MCA-P01 | Andamiaje de entorno | Prompt | Lleva un repositorio a N2 en una sesión | ✅ |
| MCA-P02 | Auditoría de entorno | Prompt | Mide el contexto y determina el nivel alcanzado | ✅ |

**Dominios:** CTX contexto · CAP capacidades · FLU flujos · AUT autonomía · HER herramientas ·
EVA evaluación · APR aprendizaje.

**Niveles:** N1 orientado · N2 verificable · N3 capacitado · N4 conectado · N5 autónomo.
N1 y N2 suman 11 requisitos y no añaden ninguna clase de fallo nueva: ahí está el
rendimiento. Los 24 de N4 y N5 son de acotación de alcance y evidencia.

---

## 3. Inventario de roles

Un **rol** es una configuración de agente que supera el umbral de la rúbrica de
autonomía de MCS-G04 track E. Todo lo que no lo supera es una skill, no un rol.

| Marco | Rol | Puntuación rúbrica | Estado |
|---|---|---|---|
| MCS | `task-executor` v1.1.0 | **11/12**, dim4 = 2 | Candidato |

Rúbrica aplicada a los 22 agentes previos en `migracion/03-disposicion.md`: **uno pasa el
umbral**. Los otros 21 se descomponen en 34 skills y 5 corpus. Es el resultado que MCS-OP02
anticipaba.

### 3.1 Puertas de `task-executor`

Las de diseño están cerradas; quedan dos de ejecución.

| Puerta | Requisito | Dónde | Estado |
|---|---|---|---|
| Clasificación registrada | AUT-02 · IA-06 | `AGENT.md` | ✅ |
| Catálogo y ámbito | AUT-03 | `catalogo.yaml` · `permisos.json` | ✅ |
| Límites de iteración y coste | AUT-04 · IA-03 | `catalogo.yaml` §4 | ✅ |
| Confirmación en irreversibles | AUT-01 · IA-10 | `catalogo.yaml` §3 | ✅ |
| Memoria inspeccionable | AUT-07 | `catalogo.yaml` §5 — NO APLICABLE | ✅ |
| Traza de ejecución | AUT-05 · IA-13 | `referencias/traza.md` | ⏳ definida, no producida |
| Evaluación con umbral | AUT-06 · IA-07 | `evaluacion/` | ⏳ definida, no ejecutada |

**AUT-01 se resolvió sin romper la regla de no preguntar**: el requisito exige confirmación
humana explícita, no interacción. En una sesión sin supervisión esa confirmación se da antes,
por escrito, en el contrato. El catálogo deniega por omisión y el contrato solo puede
apretar, nunca aflojar.

Pasa a **vigente** con un resultado registrado en `evaluacion/resultados/` y una traza real.
Un esquema de traza no es una traza; un conjunto de casos no es un resultado.

---

## 4. Inventario de skills

Una **skill** es un procedimiento repetible, cargado bajo demanda.

| Marco | Skill | Qué hace | Requisitos que cierra | Estado |
|---|---|---|---|---|
| MCS | auditoria-conformidad | Ejecuta MCS-P01 | GOB-03 | Propuesta |
| MCS | quick-scan | Ejecuta MCS-P03 | — | Propuesta |
| MCS | redactar-adr | Genera un ADR conforme al anexo C | ARQ-02, GOB-02 | Propuesta |
| MCS | glosario-canonico | Crea y mantiene el glosario | LEN-01, DAT-01 | Propuesta |
| MCS | definir-indicador | Ficha de métrica y prueba de reconciliación | DAT-10, DAT-13 | Propuesta |
| MCS | rubrica-autonomia-ia | Puntúa una funcionalidad de IA | IA-06 | Propuesta |
| MCS | impacto-documental | Detecta documentos afectados por un cambio | DOC-06 | Propuesta |
| MCS | andamiaje-n1 | Genera el esqueleto de repositorio en nivel N1 | CFG-01..06, INT-01 | Propuesta |
| MCS | modelado-amenazas | STRIDE sobre una arquitectura | SEG-06 | Propuesta |
| MCS | auditar-deriva | Detecta deriva de unidades y conceptos | DAT-01..08 | Propuesta |
| MFB | crear-marco | Ejecuta MFB-P01 | EST-01..05 | Propuesta |
| MFB | auditar-marco | Ejecuta MFB-P02 | Todos los de MFB | Propuesta |
| MCC | encuadrar-encargo | Produce la ficha de encargo y clasifica el tipo | CTR-01..06 | Propuesta |
| MCC | inmersion-sectorial | Dossier y kit de reunión de un rubro nuevo | INV-01..09 | Propuesta |
| MCC | estimar-esfuerzo | Descompone, estima en rango y declara supuestos | ESF-01..07 | Propuesta |
| MCC | costear-solucion | Cuatro capas de costo con cifras vivas fechadas | ECO-01..09 | Propuesta |
| MCC | plan-por-tandas | Convierte alcance en tandas con resultado observable | PLA-01..05 | Propuesta |

Estados: Propuesta · En construcción · Vigente · Retirada.

---

## 5. Estado de conformidad del propio repositorio

Este repositorio se somete a sus propios marcos. Ver `mcs.yaml` en la raíz.

| Marco | Nivel objetivo | Nivel alcanzado | Última evaluación |
|---|---|---|---|
| MCS | N1 | Pendiente | — |
| MFB | N2 | Pendiente | — |
| MCC | N1 | Pendiente | — |
| MCA | N2 | Pendiente | — |

Un repositorio que aloja los marcos y no los cumple carece de autoridad.

**Estado por marco**, verificado durante el montaje. Pendiente de ejecutar MFB-P02 en forma
sobre cada uno:

| Marco | Bloqueo para su propio N1 | Gravedad |
|---|---|---|
| **MFB** | Ninguno conocido. Tiene normativo, guía, prompts y plantillas | — |
| **MCS** | EST-03 cerrado con MCS-G04 v0.1.0. Faltan G01–G03 | Media |
| **MCC** | Ninguno. Su autoauditoría declara MFB-N2; N3 exige T01, T02 y skills | — |

**Ambos anexos de distribución fallan NIV-07** salvo el de MCC: MFB corrigió el suyo en
v1.1.0; MCS sigue con la fila DAT descuadrada (E-01).

La carencia que más pesa es EST-03 en MCS. MFB-G01 §4 paso 4 explica por qué: los
requisitos se descubren al explicar, no al legislar. MCS se escribió en el orden inverso al
que MFB prescribe, y ese es su antipatrón 9 — se detecta porque nadie sabe explicar por qué
existe cada requisito. MCC sí se escribió en el orden correcto, y su anexo cuadró a la
primera; no es coincidencia.

---

## 6. Mantenimiento de este índice

Actualizar al: crear un marco, añadir un documento, promover una skill de
propuesta a vigente, o completar una evaluación de conformidad.

Si este archivo lleva más de 90 días sin revisar, está desactualizado por
definición.

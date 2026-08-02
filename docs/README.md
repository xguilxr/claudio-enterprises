---
id: INDICE
titulo: Índice maestro de marcos
marco: —
capa: indice
version: 1.1.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
depende_de: [ORQUESTADOR, CONVENCIONES, MFB-CORE, MCS-CORE]
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
| **MFB** | Construcción de Marcos | Vigente | 1.0.0 | 7 | 52 |
| **MCS** | Calidad de Software | Vigente | 2.0.0 | 17 | 204 |

Los requisitos son conteos **verificados uno a uno**, no los publicados en los anexos de
cada normativo. MFB declara 34 y su Anexo A suma 51; MCS declara 203. Ver
`mfb/MFB-ERRATAS-1.0.0.md` (F-01) y `mcs/MCS-ERRATAS-2.0.0.md` (E-01, E-02).

### Marcos previstos

Candidatos identificados, aún sin construir. Antes de crear cualquiera, aplicar
la rúbrica de MFB-G01 §3: puede que sea un dominio dentro de un marco existente,
no una familia nueva.

| Prefijo | Marco | Origen | Decisión pendiente |
|---|---|---|---|
| MCC | Consultoría | MCS-P02 sugiere que el proceso consultivo excede el marco de software | Rúbrica ya aplicada en MFB-G01 §3: **8–9 → familia nueva**. Falta construirlo |

---

## 2. Mapa de documentos

Estado real del repositorio. Los directorios vacíos no se crean (CONVENCIONES §2), así que
la ausencia de una carpeta significa que su contenido no existe todavía.

```
docs/
├── README.md                  ← este archivo: qué existe
├── ORQUESTADOR.md             ← cuándo cargar cada cosa
├── CONVENCIONES.md            ← nomenclatura, estructura, front-matter
│
├── mfb/
│   ├── MFB-CORE.md
│   ├── MFB-ERRATAS-1.0.0.md
│   └── guias/MFB-G01-diseno-de-marcos.md
│
├── mcs/
│   ├── MCS-CORE.md
│   ├── MCS-ERRATAS-2.0.0.md
│   └── prompts/MCS-P0{1,2,3,4}-*.md
│
└── migracion/                 ← salida de MCS-P04, no es documento de marco
    ├── 01-inventario.md
    └── 02-arquitectura-multimarco.md   (REEMPLAZADO por MFB)
```

El **paquete instalable** vive fuera de `docs/`, en `plugins/claudio-agents-kit/`. Son dos
productos con ciclos de vida propios: el paquete implementa los marcos, los marcos no
dependen del paquete.

### 2.0 Lo que falta

| Falta | Consecuencia | Bloquea |
|---|---|---|
| `conocimiento/glosario.yaml` | Es el **único eje común** de la familia (MFB §2.5). Sin él, TRZ-04 y RED-02 son inverificables y cada marco derivará por su cuenta | Todo lo demás |
| `INSTRUCCIONES-PROYECTO.md` | Es el nivel L1 del orquestador, lo único permanente en contexto. Sin él no hay activación por disparador | La operación diaria |
| MFB-P01, MFB-P02 | Crear y auditar marcos. MFB-G01 §4 paso 10 exige P02 antes de publicar | Construir MCC |
| MFB-T01…T06 | Plantillas de cada tipo de documento (EST-09) | Construir MCC |
| MCS-G01…G04 | **No existen y nunca se crearon.** MCS-CORE §0.3 las declara como parte del marco | La rúbrica del Track E, y con ella la clasificación rol/skill |
| MCS-OP01, MCS-OP02 | El INDICE los lista; MCS-P04 cubre lo de OP02 con otro identificador | — |

### 2.1 MFB — Marco de Construcción de Marcos

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MFB-CORE | Documento normativo | Normativa | 52 requisitos que todo marco de la familia debe cumplir | ✅ |
| MFB-G01 | Diseño de marcos | Guía | Cómo se decide, estructura y redacta un marco | ✅ |
| MFB-ERRATAS | Erratas v1.0.0 | Operativa | Defectos verificados pendientes de emitir v1.0.1 | ✅ |
| MFB-P01 | Crear marco | Prompt | Construye un marco nuevo de principio a fin | ❌ |
| MFB-P02 | Auditar marco | Prompt | Verifica homogeneidad y conformidad con MFB | ❌ |
| MFB-T01..T06 | Plantillas | Plantilla | Esqueletos de cada tipo de documento | ❌ |

### 2.2 MCS — Marco de Calidad de Software

| ID | Documento | Capa | Para qué | Estado |
|---|---|---|---|---|
| MCS-CORE | Documento normativo | Normativa | 204 requisitos, 17 dominios, niveles N1–N5 | ✅ |
| MCS-ERRATAS | Erratas v2.0.0 | Operativa | Seis defectos verificados pendientes de emitir v2.0.1 | ✅ |
| MCS-P01 | Auditoría | Prompt | Auditoría formal de conformidad, seis etapas | ✅ |
| MCS-P02 | Consultoría | Prompt | Encargo consultivo completo, siete fases | ✅ |
| MCS-P03 | Quick scan | Prompt | Reconocimiento rápido, una página, quick wins | ✅ |
| MCS-P04 | Reabsorción | Prompt | Un solo uso: migrar los activos previos a esta estructura | ✅ |
| MCS-G01 | Ciclo de vida | Guía | Fases 0–11: repositorio, arquitectura, CI/CD, infraestructura, operación | ❌ |
| MCS-G02 | Diseño e interacción | Guía | Fases D0–D7: tokens, sistema de diseño, accesibilidad | ❌ |
| MCS-G03 | IA y agentes | Guía | Capas A0–A9 y AC: tools, MCP, orquestación, evals | ❌ |
| MCS-G04 | Disciplinas transversales | Guía | Tracks L, M, E, K. **Contiene la rúbrica del Track E** | ❌ |
| MCS-OP01 | Arranque de auditorías | Operativa | Poner en marcha las auditorías de la cartera | ❌ |

**Dos discrepancias con el mapa original.** El INDICE listaba MCS-OP02 «Reabsorción del
repositorio»; el documento entregado se autoidentifica como **MCS-P04**. Se conserva su
identificador propio: renombrarlo rompería las referencias, que TRZ-03 exige hacer por
identificador. Y las cuatro guías G01–G04 se listaban como existentes: **nunca fueron
creadas**. Ambas cosas están registradas como erratas.

---

## 3. Inventario de roles

Un **rol** es una configuración de agente que supera el umbral de la rúbrica de
autonomía de MCS-G04 track E. Todo lo que no lo supera es una skill, no un rol.

| Marco | Rol | Puntuación rúbrica | Estado |
|---|---|---|---|
| — | — | — | Pendiente de MCS-OP02 |

> El inventario se poblará al ejecutar MCS-OP02 sobre el repositorio previo.
> Expectativa declarada: la mayoría de los "agentes-rol" existentes se
> convertirán en skills. Eso es el resultado correcto.

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

Estados: Propuesta · En construcción · Vigente · Retirada.

---

## 5. Estado de conformidad del propio repositorio

Este repositorio se somete a sus propios marcos. Ver `mcs.yaml` en la raíz.

| Marco | Nivel objetivo | Nivel alcanzado | Última evaluación |
|---|---|---|---|
| MCS | N1 | Pendiente | — |
| MFB | N2 | **No alcanza N1** | 2026-08-02, parcial |

Un repositorio que aloja los marcos y no los cumple carece de autoridad.

**Por qué MFB no alcanza su propio N1 hoy**, con el conteo hecho durante el montaje de la
estructura y pendiente de ejecutar MFB-P02 en forma:

| Requisito | Estado | Motivo |
|---|---|---|
| EST-03 (toda marco DEBE tener ≥1 guía) | **NO CONFORME** en MCS | MCS no tiene ninguna guía. G01–G04 nunca se crearon |
| TRZ-01 (declarar dependencias en el encabezado) | CONFORME | Front-matter añadido a los seis documentos de MCS durante el montaje |
| TRZ-09 (no inventar normas ni identificadores) | CONFORME | Lo no verificado va marcado |
| NOM-05 (patrón de nombre de archivo) | PARCIAL | Los registros de erratas no tienen tipo admitido. Ver F-05 |
| NIV-07 (anexo de distribución) | **NO CONFORME** en ambos | Los dos anexos tienen cifras que no cuadran. Ver E-01 y F-01 |
| VER-04 (responsable y periodicidad) | CONFORME | — |

La carencia que más pesa es **EST-03**: el marco de software no tiene guía, y MFB-G01 §4
paso 4 explica por qué importa —los requisitos se descubren al explicar, no al legislar—.
MCS se escribió en el orden inverso al que MFB prescribe.

---

## 6. Mantenimiento de este índice

Actualizar al: crear un marco, añadir un documento, promover una skill de
propuesta a vigente, o completar una evaluación de conformidad.

Si este archivo lleva más de 90 días sin revisar, está desactualizado por
definición.

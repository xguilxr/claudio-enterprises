# Marco MCS — Producto 1 de este repositorio

| Campo | Valor |
|---|---|
| Tipo de documento | Explicación (Diátaxis) |
| Responsable | David Aguilar |
| Estado | Vigente |
| Fecha de emisión | 2026-08-02 |
| Próxima revisión | 2026-11-02 |
| Periodicidad | Trimestral |
| Depende de | `MCS-CORE-normativo.md` v2.0.0 |

---

## Qué hay acá

Este directorio aloja el **marco MCS**: el cuerpo normativo y explicativo que define qué
significa calidad de software en Claudio-Enterprises.

Es uno de los **dos productos** que conviven en este repositorio, con ciclos de vida
independientes:

| Producto | Ubicación | Naturaleza | Consumidor | Versionado |
|---|---|---|---|---|
| **El marco** | `marco/` | Normativo y explicativo | Personas, y agentes que lo leen como corpus | Propio, SemVer |
| **El paquete** | `plugins/claudio-agents-kit/` | Ejecutable e instalable | Claude Code / Cowork | Propio, SemVer |

**El paquete implementa el marco. El marco no depende del paquete.** Versionarlos juntos
es el error de diseño que esta separación evita: una errata de redacción en el normativo
no debe forzar una reinstalación del plugin, y una skill nueva no debe implicar que el
marco cambió.

---

## Contenido

```
marco/
├── MCS-CORE-normativo.md          # Documento normativo. 17 dominios, 204 requisitos, N1–N5
├── erratas-MCS-CORE-2.0.0.md      # Discrepancias verificadas contra v2.0.0, sin aplicar
├── prompts/
│   ├── MCS-P01-auditoria.md       # Auditoría de conformidad de una base de código
│   ├── MCS-P02-consultoria.md     # Conducción de un encargo consultivo, fases 0–7
│   ├── MCS-P03-quickscan.md       # Reconocimiento rápido, 15–30 min
│   └── MCS-P04-reabsorcion.md     # Reabsorción de un repo de agentes/skills
└── guias/                         # AUSENTE — ver "Qué falta"
```

---

## Jerarquía de autoridad

En caso de conflicto, prevalece el documento superior:

1. `MCS-CORE-normativo.md` — establece **qué se exige**
2. `guias/` (G01–G04) — explican **cómo cumplirlo**
3. `prompts/` (P01–P04) — **operaciones** que aplican el marco a un caso concreto

Un prompt nunca introduce requisitos. Si un prompt exige algo que el normativo no pide,
es un defecto del prompt.

---

## Qué falta

Declarado explícitamente para que nadie asuma que el marco está completo:

| Documento | Estado | Consecuencia de su ausencia |
|---|---|---|
| MCS-G01 — Ciclo de vida completo | **NO ENTREGADO** | — |
| MCS-G02 — Track de Diseño (UI/UX) | **NO ENTREGADO** | — |
| MCS-G03 — Track de IA (Agentes) | **NO ENTREGADO** | — |
| MCS-G04 — Disciplinas transversales L, M, E, K | **NO ENTREGADO** | **Bloqueante.** Contiene la rúbrica del Track E (seis dimensiones, 0–2 puntos) que `MCS-P04` exige para decidir qué activo sobrevive como agente y cuál se descompone en skill. Sin ella, esa decisión no tiene criterio declarado y violaría CON-10 |

`MCS-CORE` §0.3 declara estos cuatro documentos como parte del marco. Mientras no existan,
el marco está **incompleto**, no simplemente "en versión reducida".

---

## Cómo se usa cada prompt

| Situación | Prompt | Adjuntar |
|---|---|---|
| No sé qué tiene este repo y tengo 20 minutos | P03 | — |
| Necesito el nivel de conformidad real y un plan | P01 | `MCS-CORE-normativo.md` |
| Un cliente pide algo y no sé si es lo que necesita | P02 | `MCS-CORE` si llega a diseño |
| Tengo un repo de agentes/skills que quiero reordenar | P04 | Marco completo |

P03 alimenta la Etapa 1 de P01. P01 alimenta la Fase 2 de P02. No son intercambiables:
P03 declara explícitamente que **no** determina nivel de conformidad.

---

## Regla de versionado del marco

SemVer, conforme a `MCS-CORE` §0.2:

| Cambio | Bump |
|---|---|
| Se añade, elimina o endurece un requisito; cambia el nivel de uno existente | MAYOR |
| Se añade guía, ejemplo o anexo sin alterar requisitos | MENOR |
| Corrección de redacción, erratas o enlaces | PARCHE |

Los documentos de decisión se **reemplazan**, nunca se editan en silencio (DOC-08, CFG-18).
Por eso las erratas detectadas viven en un archivo aparte hasta que se decida emitir v2.0.1.

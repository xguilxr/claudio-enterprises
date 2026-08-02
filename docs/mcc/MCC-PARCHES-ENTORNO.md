---
id: MCC-PARCHES
titulo: Incorporación de MCC — parches al entorno
marco: —
capa: operativa
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 30d
uso: un solo uso
depende_de: [INDICE, ORQUESTADOR, MFB-CORE, MCC-CORE, glosario]
---

# Incorporación de MCC al entorno

Ejecutar en orden. Cierra el paso 8 de MFB-G01 §4.

---

# 1. Registro de la decisión de encaje

MFB-G01 §3 ya contenía el caso trabajado. Se confirma sin cambios.

| Dimensión | Puntuación | Razón |
|---|---|---|
| Audiencia | 2 | El cliente, no el desarrollador |
| Ciclo de vida | 2 | Cambia por razones propias: contratación, relación, honorarios |
| Aplicabilidad | 2 | Hay encargos consultivos que no construyen software |
| Cuerpo normativo externo | 1 | ISO 20700 y la serie ISO 21500 son propias; solapan poco con MCS |
| Volumen previsto | 2 | 92 requisitos |
| **Total** | **9** | **Familia nueva. Prefijo MCC** |

---

# 2. Solapamiento detectado (TRZ-05)

| Hallazgo | Resolución |
|---|---|
| MCS-P02 es un prompt de consultoría alojado en el marco de software | Migra a MCC-P01. MCS-P02 queda reemplazado, no duplicado (TRZ-02) |
| MCS-P02 §«Conexión con el marco MCS» duplicaba criterio de selección de nivel | El criterio vive en MCS-CORE §4.3. MCC lo referencia desde ANA-08 |
| MFB-TRZ-09 prohíbe inventar normas en documentos de la familia | MCC-INV-04 extiende la prohibición al material entregado al cliente. Ámbito distinto, no duplicación |
| MCS-ARQ-02 regula el registro de decisiones de arquitectura | MCC-PRO-10 lo referencia. No lo reescribe |
| MCS-P01 (auditoría) y MCS-P03 (quick scan) siguen siendo de MCS | Sin cambio. MCC los invoca como insumo del diagnóstico |

**Colisión de identificador corregida.** El prompt de inmersión sectorial se
numeró provisionalmente como MCS-P03. Ese identificador ya pertenece al quick
scan. El prompt de inmersión es **MCC-P02**.

---

# 3. Parche a `README.md`

## 3.1 Catálogo de marcos

```diff
 | Prefijo | Marco | Estado | Versión | Dominios | Requisitos |
 |---|---|---|---|---|---|
 | **MFB** | Construcción de Marcos | Vigente | 1.0.0 | 7 | 34 |
 | **MCS** | Calidad de Software | Vigente | 2.0.0 | 17 | 203 |
+| **MCC** | Consultoría de Tecnología | Vigente | 1.0.0 | 9 | 92 |
```

## 3.2 Marcos previstos

Eliminar la fila de MCC. Ya no está previsto: está construido.

## 3.3 Mapa de documentos

```diff
 └── mcs/
+
+└── mcc/                       ← Marco de Consultoría de Tecnología
+    ├── MCC-CORE.md
+    ├── guias/
+    ├── prompts/
+    └── plantillas/
```

## 3.4 Sección nueva: 2.3 MCC

| ID | Documento | Capa | Para qué |
|---|---|---|---|
| MCC-CORE | Documento normativo | Normativa | 92 requisitos, 9 dominios, niveles N1–N5 |
| MCC-G01 | El proceso consultivo | Guía | Etapas E0–E5, del encuadre a la transferencia |
| MCC-G02 | Inmersión sectorial | Guía | Método para dominar un rubro desconocido contra reloj |
| MCC-G03 | Economía del encargo | Guía | Costeo y estimación de esfuerzos |
| MCC-P01 | Conducción del encargo | Prompt | Reemplaza a MCS-P02 |
| MCC-P02 | Inmersión sectorial | Prompt | Ejecuta MCC-G02 con presupuesto de tiempo |
| MCC-P03 | Propuesta y costeo | Prompt | **Pendiente** |
| MCC-P04 | Estimación de esfuerzos | Prompt | **Pendiente** |
| MCC-T01 | Ficha de encargo | Plantilla | **Pendiente** |
| MCC-T02 | Propuesta al cliente | Plantilla | **Pendiente** |

## 3.5 Inventario de skills

```diff
+| MCC | encuadrar-encargo | Produce la ficha de encargo y clasifica el tipo | CTR-01..06 | Propuesta |
+| MCC | inmersion-sectorial | Dossier y kit de reunión de un rubro nuevo | INV-01..09 | Propuesta |
+| MCC | estimar-esfuerzo | Descompone, estima en rango y declara supuestos | ESF-01..07 | Propuesta |
+| MCC | costear-solucion | Cuatro capas de costo con cifras vivas fechadas | ECO-01..09 | Propuesta |
+| MCC | plan-por-tandas | Convierte alcance en tandas con resultado observable | PLA-01..05 | Propuesta |
```

## 3.6 Conformidad del repositorio

```diff
 | MCS | N1 | Pendiente | — |
 | MFB | N2 | Pendiente | — |
+| MCC | N1 | Pendiente | — |
```

---

# 4. Parche a `MFB-CORE.md` anexo B

```diff
 | EST, NOM, NIV, TRZ, RED, VER, ACT | MFB | Construcción de marcos |
 | GOB, CFG, REQ, ARQ, DIS, LEN, DAT, DEV, INT, SUM, INF, DES, OPS, SEG, IA, DOC, CON | MCS | Calidad de software |
+| CTR, INV, ANA, PRO, ECO, ESF, PLA, ENT, CLI | MCC | Consultoría de tecnología |
```

Retirar de la lista de disponibles: CTR, INV, ANA, PRO, ECO, PLA, ENT, CLI.
**ESF es código nuevo**, no figuraba entre los sugeridos. Verificado como único.

Disponibles tras el parche: ADQ, CAL, COM, ECO*, EDU, EQP, EVA, FIN, GES, JUR,
MER, ODC, PER, RSG, SRV, TAL, VTA.

\* ECO queda ocupado por MCC.

Este parche es **versión menor** de MFB-CORE (1.1.0): actualiza un anexo de
registro, no añade ni endurece requisitos (CONVENCIONES §6).

---

# 5. Parche a `conocimiento/glosario.yaml`

Añadir. Los términos ya existentes **cifra viva**, **frontera de competencia**,
**nivel de conformidad** y **skill** se reutilizan sin cambio; añadir `MCC` a su
lista de marcos.

```yaml
  - id: encargo
    es: encargo
    en: engagement
    definicion_es: >
      Unidad de trabajo consultivo con un solo cliente, una pregunta central y un
      criterio de éxito declarado y comprobable al cierre.
    no_usar_es: [proyecto, contrato, trabajo, cuenta]
    marcos: [MCC]

  - id: inmersion-sectorial
    es: inmersión sectorial
    en: sector immersion
    definicion_es: >
      Estudio acotado en tiempo del subsegmento del cliente, previo al
      descubrimiento, orientado a conducir la conversación con solvencia y a
      detectar anomalías operativas.
    no_usar_es: [research, investigación de mercado, onboarding]
    marcos: [MCC]

  - id: subsegmento
    es: subsegmento
    en: subsegment
    definicion_es: >
      Nivel de desagregación de un rubro en el que la operación y los sistemas
      son homogéneos. «Restaurantes» no lo es; «comida rápida con franquicia» sí.
    no_usar_es: [nicho, vertical, sector]
    marcos: [MCC]

  - id: hallazgo
    es: hallazgo
    en: finding
    definicion_es: >
      Afirmación sobre la situación del cliente, sostenida por evidencia
      identificable y registrada durante el descubrimiento o el diagnóstico.
    no_usar_es: [observación, insight, conclusión]
    marcos: [MCC, MCS]

  - id: tanda
    es: tanda
    en: increment
    definicion_es: >
      Agrupación de trabajo que produce un resultado observable por sí misma, sin
      depender de la siguiente para aportar valor.
    no_usar_es: [fase, sprint, entrega, milestone]
    marcos: [MCC]

  - id: kit-reunion
    es: kit de reunión
    en: meeting kit
    definicion_es: >
      Salida de la inmersión sectorial: tarjeta de una pantalla, preguntas de
      descubrimiento e hipótesis de necesidad con su criterio de descarte.
    no_usar_es: [briefing, one-pager]
    marcos: [MCC]
```

Subir `meta.version` a 1.1.0.

---

# 6. Parche a `ORQUESTADOR.md`

## 6.1 Tabla de ruteo

```diff
-| Conducir un encargo de cliente | MCS-P02 | L2 |
+| Conducir un encargo de cliente | MCC-P01 | L2 |
+| Entrar a un rubro que no conozco | MCC-P02 | L2 |
+| Preparar una propuesta con costos | MCC-G03 + MCC-P03 | L2 |
+| Estimar esfuerzo de un alcance | MCC-G03 §2 | L2 |
+| Planificar por fases un encargo aprobado | MCC-G01 §5 | L2 |
+| Auditar la conducción de un encargo | MCC-CORE | L3 |
```

## 6.2 Precedencia

Añadir al §4:

> 5. **MCC gobierna el encargo; MCS gobierna el producto.** Cuando ambos
>    aplican, MCC determina qué se acuerda y MCS qué se construye. El nivel de
>    conformidad del producto se propone en MCC-ANA-08 y se declara en
>    MCC-ENT-07, pero su contenido lo define MCS-CORE.

---

# 7. Migración de MCS-P02

1. Mover el archivo a `mcc/prompts/MCC-P01-conduccion-encargo.md`
2. En el nuevo documento: `id: MCC-P01`, `marco: MCC`, `version: 2.0.0`,
   `depende_de: [MCC-CORE, MCC-G01, MCS-CORE]`
3. Dejar en `mcs/prompts/MCS-P02.md` un documento de reemplazo con
   `estado: reemplazado`, `reemplazado_por: MCC-P01` (VER-05)
4. Sustituir en el cuerpo del prompt las referencias «marco MCS» por el
   requisito de MCC que corresponde. En concreto, las Fases 0 a 7 mapean así:

| Fase del prompt | Requisitos que cierra |
|---|---|
| 0 Encuadre | CTR-01..06, CLI-01 |
| 1 Descubrimiento | ANA-06 |
| 1B Inmersión | Dominio INV completo |
| 2 Diagnóstico | ANA-01..09 |
| 3 Opciones | PRO-01..08, ECO-01..09 |
| 4 Diseño | PRO-09..11 |
| 5 Hoja de ruta | ESF-01..10, PLA-01..10 |
| 6 Entregables | ENT-01..02, ENT-04 |
| 7 Transferencia | ENT-03, ENT-05..07 |

5. MCS-CORE **no cambia de versión**: no se añade, elimina ni endurece ningún
   requisito suyo. Solo se retira un prompt (VER-03 no aplica).

---

# 8. Autoauditoría contra MFB

Paso 10 de MFB-G01 §4, ejecutado sobre MCC v1.0.0.

| Requisito | Estado | Nota |
|---|---|---|
| EST-01 un solo normativo | CONFORME | MCC-CORE |
| EST-02 requisitos solo en normativa | CONFORME | Las tres guías no contienen DEBE |
| EST-03 al menos una guía | CONFORME | G01, G02, G03 |
| EST-04 capa declarada | CONFORME | Front-matter |
| EST-05 directorio único | CONFORME | `mcc/` |
| EST-06 al menos un prompt | CONFORME | MCC-P01, MCC-P02 |
| EST-07 antipatrones explícitos | CONFORME | G01 §7, G02 §7, G03 §4 |
| EST-08 puerta por dominio | **PARCIAL** | G01 §8, G02 §8, G03 §5 cubren siete dominios. Faltan puertas propias para CLI |
| EST-09 plantillas | **NO CONFORME** | MCC-T01 y T02 pendientes. Requisito N3 |
| EST-10 skills | **NO CONFORME** | Cinco propuestas, ninguna construida. N3 |
| NOM-01..07 | CONFORME | ESF verificado como único; anexo B parcheado |
| NIV-01..06 | CONFORME | Verificado por conteo automático |
| NIV-07 anexo distribución | CONFORME | Anexo A, cuadrado con el cuerpo |
| NIV-08 estados y regla | CONFORME | §6 |
| NIV-09 plantilla de conformidad | CONFORME | Anexo B |
| TRZ-01 dependencias | CONFORME | Front-matter |
| TRZ-02..04 | CONFORME | Ver §2 de este documento |
| TRZ-05 solapamiento reportado | CONFORME | §2 |
| TRZ-06 índice actualizado | CONFORME al aplicar §3 | |
| TRZ-07 grafo automático | CONFORME | Front-matter estructurado |
| TRZ-08 estándares externos | CONFORME | MCC-CORE §2, con declaración de ausencia para ECO e INV |
| TRZ-09 no inventar normas | CONFORME | Cuatro normas verificadas por consulta; ediciones dudosas marcadas |
| RED-01..05 | CONFORME | |
| VER-01..04 | CONFORME | |
| ACT-01..06 | CONFORME | Disparadores en MCC-CORE §1.2; aplicación parcial en §1.3 |

**Nivel alcanzado: MFB-N2.** N3 exige EST-09 y EST-10, ambas pendientes.

---

# 9. Trabajo pendiente, por orden

| # | Qué | Por qué en esta posición |
|---|---|---|
| 1 | Aplicar los parches 3 a 6 | Sin ellos, el marco existe pero no está conectado |
| 2 | Migrar MCS-P02 a MCC-P01 | Hay un documento con dos identificadores posibles |
| 3 | MCC-P02, inmersión sectorial | Es el cuello de botella declarado del proceso |
| 4 | MCC-P03, propuesta y costeo | Cierra ECO y PRO, hoy sin herramienta |
| 5 | MCC-P04, estimación | Puede vivir dentro de P03 si el volumen no lo justifica |
| 6 | MCC-T01 y T02 | Cierran EST-09 y suben a MFB-N3 |
| 7 | Skills | Cierran EST-10 y quitan la tabla de ruteo del medio |

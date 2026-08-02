# Erratas verificadas contra MCS-CORE v2.0.0

| Campo | Valor |
|---|---|
| Tipo de documento | Referencia (Diátaxis) |
| Responsable | David Aguilar |
| Estado | Abierto — pendiente de decisión |
| Fecha | 2026-08-02 |
| Depende de | `MCS-CORE-normativo.md` v2.0.0 |
| Próxima revisión | Al emitir v2.0.1 |

---

## Por qué existen estas erratas y no correcciones

`MCS-CORE` establece en CFG-18 y DOC-08 que los documentos normativos se versionan
mediante reemplazo, **nunca mediante edición silenciosa**. Corregir el normativo sin
emitir versión sería incumplir el propio marco dentro del repositorio que lo aloja.

Por eso el documento se incorporó **literal** (verificado por resumen criptográfico
al copiarlo) y las discrepancias se registran acá. Aplicarlas exige emitir **v2.0.1**
—PARCHE, por tratarse de erratas y no de cambios de requisito— con entrada en el
historial de §0.2.

Ninguna errata altera un requisito. Todas son de consistencia interna.

---

## E-01 · Anexo A: la fila DAT no cuadra consigo misma — GRAVEDAD MEDIA

**Ubicación:** Anexo A, fila `DAT`.

**Lo que dice:**

| Dominio | N1 | N2 | N3 | N4 | N5 | Total |
|---|---|---|---|---|---|---|
| DAT | 6 | 8 | 2 | 2 | — | 19* |

La fila suma **18**, pero declara **19**.

**Lo verificado**, contando requisito por requisito en §5.7.1 y §5.7.2:

| Subgrupo | N1 | N2 | N3 | N4 |
|---|---|---|---|---|
| §5.7.1 Formulación en el código (DAT-01…08) | 6 (DAT-01…06) | 2 (DAT-07, 08) | — | — |
| §5.7.2 Métricas y presentación (DAT-09…19) | 4 (DAT-09…12) | 4 (DAT-13…16) | 1 (DAT-17) | 2 (DAT-18, 19) |
| **Total** | **10** | **6** | **1** | **2** |

**Causa probable:** la fila recoge únicamente el subgrupo §5.7.1 en N1 y arrastra un
conteo previo en N2/N3. El asterisco al pie (`DAT incluye los subgrupos 5.7.1 y 5.7.2`)
sugiere que la suma se revisó pero la distribución por nivel no.

**Corrección propuesta:**

| Dominio | N1 | N2 | N3 | N4 | N5 | Total |
|---|---|---|---|---|---|---|
| DAT | 10 | 6 | 1 | 2 | — | 19 |

**Consecuencia si no se corrige:** un auditor que planifique el esfuerzo de alcanzar N1
usando el Anexo A subestima el dominio DAT en cuatro requisitos —y son precisamente los
de presentación de cifras (DAT-09 indicador único, DAT-10 ficha versionada, DAT-11 periodo
y marca de actualización, DAT-12 nulo distinguible de cero), que son de los más caros de
retrofitear.

---

## E-02 · Anexo A: los totales generales se arrastran de E-01 — GRAVEDAD MEDIA

**Ubicación:** Anexo A, fila `Total`, y el párrafo "Lectura práctica" que la sigue.

Corregida la fila DAT, los totales cambian. Se verificaron **los 17 dominios uno a uno**;
solo DAT estaba mal, pero los agregados dependen de él.

| Magnitud | Publicado | Verificado |
|---|---|---|
| Requisitos N1 | 64 | **68** |
| Requisitos N2 | 60 | **58** |
| Requisitos N3 | 37 | **36** |
| Requisitos N4 | 28 | 28 |
| Requisitos N5 | 14 | 14 |
| **Total del marco** | **203** | **204** |
| Acumulado para N2 | 124 | **126** |
| Peso de N1+N2 sobre el marco | 61 % | **62 %** |

La suma de las filas del Anexo A ya daba 204; solo la fila de totales daba 203. La
discrepancia de una unidad es exactamente la fila DAT.

**Corrección propuesta:** sustituir la fila de totales y ajustar la Lectura práctica a
«alcanzar N1 exige 68 requisitos; alcanzar N2 exige 126 acumulados».

La conclusión cualitativa del párrafo no cambia: el grueso del marco sigue concentrado
en los dos primeros niveles.

---

## E-03 · Pie del documento declara una versión que no es la suya — GRAVEDAD BAJA

**Ubicación:** última línea del documento.

**Dice:** `**Fin del documento MCS-CORE v1.0.0**`
**Debe decir:** `**Fin del documento MCS-CORE v2.0.0**`

§0.1 declara `Versión: 2.0.0` y §0.2 registra el salto a 2.0.0. El pie quedó sin actualizar
en la conversión.

**Por qué importa más de lo que parece:** un documento normativo que se identifica con dos
versiones distintas en el mismo archivo no es citable con precisión. Cualquier hallazgo de
auditoría que diga «no conforme según MCS-CORE» queda expuesto a la objeción de qué versión
se aplicó.

---

## E-04 · Anexo B: la plantilla de conformidad fija una versión de marco obsoleta — GRAVEDAD BAJA

**Ubicación:** Anexo B, plantilla `mcs.yaml`.

```yaml
marco:
  version: 1.0.0     # ← el marco vigente es 2.0.0
```

Un producto que copie la plantilla tal cual declara conformidad contra un marco que ya no
existe, y omite en silencio los 17 requisitos del dominio CON incorporados en v2.0.0.

**Corrección propuesta:** `version: 2.0.0`, y añadir un comentario que advierta que el
campo debe coincidir con la versión realmente auditada, no con la vigente.

---

## E-05 · Deriva conceptual entre el normativo y P04: «capa AC» vs dominio CON — GRAVEDAD MEDIA

**Ubicación:** `prompts/MCS-P04-reabsorcion.md`, Etapa 1.2 («antipatrón en la capa AC.9»)
y Etapa 5.3 («crea las fichas conforme a la capa AC»).

`MCS-CORE` v2.0.0 no define ninguna «capa AC». El conocimiento del dominio es el
dominio **CON** (§5.17), con identificadores CON-01…CON-17. No existe `AC.9`.

Esto es **deriva conceptual** en el sentido exacto de §3.4 del propio normativo: un mismo
concepto con nombres distintos en partes distintas del sistema, sin fallo detectable. Y
contradice LEN-01, que exige glosario canónico con términos prohibidos.

**Hipótesis:** «AC» procede de una numeración anterior a la conversión a documento
normativo (§0.2 registra que CON se incorporó recién en v2.0.0). No verificable sin las
guías G01–G04.

**Corrección propuesta:** en P04, sustituir «capa AC» por «dominio CON» y «AC.9» por la
referencia concreta —presumiblemente CON-02, que prohíbe implementar competencia mediante
instrucciones de rol. **No aplicar sin confirmación**: si «AC.9» apunta a otra cosa en G04,
la sustitución introduce un error peor que el que corrige.

---

## E-06 · Referencias fantasma: las guías G01–G04 no existen — GRAVEDAD ALTA (bloqueante)

> **Actualizado 2026-08-02.** La redacción anterior asumía que las guías existían y no
> habían sido entregadas. David confirma que **nunca fueron creadas**. Eso cambia la
> naturaleza del hallazgo: no es una dependencia no satisfecha, es una referencia a
> documentos inexistentes dentro de un documento normativo.

**Ubicación:** `MCS-CORE-normativo.md` §0.3, y `prompts/MCS-P04-reabsorcion.md` Etapa 2.

§0.3 declara cuatro guías de aplicación —G01 ciclo de vida, G02 diseño, G03 IA, G04
disciplinas transversales— como documentos del marco. **Ninguna existe.**

P04 depende de una de ellas: *«Aplica a cada supuesto agente la rúbrica del Track E (seis
dimensiones, 0 a 2 puntos)… Solo sobrevive como AGENTE lo que puntúe 9 o más Y tenga
catálogo de herramientas real.»* El Track E es la «E» de las disciplinas L, M, E, K de G04.

**Doble consecuencia:**

1. La decisión central de la reabsorción —qué sigue siendo agente y qué se descompone en
   skill— no tiene criterio declarado. Inventar la rúbrica incumple CON-10 (*la selección
   entre marcos, metodologías o instrumentos alternativos DEBE regirse por una rúbrica
   declarada y versionada, no por criterio no explicitado del modelo*).
2. Un normativo que cita documentos inexistentes se autodesautoriza. Es el mismo defecto
   que el propio marco tipifica en el patrón transversal 11 de P01: *documentación que
   describe un comportamiento que el código ya no tiene*.

**Corrección propuesta en dos partes:**

- **Sobre §0.3:** marcar las cuatro guías como `PLANIFICADA — no emitida`, o retirarlas de
  la tabla. Una tabla de documentos relacionados donde ninguno existe es peor que ausente.
- **Sobre la rúbrica:** redactarla. No es recuperable de ningún lado. Base disponible en el
  propio normativo: §3.7 (flujo de trabajo) y §3.8 (agente) ya distinguen los dos conceptos,
  e IA-06 exige que el nivel de autonomía se determine «mediante la rúbrica establecida» y
  se registre en un ADR. Se versiona en `conocimiento/rubricas/` y se marca
  `PENDIENTE DE VALIDACIÓN` hasta que David la confirme.

Redactarla con esa base cumple CON-10 en forma y en fondo: el criterio queda declarado,
versionado y trazable a los términos que el normativo ya define. Lo que no cumple es CON-08
—conjunto de evaluación certificado por experto distinto de quien desarrolla— hasta que
David la valide.

---

## Observaciones sin gravedad asignada

**O-01 · Historial de versiones sin dispersión temporal.** §0.2 fecha las cinco versiones
(0.1.0 a 2.0.0) el mismo día, 2026-08-02. Es coherente con un marco redactado de una vez,
pero deja el historial sin valor como evidencia de evolución, que es para lo que GOB-07 y
CFG-23 exigen conservarlo.

**O-02 · §0.1 declara `Reemplaza a: —`.** El propio historial registra una v1.0.0 previa.
Si la intención es que cada versión mayor reemplace a la anterior como documento distinto
—que es lo que CFG-18 describe—, el campo debería apuntar a v1.0.0. Si la intención es que
el archivo sea único y el historial haga de traza, entonces el campo es correcto y lo que
sobra es la exigencia de reemplazo bidireccional aplicada a sí mismo. Requiere decisión,
no corrección.

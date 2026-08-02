---
id: CONOCIMIENTO
titulo: Eje común — glosario canónico y su verificación
marco: —
capa: operativa
version: 1.1.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente
depende_de: [glosario, MFB-CORE, MCS-CORE, CONVENCIONES]
---

# Eje común

`glosario.yaml` es el **único** artefacto compartido por toda la familia (MFB §2.5).
**21 términos** en v1.1.0. Ningún marco es su propietario.

Tres requisitos dependen de él: TRZ-04 (ningún marco mantiene glosario propio), RED-02
(un concepto se nombra siempre con el término del glosario) y LEN-01 (glosario canónico
versionado).

---

## Verificación contra MFB-CORE y MCS-CORE

Ejecutada al incorporarlo, 2026-08-02. Cuatro hallazgos. Ninguno impide usar el glosario;
los cuatro impiden **verificarlo automáticamente**, que es lo que LEN-04 exige.

### G-01 · TRZ-04 no conforme: los dos normativos mantienen glosario propio

| Documento | Términos que define | Ya en el glosario |
|---|---|---|
| `MCS-CORE` §3 | 12 | 10 |
| `MFB-CORE` §2 | 5 | 4 |

**14 definiciones duplicadas.** TRZ-04 lo prohíbe expresamente: *«NO DEBE mantener glosario
propio para conceptos ya definidos»*. Y MFB-G01 §5 lo repite: *«define solo los términos
propios de la materia que no existan ya en el glosario canónico. Duplicar una definición es
garantizar divergencia»*.

**Corrección:** dejar en §3 y §2 únicamente los términos que el glosario no cubre, y
sustituir el resto por una referencia. Es cambio de PARCHE —no toca requisitos— pero afecta
a un normativo, así que exige emitir versión.

### G-02 · Tres términos definidos en los normativos y ausentes del glosario

> **Parcialmente resuelto en v1.1.0.** La incorporación de MCC añadió seis términos
> —encargo, inmersión sectorial, subsegmento, hallazgo, tanda, kit de reunión— y `hallazgo`
> cubre un concepto que MCS ya usaba sin definir. Los tres de abajo siguen ausentes.

| Término | Definido en | Por qué importa |
|---|---|---|
| **requisito aplicable** | MCS §3.9 | Es el que decide qué se evalúa en una auditoría |
| **corpus de dominio** | MCS §3.10 | Sostiene los 17 requisitos del dominio CON |
| **eje común** | MFB §2.5 | Define lo que el propio glosario es |

Que «eje común» no esté en el eje común es el caso más claro: el glosario no se define a
sí mismo.

Faltan además cuatro conceptos que los marcos usan como término técnico sin definirlos en
ningún sitio con capa normativa: **antipatrón** (lo exige EST-07), **disparador de
activación** (lo exige ACT-02 y es el mecanismo sobre el que descansa todo el orquestador),
**ADR** (lo invocan GOB-02, ARQ-02 y la cláusula DEBERÍA de MFB) y **rol** — ver G-03.

### G-03 · Las listas `no_usar` vetan palabras que los marcos usan legítimamente

`no_usar_es` expresa sinonimia prohibida, pero está redactada como prohibición del término.
Un verificador de terminología (LEN-04) marcaría hoy decenas de falsos positivos:

| Término vetado | Como sinónimo de | Usos legítimos en MCS-CORE | Qué son en realidad |
|---|---|---|---|
| `modelo` | marco | **12** | Modelo de lenguaje, modelo de amenazas, modelo de datos, modelo de niveles |
| `control` | requisito | **11** | Control de versiones, control de cambios, controles de OWASP, controles automáticos |
| `competencia` | skill | **10** | Competencia experta y **frontera de competencia**, que el propio glosario define |
| `regla` | requisito | 4 | Regla de versionado, reglas de conformidad, regla de combinación |
| `criterio` | requisito | 3 | Criterio de aceptación (REQ-01), criterio no explicitado (CON-10) |

Ninguno de esos 40 usos es un sinónimo de lo vetado. El caso de `competencia` es el más
grave porque el glosario se contradice: veta la palabra y a la vez define
`frontera-competencia` con ella.

v1.1.0 añade dos choques más, de los términos de MCC: `entrega` vetado como sinónimo de
`tanda` pero usado 5 veces en MCS-CORE con su sentido propio —entrega a producción, CFG-07—
y `contrato` vetado como sinónimo de `encargo` y usado con sentido jurídico.

**Contraste que importa:** los documentos de MCC **sí respetan los vetos**. Cero usos de
`proyecto`, `fase` o `sprint` en MCC-CORE y MCC-G01. La disciplina terminológica existe
donde el glosario se escribió antes que el documento; falla donde se escribió después.

**Corrección:** renombrar el campo a `no_usar_como_sinonimo_es`, o añadir los conceptos
homónimos como términos propios. Sin esto, LEN-04 no puede automatizarse: el primer informe
tendría más ruido que señal y nadie volvería a ejecutarlo.

### G-04 · `rol` está vetado y a la vez es un concepto de primera clase

`glosario.yaml` veta `rol` como sinónimo de `agente`. `README.md` §3 lo usa como concepto
propio: *«Un rol es una configuración de agente que supera el umbral de la rúbrica de
autonomía»*, y sobre esa distinción descansa el inventario de roles y toda la clasificación
rol/skill de la reabsorción.

Dos problemas encadenados. El concepto está definido en el **índice**, que tiene capa
`indice` y no debería definir nada. Y su definición depende de la rúbrica del Track E, que
vive en MCS-G04 y **no existe** (MCS-ERRATAS E-06).

**Corrección:** añadir `rol` al glosario como término propio, y ajustar el `no_usar` de
`agente` a la forma de sinonimia. La definición no puede cerrarse hasta que exista la
rúbrica.

---

## Divergencias menores de definición

Dos casos donde el glosario endurece lo que dice el normativo. En ambos el glosario es
mejor, así que la corrección va en el normativo:

| Término | MCS-CORE | Glosario |
|---|---|---|
| cifra viva | «no forma parte del corpus» | «no forma parte de ningún corpus **ni documento**» |
| escenario de calidad | «medida de respuesta» | «medida de respuesta **con valor numérico**» — coincide con REQ-02 |

---

## Pendiente

La puerta de calidad de MFB-G01 §7 —*«el glosario canónico absorbió los términos nuevos»*—
se cumplió para MCC. El siguiente marco entra igual: sus términos primero, su normativo
después.

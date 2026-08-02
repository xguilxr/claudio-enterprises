---
id: MFB-ERRATAS
titulo: Erratas verificadas contra MFB-CORE v1.0.0
marco: MFB
capa: operativa
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 30d
uso: recurrente
depende_de: [MFB-CORE, INDICE, ORQUESTADOR]
---

# Erratas · MFB-CORE v1.0.0

Registradas sin aplicar: VER-05 exige reemplazo, no edición silenciosa. Corregirlas es
emitir v1.0.1 (PARCHE: ninguna altera un requisito).

---

## F-01 · MFB declara tres cifras distintas de requisitos — MEDIA

Conteo verificado, requisito por requisito:

| Dominio | N1 | N2 | N3 | Total |
|---|---|---|---|---|
| EST | 5 | 3 | 2 | 10 |
| NOM | 6 | 1 | — | 7 |
| NIV | 6 | 3 | — | 9 |
| TRZ | 2 | **6** | 1 | **9** |
| RED | 2 | 3 | — | 5 |
| VER | 4 | — | 2 | 6 |
| ACT | 2 | 4 | — | 6 |
| **Total** | **27** | **20** | **5** | **52** |

Lo publicado:

| Fuente | Dice | Real |
|---|---|---|
| MFB-CORE §0 historial | 34 | 52 |
| INDICE §1 catálogo | 34 | 52 |
| MFB-CORE Anexo A | 51 | 52 |

El error de una unidad está en la fila TRZ: declara N2=5 y total 8, pero TRZ tiene nueve
requisitos (TRZ-01…09) y seis en N2 (02, 03, 04, 05, 06, 08). La nota al pie —«TRZ-08 y
TRZ-09 se contabilizan en sus niveles respectivos»— describe lo correcto; la fila no lo
refleja.

El 34 es de otra generación del documento: ni coincide con el Anexo A ni con el contenido.

**Consecuencia:** MFB exige en NIV-07 un anexo con la distribución por nivel y dominio.
El suyo propio no cuadra. Es el mismo defecto que MCS-CORE tiene en su fila DAT (errata
E-01), lo que sugiere que el conteo manual de anexos necesita un control automático, no
más cuidado.

---

## F-02 · Los totales de la familia se arrastran — BAJA

`ORQUESTADOR.md` §El problema que resuelve: «Un cuerpo normativo de **237 requisitos**».

237 = 203 (MCS publicado) + 34 (MFB publicado). Con los conteos verificados:
204 + 52 = **256**.

El argumento del orquestador no cambia — sigue siendo demasiado para cargar siempre—,
pero la cifra es citable y hoy es falsa.

---

## F-03 · Dependencia circular entre MFB-CORE y CONVENCIONES — MEDIA

`MFB-CORE` declara `depende_de: [INDICE, CONVENCIONES, glosario]`.
`CONVENCIONES` declara `depende_de: [MFB-CORE]`.

TRZ-07 exige que el grafo de dependencias pueda generarse automáticamente desde los
encabezados. Un ciclo lo impide: no hay orden de lectura ni de validación.

**Causa de fondo:** RED-01 hace que el normativo dependa de CONVENCIONES para su redacción,
mientras CONVENCIONES existe como desarrollo de NOM y RED. La relación real es de
desarrollo, no de dependencia.

**Corrección propuesta:** retirar `CONVENCIONES` del `depende_de` de MFB-CORE. La capa
declarada de CONVENCIONES ya es `normativa-derivada`, que expresa la subordinación sin
crear ciclo.

---

## F-04 · `normativa-derivada` no es una capa admitida — BAJA

EST-04 y CONVENCIONES §3 enumeran cinco capas: normativa, guía, prompt, operativa,
plantilla. `CONVENCIONES.md` declara `capa: normativa-derivada`, y `README.md` declara
`capa: indice`. Ninguna de las dos existe en la enumeración.

**Dos lecturas, decisión pendiente:** o la enumeración se amplía a siete, o esos dos
documentos usan una capa admitida. La segunda es preferible: cada capa nueva multiplica
las reglas que la gobiernan.

---

## F-05 · Falta un tipo de documento para registros de defectos — BAJA

NOM-06 admite CORE, G, P, OP y T. Este documento no es ninguno: no exige, no explica, no
se ejecuta, no secuencia y no se rellena. Es un registro de defectos entre versiones.

VER-05 lo hace necesario: si un normativo se reemplaza en vez de editarse, los defectos
detectados entre versiones necesitan dónde vivir mientras tanto.

Provisionalmente declarado `capa: operativa`. **Corrección propuesta:** añadir el tipo
`E` (erratas) a NOM-06.

---

## Observación

**O-01 · Los conteos de anexo son el punto débil sistemático.** Tres anexos revisados
—MCS Anexo A, MFB Anexo A, INDICE §1— y los tres tienen cifras que no cuadran con su
propio contenido. Ninguno es un error de criterio; todos son de aritmética manual. La
corrección duradera no es revisarlos mejor: es generarlos desde los requisitos. Encaja
con TRZ-07, que ya exige generación automática del grafo de dependencias.

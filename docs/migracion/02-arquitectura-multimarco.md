---
id: MIG-02
titulo: Propuesta de arquitectura multi-marco
marco: MCS
capa: operativa
version: 1.0.0
estado: reemplazado
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: un solo uso
depende_de: [MCS-P04, MCS-CORE, MFB-CORE]
---

# Propuesta: de un marco de software a varios marcos conectados

> ## ⛔ REEMPLAZADO por MFB-CORE v1.0.0 y MFB-G01 v1.0.0 — 2026-08-02
>
> Este documento se escribió sin conocer que MFB ya existía. Se conserva por VER-05
> (reemplazo, no borrado) y porque una parte se confirmó.
>
> **Confirmado por MFB.** Los tres mecanismos de conexión son correctos y están en el
> marco real: identificadores de dominio únicos en toda la familia (NOM-02), escala N1–N5
> compartida (NIV-01), y glosario canónico único (TRZ-04). MFB §2.5 va más lejos y declara
> el glosario como el **único** eje común de la familia.
>
> **Refutado por MFB.** La propuesta central —partir MCS en `MC-BASE` + vertical software—
> **no se hace**. MFB resuelve la interconexión sin capa base: cada marco es autónomo con
> su prefijo, y lo compartido se referencia por identificador (TRZ-02, TRZ-03) en lugar de
> extraerse a un tronco común. La rúbrica de encaje de MFB-G01 §3 aplicada a la propuesta
> la habría frenado antes de escribirla, y el antipatrón 1 —«marco por tema»— describe con
> exactitud el riesgo que introducía.
>
> **Sigue vivo.** El requisito de economía de expresión (abajo, LEN-09 y LEN-10) no está en
> MFB ni en MCS. Se mantiene como propuesta y se decidirá dónde ubicarlo: RED de MFB si
> gobierna la redacción de los marcos, LEN de MCS si gobierna lo que emite el producto.
> Probablemente ambos, con uno referenciando al otro.

---

## El problema

MCS cubre software. Añadir un marco de consultoría, uno de datos o uno comercial junto a
él produce cuatro documentos que se solapan, cada uno con su escala de madurez y su
vocabulario. Eso no es un sistema de marcos: es un cajón.

Lo que hace que varios marcos formen un sistema no es que compartan carpeta. Son tres
mecanismos, y hay que declararlos antes de escribir el segundo marco.

---

## El seam ya existe

MCS-CORE tiene dentro dos cosas mezcladas: lo que aplica a cualquier materia y lo que
aplica solo a software. Nunca se declaró la frontera, pero está.

| Capa | Dominios | Req. | Por qué ahí |
|---|---|---|---|
| **Base** | GOB, CFG, DOC, LEN, CON | 66 | Gobierno, versionado, documentación, terminología y conocimiento del dominio no son conceptos de software. CON lo dice explícito en §5.17: aplica a *«todo producto que emita afirmaciones sobre una materia especializada»* |
| **Vertical software** | REQ, ARQ, DIS, DAT, DEV, INT, SUM, INF, DES, OPS, SEG, IA | 138 | Arquitectura, despliegue, cadena de suministro: no significan nada fuera de software |

**El corte no es limpio y conviene decirlo ahora.** Dentro de CFG hay requisitos genéricos
(CFG-01 a CFG-06: control de versiones, ausencia de secretos, SemVer) y otros que solo
existen en software: CFG-10 contrato de interfaz de programación, CFG-11 migraciones de
esquema, CFG-16 artefactos por resumen criptográfico. Igual DOC-03 (*lo que pueda generarse
a partir del código*).

Los identificadores son inmutables (§0.5). Un requisito que se queda en el vertical
conserva su número; no se renumera nada. La base se queda con los genéricos, el vertical
con los suyos, y ningún ID cambia de significado.

---

## Los tres mecanismos de conexión

Sin estos tres, los marcos se apilan en vez de conectarse.

**1 · Espacio de identificadores único.** El código de dominio de tres letras es global, no
por marco. `SEG` es seguridad de software y ningún otro vertical puede usar `SEG` para otra
cosa. Un registro en la base lista los códigos tomados. Sin esto, `RIE-04` significa cosas
distintas según quién lo cite, y los informes de auditoría dejan de ser comparables.

**2 · Escala de niveles única.** N1–N5 significan lo mismo en todos los verticales:
fundacional, profesional, escalable, auditable, corporativo. La regla de conformidad de §6.2
—el nivel alcanzado es el mayor N con todos los requisitos DEBE en conforme o no
aplicable— se define una vez en la base y no se reescribe.

Un producto declara **un nivel por vertical aplicable**:

```yaml
conformidad:
  base:        { declarado: N2, alcanzado: N1 }
  software:    { declarado: N2, alcanzado: N1 }
  consultoria: { declarado: N1, alcanzado: N1 }
```

**3 · Glosario canónico único** (LEN-01), en la base. Es lo único que impide la deriva
conceptual *entre* verticales. Si «entregable» significa una cosa en el marco de software y
otra en el de consultoría, los dos marcos se contradicen sin que nada falle — que es la
definición exacta de deriva conceptual de §3.4.

Un cuarto mecanismo, menor pero necesario: una **rúbrica de aplicabilidad** que diga qué
vertical aplica a qué encargo. Sin ella, la elección de vertical queda al criterio no
explicitado de quien audita, que es lo que CON-10 prohíbe.

---

## Estructura resultante

```
marco/
├── base/
│   ├── MC-BASE-normativo.md        # niveles, conformidad, GOB CFG DOC LEN CON
│   ├── glosario.yaml               # LEN-01, canónico para todos los verticales
│   └── registro-dominios.md        # códigos de tres letras tomados
├── verticales/
│   ├── software/MCS-normativo.md   # los 12 dominios de software
│   └── <siguiente>/
└── prompts/                        # P01–P04, parametrizados por vertical
```

Los prompts no se duplican por vertical. P01 audita «un producto contra los verticales que
le apliquen»; hoy asume software porque es el único que hay.

---

## Verticales candidatos

Por orden de valor para el negocio, no de facilidad:

| Vertical | Qué gobierna | Insumo ya disponible |
|---|---|---|
| **Consultoría** | Encargo, diagnóstico, opciones, transferencia | `MCS-P02` ya es este marco escrito como prompt. Falta extraerle los requisitos |
| **Datos y analítica** | Linaje, fichas de indicador, reconciliación | DAT §5.7.2 ya es esto; hoy vive dentro de software |
| **Comercial** | Propuesta, cotización, SOW, seguimiento | skill `proposal-writing` + `client-reporter` |
| **Contenido** | Documentación editorial, presentaciones | skills de inspiración + `presentation-inspiration-lookup` |

Consultoría es el primero: el material ya está escrito y es el que más se aleja de software,
así que es el que mejor prueba si la base aguanta.

---

## Requisito nuevo propuesto: economía de expresión

Va en la base, dominio LEN, porque aplica a todo lo que el sistema emite: documentos,
respuestas de agente e interacción conversacional.

| ID | Requisito | Nivel |
|---|---|---|
| LEN-09 | Todo texto emitido DEBE ser el mínimo suficiente para la decisión que habilita. NO DEBE repetirse una afirmación ya emitida en el mismo intercambio | N1 |
| LEN-10 | Los informes DEBEN indicar su extensión máxima por sección. Un resumen ejecutivo sin límite declarado se convierte en el informe | N2 |

**Por qué es un requisito y no una preferencia de estilo.** El texto redundante consume el
presupuesto de contexto que el trabajo necesita, y desplaza contenido útil fuera de la
ventana. Es el mismo tipo de fallo que MCS ya tipifica en otro dominio: consumo de un
recurso finito sin control. P01 y P03 ya lo aplican parcialmente —«máximo 200 palabras»,
«máximo una página», «frases de menos de 25 palabras»—, pero como regla local de cada
prompt, no como requisito del marco.

**Verificación (INT-01).** Es automatizable: repetición literal de bloques dentro de un
mismo documento, secciones que exceden su límite declarado. Sin control automático el
requisito queda en PARCIAL, que es lo que ya son casi todas las convenciones de este repo.

---

## Coste

Es un cambio **MAYOR** del marco: mueve requisitos entre documentos y añade LEN-09/10.
MC-BASE nace en 1.0.0; MCS pasa a 3.0.0 reducido a 12 dominios. Los identificadores no
cambian, así que cualquier auditoría previa sigue siendo legible.

Trabajo: partir el normativo, redactar el registro de dominios y el glosario, reescribir
§0.3 —que hoy cita cuatro guías inexistentes, errata E-06— y parametrizar los prompts.

---

## Recomendación

**Decidir ahora, ejecutar después de la reabsorción.**

La decisión hace falta ya porque la Etapa 3 de P04 define `conocimiento/`, y su forma
cambia según si va a alojar un dominio o varios verticales. Diseñarlo para software y
reacomodarlo después cuesta el doble.

La ejecución debe esperar porque partir el marco y reabsorber el repositorio a la vez son
dos cambios estructurales simultáneos, y P04 §Etapa 4 exige que cada tanda deje el
repositorio en estado utilizable.

Orden propuesto: cerrar la reabsorción con `conocimiento/` ya preparado para verticales →
partir el marco en base + software → escribir el vertical de consultoría a partir de P02.

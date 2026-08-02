---
id: MFB-CORE
titulo: Marco de Construcción de Marcos — Documento normativo
marco: MFB
capa: normativa
version: 1.1.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
depende_de: [INDICE, CONVENCIONES, glosario]
---

# MFB — Marco de Construcción de Marcos

**Documento normativo**

---

# 0. Control del documento

| Campo | Valor |
|---|---|
| Identificador | MFB-CORE |
| Versión | 1.1.0 |
| Estado | Vigente |
| Emisión | 2026-08-02 |
| Próxima revisión | 2026-11-02 |
| Responsable | Propietario del marco |

## Historial de versiones

| Versión | Fecha | Naturaleza del cambio |
|---|---|---|
| 1.0.0 | 2026-08-02 | Emisión inicial. 34 requisitos en 7 dominios, derivados de la construcción de MCS |
| 1.1.0 | 2026-08-02 | Registro de los nueve códigos de dominio de MCC en el anexo B. Corrección de la fila TRZ y de los totales del anexo A: el conteo real es 52 requisitos, no 34 ni 51 (errata F-01). Versión menor: actualiza registros y corrige aritmética, no altera requisitos |

## Convenciones de lenguaje normativo

DEBE (obligatorio) · NO DEBE (prohibido) · DEBERÍA (recomendado, omisible con ADR) · PUEDE (permitido).

---

# 1. Objeto y campo de aplicación

Este documento establece los requisitos que todo marco de la familia
claudio-enterprises DEBE cumplir en su estructura, nomenclatura, redacción,
versionado e interconexión.

**MFB gobierna la forma, nunca el fondo.** No determina qué debe exigir un marco
de contenido; determina cómo debe estar construido para ser utilizable,
auditable e interconectable con los demás.

Aplica a todo documento alojado bajo `docs/`, incluido este.

---

# 2. Términos y definiciones

**2.1 marco.** Cuerpo normativo y explicativo que codifica una disciplina
profesional en requisitos verificables, con su propio prefijo de familia.

**2.2 capa.** Función de un documento dentro de un marco: normativa, guía,
prompt, operativa o plantilla.

**2.3 dominio.** Agrupación temática de requisitos dentro de una normativa,
identificada por un código de tres letras único en toda la familia.

**2.4 requisito verificable.** Exigencia cuyo cumplimiento puede comprobarse
mediante inspección de un artefacto, ejecución de un control o consulta de un
registro, sin depender del juicio de quien la evalúa.

**2.5 eje común.** Artefacto compartido por toda la familia, del que ningún
marco es propietario exclusivo. Actualmente: el glosario canónico.

---

# 3. Modelo de niveles

MFB usa la misma escala N1–N5 que el resto de la familia.

| Nivel | Significado para un marco |
|---|---|
| **N1** | Utilizable: existe, se entiende y sus requisitos se pueden comprobar |
| **N2** | Interconectado: encaja con los demás marcos sin duplicar ni contradecir |
| **N3** | Operable: tiene prompts y skills que lo aplican sin leerlo entero |
| **N4** | Auditable: su conformidad se puede evidenciar ante un tercero |
| **N5** | Gobernado: tiene control de cambios formal y revisión externa |

Un marco recién creado DEBE alcanzar N1 antes de publicarse y DEBERÍA alcanzar
N2 antes de que se cree el siguiente marco.

---

# 4. Requisitos

## 4.1 EST — Estructura documental

| ID | Requisito | Nivel |
|---|---|---|
| EST-01 | Todo marco DEBE tener exactamente un documento normativo, identificado como `<PREFIJO>-CORE` | N1 |
| EST-02 | El documento normativo DEBE ser el único que impone requisitos. Las guías NO DEBEN introducir requisitos | N1 |
| EST-03 | Todo marco DEBE tener al menos una guía que explique el razonamiento tras sus requisitos | N1 |
| EST-04 | Todo documento DEBE declarar su capa: normativa, guía, prompt, operativa o plantilla | N1 |
| EST-05 | Los documentos de un marco DEBEN residir bajo un único directorio con el nombre del prefijo en minúsculas | N1 |
| EST-06 | Todo marco DEBERÍA tener al menos un prompt que lo aplique sin exigir su lectura completa | N2 |
| EST-07 | Todo marco DEBE declarar sus antipatrones explícitamente | N2 |
| EST-08 | Todo dominio de requisitos DEBE tener una puerta de calidad asociada, con controles comprobables | N2 |
| EST-09 | Todo marco DEBE disponer de las plantillas necesarias para producir sus artefactos | N3 |
| EST-10 | Todo marco DEBERÍA disponer de skills que apliquen sus procedimientos bajo demanda | N3 |

## 4.2 NOM — Nomenclatura e identificadores

| ID | Requisito | Nivel |
|---|---|---|
| NOM-01 | Todo marco DEBE tener un prefijo de familia de tres letras mayúsculas, único en toda la familia | N1 |
| NOM-02 | Los códigos de dominio DEBEN ser de tres letras y únicos **en toda la familia**, no solo dentro de su marco | N1 |
| NOM-03 | Los identificadores de requisito DEBEN seguir el patrón `<DOM>-<nn>` con numeración secuencial | N1 |
| NOM-04 | Los identificadores de requisito son inmutables. Un requisito retirado conserva su número, marcado como Retirado, y su número NO DEBE reutilizarse | N1 |
| NOM-05 | Los nombres de archivo DEBEN seguir el patrón `<PREFIJO>-<TIPO><nn>-<descriptor>.md` | N1 |
| NOM-06 | Los tipos de documento DEBEN ser: CORE, G (guía), P (prompt), OP (operativa), T (plantilla) | N1 |
| NOM-07 | Antes de asignar un código de dominio nuevo, DEBE verificarse su disponibilidad en el índice maestro | N2 |

## 4.3 NIV — Niveles y conformidad

| ID | Requisito | Nivel |
|---|---|---|
| NIV-01 | Todo marco DEBE usar la escala N1–N5 con la semántica compartida de la familia | N1 |
| NIV-02 | Todo requisito DEBE tener un nivel mínimo asignado | N1 |
| NIV-03 | Los niveles DEBEN ser acumulativos: conformidad a N implica conformidad a todos los inferiores | N1 |
| NIV-04 | Todo requisito DEBE ser verificable. Si no puede comprobarse, NO DEBE figurar en la normativa; pertenece a la guía | N1 |
| NIV-05 | Un requisito DEBE enunciar una sola exigencia. Dos obligaciones separables son dos requisitos | N1 |
| NIV-06 | Un requisito DEBE describir el resultado exigido, NO DEBE nombrar una herramienta concreta | N1 |
| NIV-07 | La normativa DEBE incluir un anexo con la distribución de requisitos por nivel y dominio | N2 |
| NIV-08 | La normativa DEBE definir los estados de evaluación y la regla de determinación de nivel alcanzado | N2 |
| NIV-09 | La normativa DEBE proporcionar una plantilla de declaración de conformidad | N2 |

## 4.4 TRZ — Trazabilidad e interconexión

| ID | Requisito | Nivel |
|---|---|---|
| TRZ-01 | Todo documento DEBE declarar en su encabezado los documentos de los que depende | N1 |
| TRZ-02 | Un hecho DEBE vivir en un solo documento. Los demás lo referencian; NO DEBEN copiarlo | N2 |
| TRZ-03 | Las referencias entre documentos DEBEN hacerse por identificador, NO DEBEN hacerse por descripción del contenido | N2 |
| TRZ-04 | Todo marco DEBE usar el glosario canónico de la familia. NO DEBE mantener glosario propio para conceptos ya definidos | N2 |
| TRZ-05 | Antes de incorporar contenido nuevo, DEBE comprobarse el solapamiento con los marcos existentes y reportarse el resultado | N2 |
| TRZ-06 | El índice maestro DEBE actualizarse al crear, modificar o retirar un marco o documento | N2 |
| TRZ-07 | El grafo de dependencias documentales DEBE poder generarse automáticamente desde los encabezados | N3 |
| TRZ-08 | Todo marco DEBE identificar los estándares internacionales que rigen su materia. Si no existe ninguno, DEBE declararlo expresamente | N2 |
| TRZ-09 | NO DEBEN inventarse normas, identificadores de estándar ni versiones. Lo no verificado DEBE marcarse como tal | N1 |

## 4.5 RED — Redacción

| ID | Requisito | Nivel |
|---|---|---|
| RED-01 | Los documentos DEBEN redactarse conforme a las convenciones de `CONVENCIONES.md` | N1 |
| RED-02 | Un concepto DEBE nombrarse siempre con el término del glosario | N1 |
| RED-03 | Los documentos NO DEBEN contener cifras que caduquen. Los datos vivos se obtienen en el momento de uso | N2 |
| RED-04 | Todo marco DEBE incluir ejemplos concretos antes que definiciones abstractas | N2 |
| RED-05 | Los documentos NO DEBEN abrir secciones con recapitulaciones del contenido anterior | N2 |

## 4.6 VER — Versionado

| ID | Requisito | Nivel |
|---|---|---|
| VER-01 | Todo documento DEBE aplicar SemVer y declarar su versión en el encabezado | N1 |
| VER-02 | Toda modificación de un documento normativo DEBE producir entrada en su historial de versiones, con fecha y naturaleza del cambio | N1 |
| VER-03 | Añadir, eliminar o endurecer un requisito, o cambiar su nivel, DEBE producir incremento de versión mayor | N1 |
| VER-04 | Todo documento DEBE declarar responsable, fecha de revisión y periodicidad de revisión | N1 |
| VER-05 | Los documentos normativos DEBEN reemplazarse mediante relación bidireccional, NO DEBEN editarse silenciosamente en su contenido de requisitos | N3 |
| VER-06 | Los documentos fuera de su ventana de revisión DEBEN señalarse y generar una acción de revisión | N3 |

## 4.7 ACT — Activación y operación

> Este dominio existe porque un marco correcto que estorba en la operación diaria
> será abandonado, y su abandono desacreditará también las partes que servían.

| ID | Requisito | Nivel |
|---|---|---|
| ACT-01 | Ningún marco DEBE requerir carga permanente en contexto para el trabajo diario | N1 |
| ACT-02 | Todo marco DEBE declarar sus disparadores de activación: en qué situaciones aplica y en cuáles no | N1 |
| ACT-03 | El documento normativo NO DEBE ser necesario para ejecutar el trabajo. Solo para verificarlo | N2 |
| ACT-04 | Las descripciones de skills DEBEN redactarse con las palabras de quien las necesita, no con la terminología interna del marco | N2 |
| ACT-05 | Todo marco DEBE ser aplicable de forma parcial. NO DEBE exigir adopción íntegra para aportar valor | N2 |
| ACT-06 | El coste de aplicar un requisito de N1 NO DEBE exceder un día de trabajo. Si lo excede, pertenece a N2 o está mal formulado | N2 |

---

# 5. Evaluación de conformidad

Estados: CONFORME · PARCIAL · NO CONFORME · NO APLICABLE.

El nivel alcanzado es el mayor N cuyos requisitos DEBE, y los de niveles
inferiores, están en estado CONFORME o NO APLICABLE.

Todo marco DEBE evaluarse contra MFB al publicarse y al menos anualmente
después.

---

# Anexo A — Distribución de requisitos

| Dominio | N1 | N2 | N3 | Total |
|---|---|---|---|---|
| EST | 5 | 3 | 2 | 10 |
| NOM | 6 | 1 | — | 7 |
| NIV | 6 | 3 | — | 9 |
| TRZ | 2 | 6 | 1 | 9 |
| RED | 2 | 3 | — | 5 |
| VER | 4 | — | 2 | 6 |
| ACT | 2 | 4 | — | 6 |
| **Total** | **27** | **20** | **5** | **52** |

Conteo verificado requisito por requisito en v1.1.0. La emisión inicial declaraba 34 en
el historial y 51 en este anexo; ambas cifras eran incorrectas.

Los niveles N4 y N5 de MFB no tienen requisitos propios en esta versión: se
alcanzan mediante los requisitos de gobierno del marco de contenido
correspondiente.

---

# Anexo B — Registro de códigos de dominio

Los códigos son únicos en toda la familia. Verificar aquí antes de asignar uno.

| Código | Marco | Materia |
|---|---|---|
| EST, NOM, NIV, TRZ, RED, VER, ACT | MFB | Construcción de marcos |
| GOB, CFG, REQ, ARQ, DIS, LEN, DAT, DEV, INT, SUM, INF, DES, OPS, SEG, IA, DOC, CON | MCS | Calidad de software |
| CTR, INV, ANA, PRO, ECO, ESF, PLA, ENT, CLI | MCC | Consultoría de tecnología |

**Disponibles y sugeridos para marcos futuros:** ADQ, CAL, COM, EDU, EQP, EVA, FIN, GES, JUR, MER, ODC, PER, RSG, SRV, TAL, VTA.

Retirados de la lista por el registro de MCC: ANA, CLI, CTR, ECO, ENT, INV, PLA, PRO. **ESF** es código nuevo, no figuraba entre los sugeridos; verificado como único.

---

**Fin del documento MFB-CORE v1.1.0**

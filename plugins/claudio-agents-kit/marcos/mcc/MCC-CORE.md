---
id: MCC-CORE
titulo: Marco de Consultoría de Tecnología — Documento normativo
marco: MCC
capa: normativa
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente
depende_de: [INDICE, CONVENCIONES, glosario, MFB-CORE, MCS-CORE]
cubre_codigo: []
---

# MCC — Marco de Consultoría de Tecnología

**Documento normativo**

---

# 0. Control del documento

| Campo | Valor |
|---|---|
| Identificador | MCC-CORE |
| Versión | 1.0.0 |
| Estado | Vigente |
| Emisión | 2026-08-02 |
| Próxima revisión | 2026-11-02 |
| Responsable | Propietario del marco |

## Historial de versiones

| Versión | Fecha | Naturaleza del cambio |
|---|---|---|
| 1.0.0 | 2026-08-02 | Emisión inicial. 9 dominios. Absorbe el contenido consultivo de MCS-P02, que queda reemplazado por MCC-P01 |

## Convenciones de lenguaje normativo

DEBE (obligatorio) · NO DEBE (prohibido) · DEBERÍA (recomendado, omisible con ADR) · PUEDE (permitido).

---

# 1. Objeto y campo de aplicación

Este documento establece los requisitos que DEBE cumplir un encargo de
consultoría de tecnología, desde el encuadre hasta la transferencia.

MCC gobierna **cómo se conduce el encargo**. No gobierna la calidad del producto
construido: eso es materia de MCS. Un encargo puede ser conforme a MCC y
producir software no conforme a MCS, y al revés.

## 1.1 Frontera con MCS

| Materia | Marco |
|---|---|
| Encuadre, diagnóstico, propuesta, costeo, estimación, plan, transferencia | MCC |
| Arquitectura, código, pruebas, seguridad, operación, IA, documentación viva | MCS |
| Decisión de arquitectura registrada (ADR) | MCS, dominio ARQ. MCC la referencia |
| Nivel de conformidad del producto | MCS. MCC obliga a proponerlo y declararlo |

## 1.2 Disparadores de activación

MCC aplica cuando existe un tercero que encarga, paga o recibe el trabajo.

**Aplica:** encargo de cliente externo · encargo interno con patrocinador
distinto de quien ejecuta · propuesta económica · plan por fases con compromiso
de plazo.

**No aplica:** exploración propia · prototipo sin destinatario · tarea de
mantenimiento dentro de un encargo ya encuadrado · trabajo personal.

Un encargo que no supera el umbral de MCC-CTR-01 no necesita este marco.

## 1.3 Aplicación parcial

Los dominios son aplicables por separado. Un encargo de diagnóstico aplica CTR,
INV, ANA, ENT y CLI, y declara PRO, ECO, ESF y PLA como NO APLICABLE.

---

# 2. Referencias normativas

Estándares externos que rigen la materia. Verificar la edición vigente antes de
citarlos ante un cliente.

| Referencia | Materia | Uso en MCC | Confianza |
|---|---|---|---|
| ISO 20700:2017 | Guidelines for management consultancy services | Base de CTR, ENT y CLI | Verificada |
| ISO 21502:2020 | Guidance on project management | Base de PLA | Verificada |
| ISO 21500:2021 | Context and concepts, project/programme/portfolio | Vocabulario de PLA | Verificada |
| ISO 10006:2017 | Quality management in projects | Puertas de calidad del encargo | Verificada |
| ISO/IEC 20926:2009 | IFPUG functional size measurement | Método admisible en ESF | Verificada |
| ISO/IEC 19761 | COSMIC functional size measurement | Método admisible en ESF | Verificada, edición por confirmar |
| ISO/IEC 14143 (serie) | Functional size measurement, conceptos | Marco de los dos anteriores | Verificada, partes por confirmar |

**Declaración de alcance.** ISO 20700 es una guía, no una norma certificable.
MCC no declara conformidad con ISO 20700 ni la invoca como autoridad
certificadora. La usa como referencia de estructura.

Los dominios ECO e INV **no tienen norma internacional que los rija**. Su
contenido es opinión estructurada, derivada de práctica. Se presenta como tal
(TRZ-08).

---

# 3. Términos y definiciones

Solo los propios de esta materia. El resto vive en el glosario canónico
(TRZ-04).

**3.1 encargo.** Unidad de trabajo consultivo con un solo cliente, una pregunta
central y un criterio de éxito declarado.

**3.2 tipo de encargo.** Clasificación que determina dónde termina el trabajo.
Ver MCC-CTR-01 y el anexo C.

**3.3 inmersión sectorial.** Estudio acotado en tiempo del rubro del cliente,
previo al descubrimiento, orientado a conducir la conversación sin perder
credibilidad.

**3.4 subsegmento.** Nivel de desagregación de un rubro en el que la operación
y los sistemas son homogéneos. «Restaurantes» no es un subsegmento; «comida
rápida con franquicia» sí.

**3.5 hallazgo.** Afirmación sobre la situación del cliente, sostenida por
evidencia identificable y registrada durante el descubrimiento o el
diagnóstico.

**3.6 tanda.** Agrupación de trabajo que produce un resultado observable por sí
misma, sin depender de la siguiente.

**3.7 kit de reunión.** Artefacto de salida de la inmersión sectorial:
tarjeta de una pantalla, preguntas de descubrimiento e hipótesis de necesidad.

Términos reutilizados del glosario: **cifra viva**, **frontera de competencia**,
**nivel de conformidad**, **requisito**, **skill**.

---

# 4. Modelo de niveles

| Nivel | Significado para un encargo |
|---|---|
| **N1** | **Conducible.** Tiene encuadre, diagnóstico y propuesta trazables entre sí |
| **N2** | **Defendible.** Costos, estimaciones y plan resisten el escrutinio del cliente |
| **N3** | **Replicable.** Varios encargos simultáneos con criterios homogéneos y calibración |
| **N4** | **Auditable.** El proceso se evidencia ante un tercero: cliente corporativo o licitación |
| **N5** | **Gobernado.** Revisión externa, acreditación profesional y calibración estadística |

Los niveles son acumulativos (MFB-NIV-03). Un encargo declara un nivel MCC y,
si produce software, un nivel MCS. Pueden ser distintos.

**Criterio de selección.** El nivel se elige por el tamaño del compromiso, la
consecuencia del error y la exigencia del cliente. Nunca por aspiración. Un
encargo de dos semanas con un cliente pequeño es N1, y forzarlo a N3 consume el
margen del encargo.

---

# 5. Requisitos

## 5.1 CTR — Encuadre y contratación

| ID | Requisito | Nivel |
|---|---|---|
| CTR-01 | Todo encargo DEBE clasificarse en uno de los tipos del anexo C antes de iniciar el descubrimiento | N1 |
| CTR-02 | Todo encargo DEBE declarar su pregunta central en una sola frase | N1 |
| CTR-03 | Todo encargo DEBE declarar por escrito qué queda fuera de alcance | N1 |
| CTR-04 | Todo encargo DEBE identificar quién decide y quién resulta afectado | N1 |
| CTR-05 | Todo encargo DEBE declarar su criterio de éxito, comprobable al cierre | N1 |
| CTR-06 | El encuadre DEBE registrarse y confirmarse con el cliente antes de iniciar el descubrimiento | N1 |
| CTR-07 | Todo cambio de alcance DEBE registrarse con su efecto en plazo y costo | N2 |
| CTR-08 | Ningún trabajo fuera del alcance declarado DEBE ejecutarse sin aceptación registrada de quien decide | N2 |
| CTR-09 | El encargo DEBE declarar el régimen de confidencialidad y la propiedad de los entregables | N2 |
| CTR-10 | Todo encargo de duración superior a ocho semanas DEBE revisar su encuadre al menos una vez y registrar el resultado | N3 |

## 5.2 INV — Inmersión sectorial e investigación

| ID | Requisito | Nivel |
|---|---|---|
| INV-01 | La inmersión DEBE declarar el subsegmento, NO DEBE trabajar al nivel del rubro | N1 |
| INV-02 | La inmersión DEBE declarar su presupuesto de tiempo antes de empezar | N1 |
| INV-03 | Toda afirmación del dossier sectorial DEBE marcarse como hecho, patrón, supuesto o no verificado | N1 |
| INV-04 | NO DEBEN afirmarse ante el cliente cifras, proveedores, normas ni versiones sin fuente identificable. Extiende TRZ-09 al material entregado | N1 |
| INV-05 | La inmersión DEBE producir un kit de reunión conforme a 3.7 | N1 |
| INV-06 | La inmersión NO DEBE proponer solución, arquitectura ni tecnología | N1 |
| INV-07 | Las fuentes DEBEN clasificarse por nivel de autoridad conforme al anexo D | N2 |
| INV-08 | Ningún hallazgo sectorial DEBE sostenerse únicamente en fuentes de nivel F5 o F6 | N2 |
| INV-09 | Toda cifra sectorial DEBE acompañarse de su fecha y contexto de medición | N2 |
| INV-10 | El dossier sectorial DEBE declarar su fecha de caducidad estimada | N2 |
| INV-11 | Tras la primera reunión, el dossier DEBE actualizarse indicando qué supuestos cayeron | N2 |
| INV-12 | El material sectorial reutilizable DEBE conservarse indexado por subsegmento | N3 |

## 5.3 ANA — Diagnóstico

| ID | Requisito | Nivel |
|---|---|---|
| ANA-01 | El diagnóstico DEBE distinguir síntomas de causas de forma explícita | N1 |
| ANA-02 | El problema central DEBE enunciarse en una sola frase | N1 |
| ANA-03 | El diagnóstico DEBE separar la necesidad operativa del cliente de la necesidad que motiva la contratación | N1 |
| ANA-04 | Cuando el problema real difiera de lo solicitado, DEBE declararse antes de presentar opciones | N1 |
| ANA-05 | Todo hallazgo desfavorable identificado DEBE figurar en el material entregado al cliente | N1 |
| ANA-06 | Todo hallazgo DEBE señalar la evidencia que lo sostiene | N2 |
| ANA-07 | El diagnóstico DEBE declarar la consecuencia de no actuar | N2 |
| ANA-08 | Cuando el encargo toque desarrollo de software, el diagnóstico DEBE proponer un nivel de conformidad MCS | N2 |
| ANA-09 | El cliente DEBE confirmar el problema central antes de que empiece la elaboración de opciones | N2 |

## 5.4 PRO — Propuesta de soluciones

| ID | Requisito | Nivel |
|---|---|---|
| PRO-01 | Toda propuesta DEBE presentar al menos dos opciones que difieran en enfoque, no solo en tamaño | N1 |
| PRO-02 | Toda opción DEBE declarar qué deja sin resolver | N1 |
| PRO-03 | Toda propuesta DEBE contener una recomendación explícita y el criterio que la sostiene | N1 |
| PRO-04 | Toda elección de tecnología DEBE justificarse señalando el hallazgo que la motiva | N1 |
| PRO-05 | NO DEBE recomendarse tecnología cuya única justificación sea su adopción en el mercado | N1 |
| PRO-06 | Toda opción DEBE declarar los supuestos que deben cumplirse para que funcione | N2 |
| PRO-07 | Toda opción DEBE declarar cómo se revierte si fracasa | N2 |
| PRO-08 | Toda propuesta DEBERÍA incluir la opción mínima o la de no actuar cuando sea defendible | N2 |
| PRO-09 | La arquitectura propuesta NO DEBE exigir un nivel de conformidad MCS superior al acordado | N2 |
| PRO-10 | Las decisiones de arquitectura de la opción recomendada DEBEN registrarse conforme a MCS-ARQ-02 | N2 |
| PRO-11 | La propuesta DEBE declarar las dependencias de proveedor que crea | N3 |

## 5.5 ECO — Economía del encargo

| ID | Requisito | Nivel |
|---|---|---|
| ECO-01 | Todo costo presentado DEBE declarar moneda, fecha y vigencia de la oferta | N1 |
| ECO-02 | El costeo DEBE distinguir el costo de construcción del costo de operación recurrente | N1 |
| ECO-03 | El costeo DEBE declarar qué queda excluido | N1 |
| ECO-04 | El costeo DEBE incluir las licencias y servicios de terceros identificados | N1 |
| ECO-05 | Toda cifra de costo de terceros es una cifra viva: DEBE obtenerse en el momento de la propuesta y citar su fecha de consulta | N2 |
| ECO-06 | Los costos dependientes de consumo DEBEN presentarse junto al supuesto de volumen que los produce | N2 |
| ECO-07 | El costeo DEBE incluir el costo de operación de al menos doce meses | N2 |
| ECO-08 | El precio DEBE separar honorarios de costos repercutidos | N2 |
| ECO-09 | El costeo DEBE incluir una reserva de incertidumbre declarada como porcentaje | N2 |
| ECO-10 | El costo de salida DEBERÍA estimarse cuando la opción crea dependencia de un proveedor | N3 |

## 5.6 ESF — Estimación de esfuerzos

| ID | Requisito | Nivel |
|---|---|---|
| ESF-01 | Toda estimación DEBE declarar el método empleado | N1 |
| ESF-02 | Toda estimación DEBE expresarse como rango. NO DEBE presentarse como cifra única | N1 |
| ESF-03 | Toda estimación DEBE declarar los supuestos cuya caída la invalida | N1 |
| ESF-04 | Toda estimación DEBE incluir el esfuerzo de comprender lo existente | N1 |
| ESF-05 | Toda estimación DEBE fecharse y vincularse a la versión del alcance sobre la que se calculó | N1 |
| ESF-06 | Toda estimación DEBE declarar su unidad de medida | N2 |
| ESF-07 | La conversión a tiempo de calendario DEBE declarar la disponibilidad real supuesta del equipo | N2 |
| ESF-08 | Toda estimación DEBE incluir el esfuerzo de las actividades exigidas por el nivel de conformidad MCS acordado | N2 |
| ESF-09 | Toda estimación DEBE identificar las partidas de mayor incertidumbre | N2 |
| ESF-10 | Toda reducción de una estimación DEBE acompañarse de la reducción de alcance que la produce, registrada | N2 |
| ESF-11 | El esfuerzo real DEBE registrarse al cierre junto a la estimación original, para calibrar futuras estimaciones | N3 |

## 5.7 PLA — Planificación y conducción

| ID | Requisito | Nivel |
|---|---|---|
| PLA-01 | El plan DEBE organizarse en tandas conforme a 3.6 | N1 |
| PLA-02 | Cada tanda DEBE declarar su objetivo en una frase | N1 |
| PLA-03 | Cada tanda DEBE declarar su resultado observable al terminar | N1 |
| PLA-04 | NO DEBEN planificarse tandas cuyo valor solo aparece al completar la siguiente | N1 |
| PLA-05 | El plan DEBE declarar las dependencias entre tandas | N1 |
| PLA-06 | El plan DEBE señalar las decisiones estructurales que encarecen si se retrasan | N2 |
| PLA-07 | El avance DEBE medirse por resultado observable. NO DEBE medirse por porcentaje declarado | N2 |
| PLA-08 | Cada tanda DEBE declarar los requisitos de MCS que cierra, cuando el encargo produzca software | N2 |
| PLA-09 | Todo riesgo identificado DEBE tener responsable y respuesta declarada | N2 |
| PLA-10 | Al cierre de cada tanda DEBE registrarse la desviación entre lo estimado y lo real | N2 |
| PLA-11 | Los bloqueos DEBEN registrarse con fecha de aparición y de resolución | N3 |

## 5.8 ENT — Entregables y transferencia

| ID | Requisito | Nivel |
|---|---|---|
| ENT-01 | Todo entregable DEBE declarar su destinatario y la decisión que permite tomar | N1 |
| ENT-02 | NO DEBEN producirse entregables que no cambian ninguna decisión | N1 |
| ENT-03 | El cierre DEBE declarar qué queda en manos del cliente y quién responde de cada cosa | N1 |
| ENT-04 | Todo entregable DEBE tener criterio de aceptación declarado antes de producirlo | N2 |
| ENT-05 | El cierre DEBE declarar los indicadores que el cliente debe vigilar, con su umbral | N2 |
| ENT-06 | El cierre DEBE declarar cuándo revisar lo entregado | N2 |
| ENT-07 | Cuando el encargo produzca software, el cierre DEBE declarar el nivel de conformidad MCS alcanzado | N2 |
| ENT-08 | Los entregables DEBEN versionarse conforme a CONVENCIONES §6 | N2 |
| ENT-09 | La transferencia DEBE incluir una comprobación de que el receptor opera sin el consultor | N3 |

## 5.9 CLI — Conducta profesional

| ID | Requisito | Nivel |
|---|---|---|
| CLI-01 | Los conflictos de interés DEBEN declararse antes de aceptar el encargo | N1 |
| CLI-02 | El consultor DEBE advertir por escrito, una vez, cuando el cliente pida algo que perjudique su propio interés | N1 |
| CLI-03 | Si el cliente insiste tras la advertencia, esta DEBE quedar registrada. El trabajo PUEDE proceder | N1 |
| CLI-04 | El consultor DEBE declarar su frontera de competencia y derivar cuando el asunto la excede | N1 |
| CLI-05 | La información del cliente NO DEBE usarse fuera del encargo sin autorización registrada | N1 |
| CLI-06 | NO DEBE recomendarse un nivel de conformidad superior al que la situación exige | N2 |
| CLI-07 | Las decisiones del cliente DEBEN registrarse con fecha y con quién decidió | N2 |
| CLI-08 | Toda comunicación que cambie alcance, plazo o costo DEBE quedar por escrito | N2 |
| CLI-09 | El material sectorial reutilizable NO DEBE contener información identificable de un cliente | N2 |

---

# 6. Evaluación de conformidad

Estados: CONFORME · PARCIAL · NO CONFORME · NO APLICABLE.

El nivel alcanzado es el mayor N cuyos requisitos DEBE, y los de todos los
niveles inferiores, están en estado CONFORME o NO APLICABLE.

Un dominio completo PUEDE declararse NO APLICABLE cuando el tipo de encargo lo
excluye conforme a §1.3. La exclusión DEBE justificarse en la declaración.

La evaluación se hace por encargo, al cierre. Un encargo abierto no se evalúa.

---

# Anexo A — Distribución de requisitos

| Dominio | N1 | N2 | N3 | Total |
|---|---|---|---|---|
| CTR | 6 | 3 | 1 | 10 |
| INV | 6 | 5 | 1 | 12 |
| ANA | 5 | 4 | — | 9 |
| PRO | 5 | 5 | 1 | 11 |
| ECO | 4 | 5 | 1 | 10 |
| ESF | 5 | 5 | 1 | 11 |
| PLA | 5 | 5 | 1 | 11 |
| ENT | 3 | 5 | 1 | 9 |
| CLI | 5 | 4 | — | 9 |
| **Total** | **44** | **41** | **7** | **92** |

Los niveles N4 y N5 no tienen requisitos propios en esta versión. N4 se alcanza
mediante la evidencia acumulada de los requisitos N3. N5 exige acreditación
profesional externa, ajena al alcance de este documento.

---

# Anexo B — Declaración de conformidad

```yaml
encargo: <identificador>
cliente: <nombre o código>
tipo_encargo: <ver anexo C>
periodo: <inicio> a <cierre>
evaluado: <fecha>
evaluador: <nombre>

conformidad:
  MCC: { objetivo: N2, alcanzado: N1 }
  MCS: { objetivo: N2, alcanzado: N1 }   # solo si produjo software

dominios:
  CTR: CONFORME
  INV: CONFORME
  ANA: CONFORME
  PRO: PARCIAL
  ECO: CONFORME
  ESF: PARCIAL
  PLA: CONFORME
  ENT: CONFORME
  CLI: CONFORME

no_conformidades:
  - requisito: ESF-11
    estado: NO CONFORME
    causa: <texto>
    accion: <texto>
    fecha_limite: <fecha>

no_aplicables:
  - dominio: PRO
    justificacion: <texto>
```

---

# Anexo C — Tipos de encargo

| Tipo | El encargo termina en | Dominios no aplicables por defecto |
|---|---|---|
| DIAGNÓSTICO | Un juicio fundamentado sobre la situación actual | PRO, ESF, PLA |
| ESTRATEGIA | Una decisión de dirección, con opciones y criterios | ESF, PLA |
| ARQUITECTURA | Un diseño técnico y sus decisiones justificadas | — |
| MARCO | Un sistema de trabajo replicable para el cliente | — |
| CONSTRUCCIÓN | Un producto o componente en funcionamiento | — |
| TRANSFORMACIÓN | Un cambio en la forma de trabajar de un equipo | — |
| CAPACITACIÓN | Capacidad instalada en las personas del cliente | ECO parcial |

La exclusión por defecto es una presunción, no una autorización. Se declara y se
justifica igual (§6).

---

# Anexo D — Jerarquía de fuentes

| Nivel | Tipo de fuente |
|---|---|
| F1 | Especificación, norma o documentación oficial del objeto |
| F2 | Documentos internos del cliente |
| F3 | Literatura revisada por pares u organismo reconocido |
| F4 | Documentación técnica de proveedores |
| F5 | Experiencia publicada: casos, post mortem, benchmarks |
| F6 | Opinión, divulgación, foros |

---

**Fin del documento MCC-CORE v1.0.0**

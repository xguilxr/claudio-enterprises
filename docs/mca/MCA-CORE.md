---
id: MCA-CORE
titulo: Marco de Capacidades Agénticas — Documento normativo
marco: MCA
capa: normativa
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente
depende_de: [INDICE, CONVENCIONES, glosario, MFB-CORE, MCS-CORE]
cubre_codigo: []
---

# MCA — Marco de Capacidades Agénticas

**Documento normativo**

---

# 0. Control del documento

| Campo | Valor |
|---|---|
| Identificador | MCA-CORE |
| Versión | 1.0.0 |
| Estado | Vigente |
| Emisión | 2026-08-02 |
| Próxima revisión | 2026-11-02 |
| Responsable | Propietario del marco |

## Historial de versiones

| Versión | Fecha | Naturaleza del cambio |
|---|---|---|
| 1.0.0 | 2026-08-02 | Emisión inicial. 48 requisitos en 7 dominios. Guía redactada antes que la normativa conforme a MFB-G01 §4 |

## Convenciones de lenguaje normativo

DEBE (obligatorio) · NO DEBE (prohibido) · DEBERÍA (recomendado, omisible con ADR) ·
PUEDE (permitido).

---

# 1. Objeto y campo de aplicación

## 1.1 Objeto

Este documento establece los requisitos aplicables al **entorno agéntico de un proyecto**:
la configuración que determina cómo un asistente de programación trabaja sobre ese
repositorio.

## 1.2 Campo de aplicación

Aplica a todo repositorio sobre el que se trabaje con asistencia agéntica, sea o no un
producto de software. Un repositorio de documentación, un vault de notas o un repositorio de
consultoría tienen entorno agéntico y les aplica este marco.

**NO aplica a la inteligencia artificial que el producto expone a sus usuarios.** Eso lo
gobierna MCS §5.15, dominio IA. Ver §1.4.

## 1.3 Disparadores de activación

| Situación | ¿Aplica MCA? |
|---|---|
| Montar o revisar la configuración agéntica de un repositorio | Sí |
| Decidir dónde colocar una convención, un procedimiento o un flujo | Sí |
| Conectar el asistente a un sistema externo | Sí, dominio HER |
| Delegar trabajo a un bucle sin supervisión turno a turno | Sí, dominio AUT |
| Escribir código de producto | No |
| Diseñar la funcionalidad de IA de un producto | No, aplica MCS §5.15 |
| Conducir un encargo de cliente | No, aplica MCC |

## 1.4 Frontera con MCS

| | MCA | MCS dominio IA |
|---|---|---|
| Objeto | La IA que construye el producto | La IA que el producto expone |
| Consumidor | Quien desarrolla | Los usuarios del producto |
| Fallo típico | Contexto desperdiciado, trabajo no verificado, bucle suelto | Datos expuestos, cifra inventada en una decisión |

MCA **referencia** la rúbrica de autonomía de MCS-G04 en AUT-02. No la reescribe (TRZ-02).

## 1.5 Exclusiones

Toda exclusión de un requisito aplicable al nivel declarado DEBE registrarse en un ADR con
justificación, riesgo aceptado y fecha de revisión.

---

# 2. Referencias normativas

**No existe estándar internacional para esta materia.** Se declara expresamente conforme a
MFB TRZ-08.

Las referencias disponibles son especificaciones de facto y documentación de producto, no
normas acreditadas. La correspondencia con ellas vive en `MCA-OP01` y se revisa cada 30 días.

| Referencia | Naturaleza | Alcance |
|---|---|---|
| MCS-CORE §5.15 y MCS-G04 | Marco propio | Frontera con la IA de producto; rúbrica de autonomía |
| MFB-CORE dominio ACT | Marco propio | Activación por disparador y coste de adopción |

Este marco es, por tanto, **opinión estructurada anclada en la práctica**, no derivación de
un cuerpo normativo externo. MFB-G01 §1 exige declararlo así.

---

# 3. Términos y definiciones

Solo los propios. El resto vive en el glosario canónico (TRZ-04).

**3.1 entorno agéntico.** Conjunto de artefactos versionados de un repositorio que
determinan cómo un asistente de programación opera sobre él.

**3.2 contexto permanente.** Porción del entorno que se carga en toda sesión sin que nadie
la solicite.

**3.3 capacidad agéntica.** Aptitud que el entorno habilita en el asistente. No es un
artefacto: se materializa en skills, instrucciones de alcance temático, flujos de trabajo y
roles. El glosario canónico veta `capacidad` como sinónimo de `skill`, y este marco respeta
esa distinción: la skill es el artefacto, la capacidad agéntica es lo que ese artefacto
habilita.

**3.4 patrón observado.** Repetición registrada durante el trabajo real que sugiere la
ausencia de un artefacto del entorno.

**3.5 destilación.** Procedimiento por el que un patrón observado se convierte en artefacto
del entorno, mediante rúbrica declarada y aprobación humana.

**3.6 radio de impacto.** Conjunto de sistemas que una herramienta puede modificar, y
reversibilidad de esa modificación.

---

# 4. Modelo de niveles

## 4.1 Escala

| Nivel | Denominación | Qué gana el asistente | Clase de fallo que introduce |
|---|---|---|---|
| **N1** | Orientado | Sabe dónde está y qué no tocar | Ninguna nueva |
| **N2** | Verificable | Comprueba su trabajo antes de darlo por terminado | Ninguna nueva |
| **N3** | Capacitado | Tiene los procedimientos del proyecto bajo demanda | Aplicar un procedimiento donde no corresponde |
| **N4** | Conectado | Actúa sobre sistemas ajenos al repositorio | Efectos fuera del alcance de un `git reset` |
| **N5** | Autónomo | Ejecuta bucles sin supervisión turno a turno | Todo lo anterior, repetido y sin observación |

## 4.2 Reglas de conformidad

**4.2.1** Un entorno es conforme al nivel N cuando cumple todos los requisitos DEBE de N y
de los niveles inferiores.

**4.2.2** Los niveles son acumulativos. No existe conformidad parcial.

**4.2.3** El nivel se declara por repositorio, no por persona ni por organización.

**4.2.4** Un requisito de un nivel que el repositorio no alcanzará nunca —típicamente N4 en
proyectos sin sistemas externos— se declara NO APLICABLE con justificación registrada.

## 4.3 Advertencia sobre la selección de nivel

N1 y N2 **no añaden riesgo**: solo dejan de desperdiciar tiempo y de dar por terminado lo
que no lo está. Todo repositorio en uso debería alcanzarlos.

A partir de N3 cada nivel añade una clase de fallo. **N5 sobre un repositorio sin N4 resuelto
es la combinación más cara**: un bucle sin supervisión con alcance externo no acotado.

Un entorno de nivel alto sobre un proyecto que se toca una vez al mes es esfuerzo que no se
recupera.

---

# 5. Requisitos

## 5.1 CTX — Contexto

| ID | Requisito | Nivel |
|---|---|---|
| CTX-01 | El repositorio DEBE declarar en un artefacto versionado su stack, sus comandos de verificación y las rutas que no deben modificarse | N1 |
| CTX-02 | El repositorio DEBE declarar el presupuesto máximo de su contexto permanente | N1 |
| CTX-03 | El contexto permanente NO DEBE contener cifras vivas ni inventarios que deriven del contenido real | N1 |
| CTX-04 | Las instrucciones de alcance temático DEBEN cargarse únicamente cuando la tarea toca los artefactos que gobiernan | N2 |
| CTX-05 | El presupuesto de contexto permanente DEBE verificarse de forma automática | N2 |
| CTX-06 | Un hecho DEBE residir en un solo artefacto del entorno. Los demás lo referencian; NO DEBEN copiarlo | N3 |
| CTX-07 | La memoria persistente DEBE revisarse con periodicidad declarada y podarse | N4 |

## 5.2 CAP — Capacidades del entorno

| ID | Requisito | Nivel |
|---|---|---|
| CAP-01 | Todo procedimiento repetible DEBE residir en un artefacto invocable bajo demanda. NO DEBE residir en el contexto permanente | N1 |
| CAP-02 | La descripción de una skill DEBE redactarse con las palabras de quien la necesita, y DEBE indicar cuándo no usarla | N3 |
| CAP-03 | Una skill DEBE cubrir un solo procedimiento | N3 |
| CAP-04 | El detalle extenso DEBE residir en artefactos de referencia cargados solo cuando el procedimiento los requiere | N3 |
| CAP-05 | Toda skill DEBE declarar qué acciones exigen confirmación humana | N3 |
| CAP-06 | Las skills específicas de un stack DEBEN residir en los repositorios que usan ese stack. NO DEBEN residir en el catálogo cargado siempre | N3 |
| CAP-07 | Toda skill DEBE declarar, por identificador, los requisitos que ayuda a cumplir | N3 |
| CAP-08 | Las skills sin uso registrado durante dos revisiones consecutivas DEBEN retirarse | N4 |

## 5.3 FLU — Flujos

| ID | Requisito | Nivel |
|---|---|---|
| FLU-01 | Los comandos de verificación DEBEN ejecutarse sin intervención y su resultado DEBE ser inequívoco | N2 |
| FLU-02 | DEBE existir una definición de terminado que el propio entorno pueda comprobar | N2 |
| FLU-03 | Lo que deba ocurrir siempre en un punto del ciclo DEBE automatizarse. NO DEBE confiarse a una instrucción | N2 |
| FLU-04 | Toda secuencia determinista de varios pasos DEBE expresarse como flujo de trabajo. NO DEBE expresarse como instrucción en prosa | N3 |
| FLU-05 | Todo flujo recurrente DEBE declarar su periodicidad y su condición de parada | N5 |
| FLU-06 | Ningún flujo DEBE ejecutarse sin dejar traza consultable | N5 |

## 5.4 AUT — Autonomía

| ID | Requisito | Nivel |
|---|---|---|
| AUT-01 | Toda acción irreversible DEBE requerir confirmación humana explícita | N1 |
| AUT-02 | La clasificación de un activo como rol DEBE regirse por la rúbrica de MCS-G04 y registrarse con la versión de rúbrica aplicada | N5 |
| AUT-03 | Todo rol DEBE declarar su catálogo de herramientas y el ámbito sobre el que puede actuar | N5 |
| AUT-04 | Todo rol DEBE declarar límite de iteraciones y límite de coste por ejecución | N5 |
| AUT-05 | Toda ejecución de un rol DEBE producir traza con entrada, herramientas invocadas, salida y coste | N5 |
| AUT-06 | Ningún rol DEBE publicarse sin conjunto de evaluación previo con umbral declarado | N5 |
| AUT-07 | La memoria de un rol DEBE ser inspeccionable y podable | N5 |

## 5.5 HER — Herramientas

| ID | Requisito | Nivel |
|---|---|---|
| HER-01 | Las credenciales de acceso a sistemas externos NO DEBEN residir en el repositorio | N1 |
| HER-02 | Todo proveedor de herramientas externo DEBE declararse en un artefacto versionado del repositorio | N4 |
| HER-03 | Toda herramienta con efecto externo DEBE tener ámbito declarado | N4 |
| HER-04 | El permiso de ejecución DEBE otorgarse por herramienta. NO DEBE otorgarse de forma global por omisión | N4 |
| HER-05 | Las herramientas que escriben en sistemas de terceros DEBEN operar bajo identidad nominal | N4 |
| HER-06 | Cada proveedor externo DEBE declarar su radio de impacto y la reversibilidad de sus efectos | N4 |
| HER-07 | El acceso a sistemas de producción DEBE ser temporal y quedar registrado | N5 |

## 5.6 EVA — Evaluación

| ID | Requisito | Nivel |
|---|---|---|
| EVA-01 | Toda skill DEBE disponer de al menos un caso que demuestre que se activa cuando corresponde | N3 |
| EVA-02 | Toda skill DEBE disponer de al menos un caso que demuestre que NO se activa cuando no corresponde | N3 |
| EVA-03 | Los casos de evaluación DEBEN ejecutarse automáticamente ante cambios del entorno | N4 |
| EVA-04 | Todo fallo de activación observado DEBE incorporarse como caso permanente | N4 |
| EVA-05 | El resultado de la evaluación DEBE condicionar la publicación de la skill | N5 |
| EVA-06 | DEBE conservarse la serie histórica de resultados de evaluación | N5 |

## 5.7 APR — Aprendizaje

> Este dominio existe porque un entorno que solo crece cuando alguien se sienta a
> ampliarlo, deja de crecer en la segunda semana.

| ID | Requisito | Nivel |
|---|---|---|
| APR-01 | DEBE existir un registro versionado de patrones observados, con fecha y número de ocurrencias | N3 |
| APR-02 | La promoción de un patrón observado a artefacto del entorno DEBE regirse por una rúbrica declarada y versionada | N3 |
| APR-03 | Ningún patrón observado DEBE promoverse sin aprobación humana registrada | N3 |
| APR-04 | La captura de patrones DEBE ser automática. NO DEBE depender de que alguien la recuerde | N4 |
| APR-05 | Toda corrección humana repetida sobre el mismo asunto DEBE registrarse como patrón | N4 |
| APR-06 | Cada patrón registrado DEBE clasificarse por ámbito: repositorio, stack o global | N4 |
| APR-07 | Todo artefacto promovido DEBE ser trazable al patrón que lo originó | N5 |

---

# 6. Evaluación de conformidad

## 6.1 Estados

CONFORME · PARCIAL · NO CONFORME · NO APLICABLE.

Un control que existe pero no se ejecuta automáticamente es PARCIAL. La disciplina humana no
es un control.

## 6.2 Determinación del nivel alcanzado

El nivel alcanzado es el mayor N cuyos requisitos DEBE, y los de todos los niveles
inferiores, se encuentran en estado CONFORME o NO APLICABLE.

Un requisito en PARCIAL impide alcanzar su nivel.

## 6.3 Periodicidad

| Nivel declarado | Periodicidad mínima |
|---|---|
| N1–N2 | Semestral |
| N3 | Trimestral |
| N4–N5 | Trimestral, con evidencia conservada |

---

# Anexo A — Distribución de requisitos

| Dominio | N1 | N2 | N3 | N4 | N5 | Total |
|---|---|---|---|---|---|---|
| CTX | 3 | 2 | 1 | 1 | — | 7 |
| CAP | 1 | — | 6 | 1 | — | 8 |
| FLU | — | 3 | 1 | — | 2 | 6 |
| AUT | 1 | — | — | — | 6 | 7 |
| HER | 1 | — | — | 5 | 1 | 7 |
| EVA | — | — | 2 | 2 | 2 | 6 |
| APR | — | — | 3 | 3 | 1 | 7 |
| **Total** | **6** | **5** | **13** | **12** | **12** | **48** |

**Lectura práctica:** alcanzar N2 exige 11 requisitos, y son los únicos que no añaden ninguna
clase de fallo nueva. Ahí está la mayor parte del rendimiento. Los 24 de N4 y N5 son en su
mayoría de acotación de alcance y de evidencia: necesarios para soltar la supervisión,
irrelevantes para trabajar mejor mañana.

---

# Anexo B — Declaración de conformidad

```yaml
# mca.yaml — en la raíz del repositorio
marco:
  id: MCA
  version: 1.0.0
entorno:
  repositorio: ""
  responsable: ""
conformidad:
  nivel_declarado: N2
  nivel_alcanzado: N1
  fecha_evaluacion: 2026-08-02
  proxima_evaluacion: 2027-02-02
presupuesto_contexto:
  permanente_max_chars: 6000
  permanente_actual_chars: 0
no_conformidades:
  - requisito: FLU-02
    estado: no_conforme
    plan: "Definición de terminado comprobable"
    responsable: ""
    fecha_objetivo: 2026-09-15
exclusiones:
  - requisito: HER-02
    justificacion: "El repositorio no alcanza sistemas externos"
    adr: adr-0001
    revisar: 2027-02-01
```

---

**Fin del documento MCA-CORE v1.0.0**

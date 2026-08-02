# MCS-P04 — Prompt de Reabsorción y Empaquetado

| Campo | Valor |
|---|---|
| Identificador | MCS-P04 |
| Versión | 1.0.0 |
| Marco de referencia | MCS-CORE v2.0.0 |
| Propósito | Convertir un repositorio existente de agentes y skills en el hogar del marco MCS y en un paquete instalable |
| Modo de uso | Ejecutar en Claude Code o Cowork sobre el repositorio · adjuntar los documentos del marco |
| Duración | 2–4 horas, con tres puntos de control |

---

## Instrucciones previas

Adjunta a la sesión: `MCS-CORE-normativo.md`, las cuatro guías, y los prompts P01, P02 y P03.

El prompt tiene **tres puntos de control obligatorios**. No permitas que los salte: la reabsorción sin diagnóstico previo destruye conocimiento que costó tiempo acumular.

---

## PROMPT

````
# ROL

Actúas como arquitecto de este repositorio. Tu encargo tiene dos partes:

1. Convertir este repositorio en el hogar del marco MCS
2. Convertirlo además en un paquete instalable de skills y agentes

Los documentos del marco están adjuntos. Léelos antes de tocar nada.

Este repositorio ya contiene trabajo previo: agentes definidos como roles y
skills en distintos grados de madurez. Ese trabajo contiene conocimiento real.
Tu tarea NO es reemplazarlo, es reabsorberlo.

Regla absoluta: no borras nada sin una fila en la tabla de disposición que
justifique por qué.

# PRINCIPIO RECTOR — Dos productos en un repositorio

Este repositorio alberga dos cosas con ciclos de vida distintos, y confundirlas
es el error de diseño que hay que evitar:

| Producto | Naturaleza | Consumidor | Versionado |
|---|---|---|---|
| EL MARCO | Normativo y explicativo | Personas, y agentes que lo leen como corpus | Propio, SemVer |
| EL PAQUETE | Ejecutable e instalable | Claude Code / Cowork | Propio, SemVer |

El paquete implementa el marco. El marco no depende del paquete. Deben poder
versionarse por separado.

# ETAPA 1 — INVENTARIO Y ARQUEOLOGÍA

Antes de juzgar, entiende qué hay.

Recorre el repositorio completo y produce:

## 1.1 Inventario de activos

| Ruta | Tipo declarado | Qué hace realmente | Tamaño | Última modificación |

Tipos: agente · skill · prompt · plantilla · documento · script · configuración ·
indeterminado.

Distingue el tipo DECLARADO del comportamiento REAL. Un archivo llamado
"agente" que solo contiene instrucciones declarativas no es un agente.

## 1.2 Arqueología del conocimiento

Para cada activo, extrae lo que contiene de valor, con independencia de su forma:

| Ruta | Conocimiento que contiene | Naturaleza |

Naturalezas posibles:
- TERMINOLOGÍA — nombres y definiciones de conceptos
- REGLA — afirmación normativa o de dominio
- PROCEDIMIENTO — secuencia de pasos para lograr algo
- CRITERIO — cómo elegir entre alternativas
- PLANTILLA — estructura que se rellena
- EJEMPLO — caso resuelto
- RETÓRICA — declaración de rol, tono o personalidad, sin contenido operativo

Sé honesto con la última categoría. "Eres un arquitecto senior con 20 años de
experiencia" es RETÓRICA: no aporta competencia, y el marco lo identifica como
antipatrón en la capa AC.9.

## 1.3 Estado del repositorio

Aplica el prompt MCS-P03 (reconocimiento rápido) a este repositorio como
proyecto de software: qué herramientas tiene, qué le falta, banderas rojas.

⏸ PUNTO DE CONTROL 1
Presenta el inventario y detente. No propongas destino todavía.
Pregunta: qué activos son intocables, cuáles ya sabes que están muertos, y qué
uso real les das hoy.

# ETAPA 2 — DIAGNÓSTICO DE REABSORCIÓN

Ahora clasifica cada activo. Una fila por activo, sin excepción.

| Ruta actual | Conocimiento | Destino | Ruta destino | Justificación |

Destinos posibles:

| Destino | Cuándo |
|---|---|
| SKILL | Procedimiento de varios pasos, invocable bajo demanda |
| CORPUS | Conocimiento declarativo de una materia |
| GLOSARIO | Terminología del dominio |
| RÚBRICA | Criterio explícito de elección entre alternativas |
| PLANTILLA | Artefacto que se rellena |
| PROMPT | Operación conversacional completa, de un solo uso |
| AGENTE | Solo si supera el umbral de la rúbrica del Track E |
| FUSIONAR | Se combina con otro activo; indica con cuál |
| RETIRAR | Redundante, superado, o nunca usado |

## Regla crítica sobre los agentes

La mayoría de lo que hoy está definido como "agente-rol" no es un agente. Un rol
es una declaración de identidad; un agente es un bucle con herramientas que
decide dinámicamente qué ejecutar.

Aplica a cada supuesto agente la rúbrica del Track E (seis dimensiones, 0 a 2
puntos). Registra la puntuación. Solo sobrevive como AGENTE lo que puntúe 9 o
más Y tenga catálogo de herramientas real.

Lo demás se descompone:
- Su procedimiento → SKILL
- Su conocimiento → CORPUS
- Sus criterios → RÚBRICA
- Su retórica → se descarta

Esta descomposición es la parte central del encargo. Espero que la mayoría de
los agentes actuales se conviertan en skills, y eso es una mejora, no una
pérdida: una skill se carga bajo demanda, se versiona, se evalúa y se compone
con otras. Un rol solo ocupa contexto.

⏸ PUNTO DE CONTROL 2
Presenta la tabla de disposición completa y detente.
Señala explícitamente los activos que propones RETIRAR y espera confirmación.

# ETAPA 3 — ARQUITECTURA DESTINO

Propón la estructura del repositorio. Punto de partida a adaptar, no a copiar:

```
claudio-enterprises/
├── marco/                       # PRODUCTO 1 — normativo
│   ├── MCS-CORE-normativo.md
│   ├── guias/
│   ├── prompts/                 # P01 P02 P03 P04
│   └── CHANGELOG.md
│
├── paquete/                     # PRODUCTO 2 — instalable
│   ├── skills/
│   │   └── <nombre-skill>/
│   │       ├── SKILL.md
│   │       ├── referencias/
│   │       └── scripts/
│   ├── agentes/                 # solo los que superaron la rúbrica
│   ├── comandos/
│   ├── plantillas/
│   └── CHANGELOG.md
│
├── conocimiento/                # capa AC — corpus por dominio
│   ├── glosario.yaml
│   ├── <dominio>/
│   │   ├── frontera-competencia.md
│   │   ├── ontologia.md
│   │   ├── normativa/           # con jurisdicción y vigencia
│   │   ├── marcos/
│   │   ├── rubricas/
│   │   └── casos/
│   └── README.md
│
├── evals/                       # conjuntos de evaluación por skill
├── docs/
│   ├── adr/
│   └── migracion/               # tabla de disposición y trazabilidad
├── mcs.yaml                     # conformidad del propio repositorio
└── README.md
```

Justifica cualquier desviación respecto a esta estructura.

# ETAPA 4 — PLAN DE MIGRACIÓN

Ordena el trabajo en tandas. Cada tanda debe dejar el repositorio en estado
utilizable; nunca a medias.

| Tanda | Objetivo | Activos afectados | Esfuerzo | Riesgo |

Empieza por lo que no rompe nada: crear la estructura nueva y mover, antes de
reescribir.

⏸ PUNTO DE CONTROL 3
Presenta el plan y espera aprobación antes de modificar archivos.

# ETAPA 5 — GENERACIÓN

Ejecuta el plan aprobado.

## 5.1 Skills derivadas del marco

Además de las que salgan de la reabsorción, genera las skills que el marco
implica. Propón el catálogo tú, reconciliándolo con lo que ya existe. Candidatas:

- Auditoría de conformidad (ejecuta P01)
- Reconocimiento rápido (ejecuta P03)
- Conducción de encargo consultivo (ejecuta P02)
- Redacción de ADR
- Creación y mantenimiento del glosario canónico
- Definición de indicador con ficha y prueba de reconciliación
- Aplicación de la rúbrica de autonomía del Track E
- Análisis de impacto documental
- Andamiaje de repositorio a nivel N1
- Modelado de amenazas STRIDE sobre una arquitectura
- Auditoría de deriva conceptual y de unidades

No generes una skill por cada sección del marco. Una skill existe cuando hay un
procedimiento repetible con pasos; lo demás es corpus.

## 5.2 Reglas de diseño de cada skill

- El campo de descripción determina cuándo se activa. Es el campo más
  importante: escribe cuándo usarla Y cuándo no, con las palabras que usaría
  quien la necesita
- Una skill, un procedimiento. Si necesita "y" en el nombre, son dos
- Divulgación progresiva: SKILL.md compacto, detalle en archivos de referencia
  que se cargan solo si hacen falta
- Sin declaraciones de rol ni personalidad
- Sin cifras ni datos que caduquen dentro del cuerpo
- Debe declarar qué acciones exigen confirmación humana
- Debe indicar qué requisitos MCS ayuda a cumplir, por identificador

## 5.3 Corpus de conocimiento

Para cada dominio identificado, crea las fichas conforme a la capa AC:
metadatos de fuente, nivel de autoridad, jurisdicción, vigencia, responsable y
periodicidad de revisión. Marca como PENDIENTE DE VALIDACIÓN todo lo que
requiera confirmación de una persona experta.

No inventes contenido normativo. Si el activo original afirmaba algo sin fuente,
consérvalo marcado como AUTORIDAD NO DETERMINADA, no lo promuevas.

# ETAPA 6 — EMPAQUETADO INSTALABLE

Antes de generar el empaquetado, **consulta la documentación oficial vigente**
en docs.claude.com sobre el formato de skills y plugins. No asumas el formato a
partir de tu conocimiento previo: puede haber cambiado.

Después:
- Genera los archivos de manifiesto conforme al formato verificado
- Documenta la instalación en el README con pasos reproducibles
- Verifica que cada skill se activa con las consultas esperadas y no con otras
- Declara qué requiere configuración adicional del usuario

# ETAPA 7 — CONFORMIDAD DEL PROPIO REPOSITORIO

Un repositorio que aloja el marco y no lo cumple carece de autoridad.

Aplica MCS-P01 a este repositorio con nivel objetivo N1 y genera `mcs.yaml`.
Presta atención especial a:

- CFG-12 — skills y prompts versionados, nunca editados fuera del repositorio
- DOC-01/04 — metadatos y dependencias en todos los documentos
- CON-01/02 — el propio marco es un corpus: declara su alcance y vigencia
- LEN-01 — glosario del propio marco, con los términos que él define

# REGLAS DE CONDUCCIÓN

- Español. Frases cortas. Voz activa. Sin preámbulos.
- Respeta los tres puntos de control. No los saltes aunque el plan parezca obvio.
- No borres ni sobrescribas sin fila en la tabla de disposición.
- Trabaja en una rama, nunca sobre la principal.
- Commits atómicos con Conventional Commits, uno por activo migrado, para que
  cualquier paso sea reversible.
- Si un activo existente contradice el marco, señálalo. El marco puede estar mal.
- Si algo del marco no aplica a este repositorio, dilo en vez de forzarlo.
- No inventes rutas ni contenidos. Lo que no verificaste, se marca como tal.

# INICIO

Empieza solo por la Etapa 1. No propongas destinos ni estructura todavía.
````

---

## Nota sobre el resultado esperado

La señal de que la reabsorción salió bien no es que el repositorio tenga más
archivos, sino que tenga **menos agentes y más skills**.

Un catálogo de doce agentes-rol tiende a convertirse en una o dos skills
compuestas más un corpus. Eso es una mejora: las skills se cargan bajo demanda,
se versionan, se evalúan por separado y se componen entre sí. Un rol declarado
solo consume contexto y aparenta competencia.

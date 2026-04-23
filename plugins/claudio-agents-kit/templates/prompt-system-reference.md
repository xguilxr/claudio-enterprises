# Claude Code — Sistema de Prompts Genérico

---

## 1. ARQUITECTURA DEL SISTEMA

El sistema se divide en **3 capas**:

```
CAPA 1 — SISTEMA (cacheable, estático por proyecto)
  └── CLAUDE.md + SPRINT.md + DECISIONS.md

CAPA 2 — TEMPLATE (semi-estático, por tipo de tarea)
  └── Prompt base según modo: BUG_FIX | FEATURE | REFACTOR | AUDIT | GREENFIELD

CAPA 3 — INPUT (dinámico, por sesión)
  └── El comment/request del owner o el task específico
```

**Principio de diseño:**
- Lo que no cambia entre sesiones → va en `CLAUDE.md` (Claude Code lo cachea automáticamente)
- Lo que cambia por tipo de tarea → template de capa 2
- Lo que cambia por sesión → input mínimo en capa 3

---

## 2. CLAUDE.md — ESTRUCTURA RECOMENDADA

Este archivo es el contrato del proyecto. Claude Code lo lee en cada sesión automáticamente. Mantenlo bajo 500 tokens.

```markdown
# [PROYECTO]

## STACK
[lenguaje, framework, DB, infra — 3-5 líneas máximo]

## ARCHIVOS CLAVE
- SPRINT.md — tracking de issues y estado
- DECISIONS.md — decisiones de arquitectura

## REGLAS OBLIGATORIAS
1. Leer SPRINT.md antes de cualquier acción
2. Formato de commit: tipo(scope): ID — desc corta (refs #N)
3. Nunca cerrar issues — los cierra el owner
4. Si el contexto se agota: commit wip(scope): ID — avance parcial, anotar en SPRINT.md

## TEMPLATES
### Issue
Título: [TIPO-###] desc corta
Labels: tipo + epic + status:triage

### Commit
fix(scope): BUG-### — desc (refs #N)
feat(scope): US-### — desc (refs #N)
refactor(scope): ENH-### — desc (refs #N)

### Comment de cierre
- Qué se hizo
- Archivos modificados
- Cómo probar
```

---

## 3. SPRINT.md — ESTRUCTURA RECOMENDADA

```markdown
# SPRINT ACTUAL

## CONTADORES
BUG: ### | ENH: ### | US: ###

## INBOX
<!-- Items sin clasificar llegan aquí -->

## QUEUE
<!-- Ordenado: bugs críticos → ENH agrupados por epic -->

## IN-PROGRESS
<!-- Máximo 1 item a la vez -->

## DONE
| ID | Título | SHA | Fecha |
```

---

## 4. TEMPLATES DE PROMPTS POR MODO

Cada template sigue esta estructura fija:
1. Rol + tarea de alto nivel (1-2 líneas)
2. Input del usuario (delimitado)
3. Instrucciones secuenciales atómicas
4. Condición de salida / manejo de contexto agotado

---

### MODO A — INTAKE (bugs, features, requests en lote)

Usar cuando: el owner pega un comment con múltiples items mezclados.

```xml
<system>
Eres el tech lead de este proyecto. Lee CLAUDE.md, SPRINT.md y DECISIONS.md antes de actuar.
Ejecuta el flujo completo sin pausas ni confirmaciones intermedias.
</system>

<input>
[PEGAR COMMENT DEL OWNER AQUÍ]
</input>

<instructions>
PASO 1 — CLASIFICAR
- Parsea cada item. Clasifica: BUG | ENH | US
- Asigna IDs usando contadores actuales de SPRINT.md
- Crea issue en GitHub con template de CLAUDE.md sección TEMPLATES
- Mueve a QUEUE en SPRINT.md (bugs críticos primero, luego ENH por epic)
- Commit: docs(sprint): intake — N issues a QUEUE (refs #...)

PASO 2 — IMPLEMENTAR (QUEUE de arriba a abajo)
Por cada item:
1. Mover QUEUE → IN-PROGRESS en SPRINT.md
2. Label → status:in-progress
3. Implementar fix/feature completo
4. Commit: formato CLAUDE.md
5. Comment en issue: qué se hizo, archivos, cómo probar
6. Label → status:fix-committed
7. Mover a DONE en SPRINT.md con fecha y SHA
8. NO cerrar el issue
9. Iniciar siguiente item inmediatamente

CONTEXTO AGOTADO → commit wip, anotar en SPRINT.md, terminar sesión
</instructions>
```

---

### MODO B — BUG FIX (uno o pocos bugs específicos)

Usar cuando: sabes exactamente qué arreglar.

```xml
<system>
Eres el tech lead de este proyecto. Lee CLAUDE.md y SPRINT.md antes de actuar.
</system>

<bug>
[DESCRIPCIÓN DEL BUG]
ID: BUG-###
Pasos para reproducir: [...]
Comportamiento esperado: [...]
</bug>

<instructions>
1. Localiza la causa raíz — no parchees síntomas
2. Implementa el fix
3. Verifica que no rompe tests existentes
4. Commit: fix(scope): BUG-### — desc (refs #N)
5. Comment en issue con qué cambió y cómo probar
6. Label → status:fix-committed
7. Actualiza SPRINT.md → DONE
</instructions>
```

---

### MODO C — FEATURE / US NUEVA

Usar cuando: hay que construir algo nuevo con requerimientos definidos.

```xml
<system>
Eres el tech lead de este proyecto. Lee CLAUDE.md, SPRINT.md y DECISIONS.md antes de actuar.
</system>

<feature>
ID: US-###
Título: [...]
Como [usuario], quiero [acción] para [beneficio].
Criterios de aceptación:
- [ ] ...
- [ ] ...
</feature>

<context>
[Archivos o módulos relevantes — solo los necesarios]
</context>

<instructions>
1. Revisa DECISIONS.md — no repitas decisiones ya tomadas
2. Diseña el approach en 3 líneas antes de codear (no pidas OK)
3. Implementa completo: modelo → lógica → UI/API → tests mínimos
4. Commit: feat(scope): US-### — desc (refs #N)
5. Actualiza SPRINT.md → DONE
</instructions>
```

---

### MODO D — REFACTOR

Usar cuando: hay deuda técnica o necesitas reestructurar sin cambiar comportamiento.

```xml
<system>
Eres el tech lead de este proyecto. Lee CLAUDE.md y DECISIONS.md antes de actuar.
</system>

<scope>
Módulos/archivos a refactorizar: [lista]
Objetivo: [qué problema resuelve este refactor]
Restricción: no cambiar interfaces públicas / no cambiar comportamiento observable
</scope>

<instructions>
1. Mapea dependencias antes de tocar código
2. Refactoriza en pasos atómicos — un commit por unidad lógica
3. Formato commit: refactor(scope): ENH-### — desc (refs #N)
4. Si encuentras bugs en el camino: crea issue, no lo arregles ahora
5. Al terminar: documenta el cambio en DECISIONS.md si aplica
</instructions>
```

---

### MODO E — AUDIT / ANÁLISIS

Usar cuando: necesitas entender el estado del código antes de actuar.

```xml
<system>
Eres el tech lead de este proyecto. Lee CLAUDE.md antes de actuar.
</system>

<scope>
Área a auditar: [módulo, feature, o "proyecto completo"]
Objetivo: [qué buscas — deuda técnica, bugs latentes, performance, seguridad]
</scope>

<instructions>
Produce un reporte con esta estructura:
1. ESTADO GENERAL (1 párrafo)
2. HALLAZGOS CRÍTICOS (bugs o riesgos que requieren acción inmediata)
3. DEUDA TÉCNICA (ordenada por impacto)
4. RECOMENDACIONES (acciones concretas, no genéricas)

NO implementes nada. Solo analiza y reporta.
Al final pregunta: ¿Creo los issues en GitHub?
</instructions>
```

---

### MODO F — GREENFIELD (proyecto nuevo desde cero)

Usar cuando: estás iniciando un proyecto nuevo.

```xml
<system>
Eres el tech lead a cargo de bootstrapear este proyecto desde cero.
</system>

<project>
Nombre: [...]
Objetivo: [1-2 líneas]
Stack definido: [lenguaje, framework, DB]
Restricciones: [presupuesto, tiempo, equipo]
</project>

<instructions>
PASO 1 — ESTRUCTURA
1. Crea estructura de carpetas
2. Inicializa repositorio y dependencias base
3. Crea CLAUDE.md con stack y reglas del proyecto
4. Crea SPRINT.md vacío con contadores en 0

PASO 2 — SCAFFOLD
1. Configura entorno (env, config, DB connection)
2. Implementa el "hello world" del stack elegido
3. Agrega linting y formato mínimo

PASO 3 — PRIMER FEATURE
[definir aquí o en sesión separada]
</instructions>
```

---

## 5. REGLAS TRANSVERSALES DE USO

**Reducción de tokens:**
- No repitas el stack en cada prompt — vive en `CLAUDE.md`
- No incluyas código existente completo — solo el archivo/función relevante
- Para contexto largo (>200 líneas): pasa solo el nombre del archivo, Claude Code lo lee solo

**Separación de tareas:**
- AUDIT siempre en sesión separada de IMPLEMENT
- INTAKE (clasificar) puede ir junto con IMPLEMENT si son <5 items
- REFACTOR nunca mezclar con FEATURE en la misma sesión

**Manejo de contexto:**
- Si una US tiene >3 criterios de aceptación complejos → partir en sub-tasks, una sesión por sub-task
- La condición de salida por contexto agotado debe estar en TODOS los prompts

**Prompt caching en Claude Code:**
- `CLAUDE.md` se cachea automáticamente entre sesiones
- Pon en `CLAUDE.md` todo lo que no cambia: stack, reglas, templates de commit
- El input dinámico (comment del owner, bug description) siempre al final del prompt

---

## 6. GUÍA DE SELECCIÓN RÁPIDA

```
¿El owner pegó un comment con múltiples items?  → MODO A (INTAKE)
¿Hay un bug específico a arreglar?              → MODO B (BUG FIX)
¿Hay una US con criterios de aceptación?        → MODO C (FEATURE)
¿Hay deuda técnica a limpiar?                   → MODO D (REFACTOR)
¿Necesitas entender antes de actuar?            → MODO E (AUDIT)
¿Estás iniciando un proyecto nuevo?             → MODO F (GREENFIELD)
```

---

## 7. AGENTE — PROMPT_OPTIMIZER

### Especificación

```yaml
name: prompt-optimizer
version: 1.0.0
description: >
  Analiza prompts de Claude Code, los descompone en tareas atómicas,
  selecciona el modo correcto del sistema de prompts, y genera
  el prompt optimizado listo para usar.

role: >
  Eres un experto en prompt engineering para Claude Code.
  Tu output siempre es un prompt listo para copiar/pegar, nunca explicaciones genéricas.

inputs:
  - raw_prompt: El prompt original o descripción de la tarea (texto libre)
  - project_context: Opcional — stack, restricciones, módulos relevantes

outputs:
  - mode: Cuál modo del sistema aplica (A-F)
  - prompts: Uno o más prompts optimizados listos para usar
  - rationale: Por qué se dividió así (máximo 3 líneas)
```

### Prompt del agente

```xml
<system>
Eres un experto en prompt engineering para Claude Code.
Tu única función: recibir un prompt o tarea en crudo y devolver prompts optimizados
listos para usar, siguiendo el sistema de 6 modos definido en tus instrucciones.
Nunca des explicaciones genéricas. Tu output es siempre el prompt listo para copiar.
</system>

<modes_reference>
A=INTAKE (lote de items mezclados)
B=BUG_FIX (bug específico)
C=FEATURE (US con criterios)
D=REFACTOR (deuda técnica)
E=AUDIT (análisis sin implementar)
F=GREENFIELD (proyecto nuevo)
</modes_reference>

<rules>
- Si la tarea mezcla AUDIT + IMPLEMENT → separa en 2 prompts
- Si hay >5 items en INTAKE → evalúa si partir en 2 sesiones
- Si una US tiene >3 criterios complejos → parte en sub-tasks
- Siempre incluye la condición de contexto agotado
- El input dinámico siempre al final del prompt generado
- Máximo 400 tokens por prompt generado
</rules>

<input>
TAREA EN CRUDO:
[PEGAR AQUÍ]

CONTEXTO DEL PROYECTO (opcional):
[STACK / RESTRICCIONES / MÓDULOS RELEVANTES]
</input>

<output_format>
MODO SELECCIONADO: [letra — nombre]
DIVISIÓN: [1 prompt | N prompts — razón en 1 línea]

PROMPT 1:
[prompt completo listo para usar]

PROMPT 2 (si aplica):
[prompt completo listo para usar]

RAZÓN: [máximo 3 líneas]
</output_format>
```

### Estructura de archivo para el repo de agentes

```
agents/
└── prompt-optimizer/
    ├── agent.md          ← especificación completa (este documento, sección 7)
    ├── prompt.xml        ← el prompt del agente listo para usar
    └── examples/
        ├── intake.md     ← ejemplo de input/output para MODO A
        ├── bugfix.md     ← ejemplo para MODO B
        └── feature.md    ← ejemplo para MODO C
```

---

*Sistema diseñado para Claude Code desktop. Actualizar CLAUDE.md del proyecto al adoptar este sistema.*

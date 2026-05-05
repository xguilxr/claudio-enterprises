---
name: karpathy-principles
description: Cuatro principios transversales (Think Before Coding / Simplicity First / Surgical Changes / Goal-Driven Execution) que aplica todo agente que escribe o modifica código. Surfacea supuestos antes de implementar, escribe lo mínimo que resuelve el pedido, no toca código adyacente sin permiso, y no cierra hasta verificar el criterio de éxito. Aplicar siempre que se vaya a editar/escribir código; excepción explícita para `limpiador` y `optimizador` cuando se los invoca para refactor.
---

# Karpathy Principles

Cuatro reglas que evitan los modos de falla típicos de un LLM cuando escribe código: asumir sin verificar, sobre-ingeniería, refactor lateral, y "terminar" sin demostrar que funciona. Adaptación al contexto del marketplace de los principios sintetizados por Andrej Karpathy y publicados como skill por Forrest Chang ([forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills), MIT).

## Las 4 reglas

### 1. Think Before Coding — pensar antes de tipear

Antes de modificar un archivo:
- Listá tus supuestos en una frase. Si alguno es incierto, **preguntá**, no adivines.
- Si el pedido es ambiguo (>1 interpretación válida), parás y clarificás.
- Si para implementar tenés que asumir el contrato de algo que no leíste (signature, schema, payload), leelo primero.

> "Tu primer commit es la conversación que evita el commit equivocado."

### 2. Simplicity First — código mínimo

- Escribí el mínimo código que resuelve **exactamente** lo pedido. Nada especulativo.
- No agregues abstracciones para casos que no existen todavía.
- No agregues `try/except` ni validaciones para escenarios que no pueden ocurrir (confiá en código interno y garantías del framework; validá solo en bordes del sistema).
- No agregues feature flags ni shims de compatibilidad si podés simplemente cambiar el código.
- 3 líneas similares es mejor que una abstracción prematura.

### 3. Surgical Changes — cambios quirúrgicos

- Modificá **solo** lo necesario para el pedido. No "mejorás" código adyacente que no rompía.
- No reformatees archivos enteros, no renombres lo que no estás tocando, no actualices imports que ya funcionaban.
- Si encontrás un bug pre-existente fuera de tu scope: lo anotás y lo reportás, no lo arreglás silenciosamente en el mismo commit.
- Solo borrás código que tu cambio dejó huérfano.

**Excepción explícita**: los agentes `limpiador` y `optimizador` SE INVOCAN para refactor/optimización. Cuando alguno de esos dos toma el turno, esta regla se relaja dentro del scope que Claudio les asignó (y solo dentro de ese scope). El resto de los agentes la respetan siempre.

### 4. Goal-Driven Execution — verificar antes de cerrar

- Convertí el pedido en un **criterio de éxito verificable** antes de empezar (ej: "el endpoint devuelve 200 con payload X" / "el test pasa" / "la página renderiza sin warnings en consola").
- No marcás un task como completo hasta que el criterio se cumple.
- Si tests fallan, el implementación es parcial, o hay errores sin resolver: el task sigue `in_progress`.
- "Funcionó en mi cabeza" no cuenta. Corré el test, abrí el browser, mirá el output.

## Cuándo aplicar

- En toda invocación que **escriba o modifique código**: agentes técnicos (`backend-expert`, `frontend-expert`, `data-expert`, `devops-expert`, `db-architect`, `qa-expert`, `security-auditor`) y meta-agentes que tocan archivos (`agent-manager`, `documentador` cuando edita docs en repo).
- En revisiones (`code-council`, `navigator`, `ui-reviewer`, `optimizador`): los principios guían qué se considera "bien hecho" al evaluar cambios ajenos.

## Cuándo NO aplicar (o aplicar con matiz)

- **`limpiador` y `optimizador` invocados explícitamente para refactor/optimización**: regla #3 se relaja dentro del scope acordado.
- **`design-researcher`, `discovery-agent`, `product-analyst`, `client-reporter`** cuando NO escriben código (moodboard, brief, propuesta): las reglas #1 y #4 igual aplican (pensá antes de redactar, verificá criterio); #2 y #3 son menos relevantes.
- Conflicto con un pedido explícito de Claudio: si Claudio pide expresamente "refactorizá esto mientras estás" o "agregá manejo de errores robusto", el pedido gana sobre la regla por default — pero el agente deja el cambio aislado en su propio commit.

## Ejemplos buenos

```
Pedido: "Agregá un endpoint GET /users/{id}"

Antes de codear:
- Asumo: usa el modelo User existente. ¿Confirmás?
- Asumo: response shape = el schema UserOut que ya existe. ¿Ok?
- Criterio de éxito: GET /users/1 devuelve 200 con UserOut válido; GET /users/9999 devuelve 404.

Implementación: solo el handler nuevo + 2 tests (200 + 404).
NO toco: el módulo de auth adyacente, los imports del archivo, el formato de logs.
Cierre: corrí los 2 tests, ambos verde. ✓
```

```
Pedido: "Cambiá el color del botón primario a #2563eb"

Cambio: 1 línea en tailwind.config.js (token primary).
NO toco: el resto del config, ni componentes que ya usan el token.
Verificación: abro el browser, el botón se ve azul. ✓
```

## Ejemplos malos

```
Pedido: "Agregá endpoint GET /users/{id}"

Implementación que viola las reglas:
- Asume schema sin preguntar (#1).
- Agrega un try/except genérico "por las dudas" (#2).
- De paso renombra una función en el archivo "que estaba mal nombrada" (#3).
- Cierra el task sin correr los tests porque "el código se ve bien" (#4).
```

```
Pedido: "Cambiá el color del botón primario a #2563eb"

Implementación que viola las reglas:
- Cambia el token + reformatea el archivo entero con prettier (#3).
- Aprovecha y "actualiza" otros tokens "que estaban viejos" (#3).
- No verifica en browser, asume que Tailwind picks it up (#4).
```

## Ver también

- `commit-message-format` — el espíritu de "un commit, un cambio" complementa #3.
- `discovery-agent` (agente) — institucionaliza #1 para proyectos enteros.
- `code-council` (agente) — usa estos principios como criterio de voto al evaluar cambios complejos.

## Atribución

Adaptación libre al contexto Claudio-Enterprises de los principios sintetizados por Andrej Karpathy sobre fallos típicos de LLMs al codear. Skill original publicada por Forrest Chang en [github.com/forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) bajo licencia MIT.

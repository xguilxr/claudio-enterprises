---
description: Bootstrappea agentes y skills LOCALES del proyecto (los que viven en .claude/agents/ y .claude/skills/ del CWD). NO genera CLAUDE.md — para eso, usá /scaffold del vault si es proyecto del portafolio de David, o creá CLAUDE.md a mano si es proyecto externo.
---

# /claudio-agents-kit:setup — Agentes y skills locales del proyecto

Este comando **no acopla el kit entero al proyecto** (el kit ya está instalado globalmente vía `claude plugin install`, y todos sus agentes/skills están disponibles desde cualquier CWD). Lo que hace es **bootstrappear agentes y skills LOCALES** específicos del proyecto, que viven en `.claude/agents/` y `.claude/skills/` del repo donde estás parado, y que sobrescriben o complementan al kit global cuando se invocan.

Casos típicos de uso:

- Tenés un proyecto con una convención muy puntual y querés un agente local que la conozca (ej: `vault-curator` solo aplica al vault de Obsidian de David; no tiene sentido en el kit global).
- Querés "forkear" un agente del kit (ej: `frontend-expert`) y customizarlo para este proyecto sin tocar el marketplace.
- Querés un skill local que solo aplica a este repo (ej: convención de naming de columnas de una DB específica del cliente).

**Lo que este comando NO hace:**

- ❌ NO genera `CLAUDE.md` del proyecto. Para eso, en el vault de David se usa `/scaffold` (que invoca `portfolio-mgmt/scaffolding/scaffold.py`). En proyectos externos, `CLAUDE.md` se escribe a mano partiendo del template de tipo correspondiente del kit (`templates/project-types/<tipo>.md`).
- ❌ NO crea repos en GitHub ni clones locales (eso es `/scaffold`).
- ❌ NO sobreescribe agentes/skills del marketplace global. Solo crea archivos LOCALES en `.claude/` del CWD.

## Tu rol

Sos el asistente de bootstrap de agentes/skills locales. Tu trabajo es ayudar a David (o quien sea que esté en este proyecto) a crear archivos en `.claude/agents/<nombre>.md` o `.claude/skills/<nombre>/SKILL.md` con la estructura correcta, sin que tenga que recordar el formato a mano.

**Regla innegociable:** nunca sobreescribís archivos locales existentes sin mostrar el cambio y recibir un "sí" explícito. Si ya existe `.claude/agents/foo.md`, mostrás el diff propuesto antes de aplicar `Edit`.

## Paso 1 — Relevar estado de `.claude/` en el CWD

Usá `Bash` / `Glob` / `Read` para chequear en paralelo:

- ¿Existe `.claude/` en la raíz?
- Si existe: listar `.claude/agents/*.md` y `.claude/skills/*/SKILL.md`.
- Si NO existe: avisar que se va a crear el árbol mínimo.

Anunciá el estado en 1-2 líneas. Ejemplo:

> 🔍 Encontré `.claude/agents/` con 2 agentes locales (`vault-curator.md`, `proposal-drafter.md`) y `.claude/skills/` vacío. ¿Qué querés crear?

## Paso 2 — Preguntar qué crear

Con `AskUserQuestion` (una sola tanda):

1. **¿Qué querés bootstrappear?**
   - `agente nuevo desde cero` (skeleton)
   - `agente forkeado del kit` (copia uno del marketplace y lo customiza local)
   - `skill nuevo desde cero` (skeleton)
   - `solo listar lo que ya tengo` (no crear nada)

2. Si la respuesta involucra crear:
   - **Nombre** del agente o skill (kebab-case, ej: `client-data-loader`).
   - Si es "agente forkeado": **¿cuál del kit?** — listar los 21 agentes disponibles del marketplace para que elija.

## Paso 3 — Ejecutar según opción

### Opción A — Agente nuevo desde cero

1. Crear `.claude/agents/<nombre>.md` con este skeleton:

   ```markdown
   ---
   name: <nombre>
   description: <una línea sobre cuándo invocarlo>
   model: sonnet
   memory: user
   ---

   Sos <nombre>, agente local del proyecto. Tu trabajo es <objetivo concreto>.

   ## Cuándo se te invoca
   <Casos típicos. Sé específico: "después de X", "cuando David pide Y".>

   ## Qué hacés
   1. <Paso 1 — relevar / leer>
   2. <Paso 2 — procesar / decidir>
   3. <Paso 3 — output>

   ## Qué NO hacés
   - <Límite explícito 1>
   - <Límite explícito 2>

   ## Output esperado
   <Formato concreto. Ejemplo con datos reales si ayuda.>

   ## Reglas
   - <Regla 1>
   - <Regla 2>
   ```

2. Avisar que el agente queda creado y se invoca con `@<nombre>` en sesiones de Claude Code corriendo en ese CWD.

### Opción B — Agente forkeado del kit

1. Leer el agente original desde `${CLAUDE_PLUGIN_ROOT}/agents/<elegido>.md`.

2. Copiarlo a `.claude/agents/<nombre-local>.md` (puede ser el mismo nombre — el local sobrescribe al global).

3. Insertar al inicio del cuerpo (después del frontmatter) un callout:

   ```markdown
   > 🔀 **Fork local de `<elegido>`** del marketplace `claudio-agents-kit`. Customizá lo que aplique para este proyecto; lo global queda como base.
   ```

4. Avisar a David que ahora puede editar el archivo local para divergir del comportamiento del global.

### Opción C — Skill nuevo desde cero

1. Crear `.claude/skills/<nombre>/SKILL.md` con este skeleton:

   ```markdown
   ---
   name: <nombre>
   description: <una línea sobre cuándo invocar el skill>
   ---

   # <Título del skill>

   ## Cuándo aplicarlo
   <Disparadores concretos. Ejemplo: "Cuando se escriba SQL contra la DB de cliente X".>

   ## La regla / patrón
   <Núcleo del skill. Sé concreto, no abstracto.>

   ## Ejemplos

   ### ✅ Bien
   ```<lenguaje>
   <código bueno>
   ```

   ### ❌ Mal
   ```<lenguaje>
   <código malo>
   ```

   ## Por qué importa
   <Una línea con la razón. Si hay un incidente o decisión histórica, citala.>
   ```

2. Avisar.

### Opción D — Solo listar

Devolvé una tabla:

| Tipo | Nombre | Archivo |
|---|---|---|
| agente | vault-curator | `.claude/agents/vault-curator.md` |
| skill  | db-naming     | `.claude/skills/db-naming/SKILL.md` |

Y un footer con "El kit global aporta además: 21 agentes y 17 skills genéricos del marketplace — invocables desde acá sin más setup."

## Paso 4 — Reporte final

Cerrá siempre con:

```
✅ Setup local listo

Acción: <agente nuevo | agente forkeado | skill nuevo | listado>
Archivo: <ruta relativa al CWD>

Próximos pasos:
1. Editá el archivo para llenar los placeholders concretos.
2. Reiniciá la sesión de Claude Code para que el nuevo archivo se cargue.
3. Invocalo con @<nombre> (agentes) o automáticamente cuando aplique (skills).
```

Y el bloque **📦 Cambios aplicados** según la regla global de reporte post-cambio.

## Reglas estrictas

1. **NUNCA generes un `CLAUDE.md`** del proyecto desde acá. Si el usuario lo pide, redirigilo: si está en el vault de David, sugerí `/scaffold`; si es proyecto externo, sugerí copiar manualmente desde `${CLAUDE_PLUGIN_ROOT}/templates/project-types/<tipo>.md`.
2. **NUNCA sobrescribís archivos locales existentes** sin mostrar el diff y recibir "sí" explícito.
3. **NUNCA toques `~/.claude/` ni el marketplace global** desde este comando. Trabajás solo en `.claude/` del CWD.
4. **Si no existe `.claude/`**, lo creás (más sus subdirs `agents/` y `skills/`) — esto NO requiere confirmación porque es operación de bootstrap.
5. Si David cancela a mitad, **no dejes archivos vacíos a medias**: o completás el skeleton mínimo, o no escribís nada.
6. Respondés siempre en **español**.

## Historia

- Pre-v4.5: este comando generaba el `CLAUDE.md` del proyecto en 3 ramas (nuevo / enriquecer / adoptar). Se redefinió en v4.5 porque la responsabilidad de "crear proyecto + CLAUDE.md" la tiene `/scaffold` del vault (atómico: repo + vault + clone + inventario), y no tenía sentido tener dos pipelines paralelos. El comando ahora se enfoca en bootstrap LOCAL de agentes/skills, que es lo que no estaba cubierto.

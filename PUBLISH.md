# PUBLISH.md — Cómo subirlo a GitHub y empezar a usarlo

Guía paso a paso, asumiendo cero conocimiento previo de marketplaces de Claude Code.

## Paso 1 — Crear el repo en GitHub

1. Ir a https://github.com/new
2. Nombre: `claudio-marketplace` (o el que quieras, pero recordalo)
3. **Dejar en PRIVADO si es solo tuyo** (recomendado). Si lo ponés público, cualquiera puede instalar.
4. **NO** inicializar con README ni LICENSE (ya los tenemos locales).
5. Crear.

GitHub te va a mostrar una URL tipo:
```
https://github.com/TU-USUARIO/claudio-marketplace.git
```

## Paso 2 — Conectar el repo local

Abrí terminal en la carpeta `claudio-marketplace/` que descomprimiste de este zip:

```bash
cd claudio-marketplace
git init
git add .
git commit -m "feat: initial marketplace with claudio-agents-kit v2.0.0"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/claudio-marketplace.git
git push -u origin main
```

Si el repo es privado, vas a necesitar autenticarte. GitHub recomienda usar GitHub CLI (`gh auth login`) o un Personal Access Token.

## Paso 3 — Agregar el marketplace a Claude Code

En tu máquina de trabajo:

```bash
claude plugin marketplace add github:TU-USUARIO/claudio-marketplace
```

Si es privado, Claude Code te va a pedir autenticación con GitHub. Seguí las instrucciones.

## Paso 4 — Instalar el plugin

```bash
claude plugin install claudio-agents-kit@claudio-enterprises
```

O desde dentro de Claude Code: `/plugin` y elegís `claudio-agents-kit`.

## Paso 5 — Verificar

```bash
claude plugin list
```

Debería mostrar:
```
claudio-agents-kit  2.0.0  claudio-enterprises  ✓ enabled
```

Dentro de Claude Code:
```
/agents
```

Tendría que listar los 15 agentes (con algún prefijo del plugin).

Probá el slash command:
```
/claudio-agents-kit:new-project
```

## Paso 6 — (Recomendado) Configurar CLAUDE.md global

Una sola vez:

```bash
# Encontrar dónde se instaló el plugin (varía según sistema)
find ~/.claude -name "CLAUDE-global.md" -path "*claudio-agents-kit*"

# Copiarlo como CLAUDE.md global
cp [ruta-encontrada] ~/.claude/CLAUDE.md
```

Esto le da contexto global a Claude sobre cómo trabajás (stack preferido, flujo por tipo de proyecto, etc.).

---

# Flujo de actualización (el motivo principal de usar plugin)

## Cuando agregues/cambies algo:

### 1. Editás los archivos del plugin
Por ejemplo, agregás un agente nuevo en `plugins/claudio-agents-kit/agents/my-new-expert.md`.

### 2. Bumpeás versión en DOS lugares
`plugins/claudio-agents-kit/.claude-plugin/plugin.json`:
```json
"version": "2.1.0"
```

Y en `.claude-plugin/marketplace.json` (la entrada del plugin):
```json
"version": "2.1.0"
```

Ambos deben coincidir.

### 3. Actualizás CHANGELOG.md
Entrada nueva explicando qué cambió.

### 4. Commit y push
```bash
git add .
git commit -m "feat(agents): add my-new-expert"
git push
```

### 5. En tus máquinas de trabajo, pull del cambio
```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

Listo. El agente nuevo ya está disponible.

---

# Errores comunes

## "claude plugin marketplace add" falla con autenticación
El repo es privado y Claude Code no tiene acceso. Soluciones:
- Autenticar con `gh auth login` primero
- O hacer el repo público si no hay data sensible en los prompts

## Actualizo el plugin pero no veo los cambios
Olvidaste bumpear versión en `plugin.json` o `marketplace.json`. Claude Code usa caching por versión — sin bump, no actualiza.

## "Script permission denied"
El bit ejecutable de `new-project.sh` se perdió al clonar. Fix:
```bash
cd plugins/claudio-agents-kit/scripts
chmod +x new-project.sh
git update-index --chmod=+x new-project.sh
git commit -m "fix: restore executable bit"
git push
```

## Los agentes no aparecen en /agents
Verificá estructura: los `.md` deben estar directo en `agents/`, no en subcarpetas (`agents/core/`, `agents/experts/`). En v2.0.0 ya están aplanados, pero si modificás y anidás, deja de funcionar.

## El slash command no encuentra los templates
El script debe usar `${CLAUDE_PLUGIN_ROOT}`, no rutas absolutas tipo `~/.claude/templates`. Verificá en `scripts/new-project.sh`.

---

# Primera prueba recomendada

Después de instalar, abrí Claude Code en una carpeta vacía y tirá:

```
/claudio-agents-kit:new-project
```

Creá un proyecto de tipo `data` o `automation` (son los más livianos para validar que todo funciona). Después:

```
cd mi-proyecto-test
claude
```

Y primer mensaje:
> "Leé el CLAUDE.md y llamá a discovery-agent para arrancar"

Si `discovery-agent` te empieza a hacer preguntas de a una, el plugin funciona.

---

# Siguientes pasos (cuando el kit evolucione)

- Cada vez que detectes un patrón que repetís → nueva skill
- Cada vez que necesites un experto para algo nuevo → nuevo agente
- Cada vez que el orquestador delegue mal → ajustar el `description` del agente
- Cada vez que un flujo se repita → posible slash command nuevo

El repo crece con vos. Cada `git push` con bump de versión + `claude plugin update` es suficiente.

# Claudio-Enterprises Marketplace

Marketplace privado de Claude Code para la agencia Claudio-Enterprises.

## Contenido

- **`claudio-agents-kit`** — 16 agentes + 14 skills + 5 templates de proyecto + `STYLE.md` + arquitectura de Notion documentada + meta-agente `agent-manager`

## Cómo usar este marketplace

### 1. Agregar el marketplace a Claude Code

Una sola vez, en cualquier máquina donde uses Claude Code:

```bash
claude plugin marketplace add github:TU-USUARIO/claudio-marketplace
```

*(reemplazá `TU-USUARIO` por tu usuario de GitHub)*

### 2. Instalar el plugin

```bash
claude plugin install claudio-agents-kit@claudio-enterprises
```

O desde dentro de Claude Code:

```
/plugin
```

Y seleccionás `claudio-agents-kit`.

### 3. Verificar

```bash
claude plugin list
```

Debería aparecer `claudio-agents-kit` con la versión actual.

Dentro de Claude Code, correr `/agents` debería listar los 15 agentes del plugin (con prefijo del plugin).

## Actualizar (flujo normal de iteración)

Cuando cambias cosas del plugin:

### En el repo (donde modificás):

```bash
# 1. Editás agentes/skills/templates
# 2. Bumpeás versión en plugins/claudio-agents-kit/.claude-plugin/plugin.json
#    Y también en .claude-plugin/marketplace.json
# 3. Agregás entrada al CHANGELOG.md
# 4. Commit y push
git add .
git commit -m "feat(agents): add new-expert agent"
git push
```

**Importante:** Si no bumpeás la versión en `plugin.json` o `marketplace.json`, los usuarios no ven los cambios por caching.

### En las máquinas donde lo usás:

```bash
# Actualizar cache del marketplace
claude plugin marketplace update

# Actualizar el plugin
claude plugin update claudio-agents-kit
```

## Estructura del repo

```
claudio-marketplace/
├── .claude-plugin/
│   └── marketplace.json          ← índice de plugins
├── plugins/
│   └── claudio-agents-kit/       ← el plugin en sí
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── agents/               ← 15 agentes (.md)
│       ├── skills/               ← 11 skills (carpetas con SKILL.md)
│       ├── commands/
│       │   └── new-project.md    ← slash command
│       ├── scripts/
│       │   └── new-project.sh
│       ├── templates/
│       │   ├── CLAUDE-global.md
│       │   └── project-types/    ← 5 templates
│       └── README.md
├── CHANGELOG.md
└── README.md
```

## Versionado

Seguimos [Semantic Versioning](https://semver.org/):

- **MAJOR** (ej 2.0.0 → 3.0.0): cambios que rompen flujos existentes
- **MINOR** (ej 2.0.0 → 2.1.0): agentes o skills nuevas sin romper nada
- **PATCH** (ej 2.0.0 → 2.0.1): correcciones de typos, pequeños ajustes en descripciones

## Cómo evolucionar el plugin (flujo recomendado: agent-manager)

A partir de v2.1.0 hay un meta-agente `agent-manager` que hace todo el bookkeeping (crear/modificar/remover agentes y skills, bump, CHANGELOG, commit con Conventional Commits).

Desde Claude Code, dentro del repo del marketplace:

```
> Usá agent-manager para crear un agente llamado sales-expert que analice pipelines de ventas
```

El agente te pregunta lo mínimo (descripción, modelo), propone el cambio, espera tu OK, y luego:
1. Escribe el archivo desde plantilla (`templates/agent-template.md` o `skill-template.md`).
2. Valida el frontmatter.
3. Bumpea `plugin.json` y `marketplace.json` (MAJOR/MINOR/PATCH según SemVer).
4. Agrega entrada a `CHANGELOG.md`.
5. Commit con formato Conventional Commits.
6. Push a la branch actual.

## Flujo manual (si no querés usar agent-manager)

### Agregar un agente nuevo

1. Crear `plugins/claudio-agents-kit/agents/mi-experto.md` desde `templates/agent-template.md`:
   ```yaml
   ---
   name: mi-experto
   description: [descripción específica para routing automático — mencionar CUÁNDO invocarlo]
   model: sonnet
   memory: user
   ---
   ```
2. Bump MINOR en `plugin.json` Y `marketplace.json` (ambos).
3. Entrada en `CHANGELOG.md`.
4. Commit + push.
5. En tus máquinas: `claude plugin marketplace update && claude plugin update claudio-agents-kit`.

### Agregar una skill nueva

1. Crear `plugins/claudio-agents-kit/skills/mi-skill/SKILL.md` desde `templates/skill-template.md`.
2. Bump MINOR + CHANGELOG.
3. Commit + push + update.

### Cambiar un prompt de agente existente

1. Editar el `.md` del agente.
2. Bump PATCH (refinamiento) o MINOR (cambio de comportamiento).
3. Commit + push + update.

### Agregar un nuevo tipo de proyecto

1. Crear `plugins/claudio-agents-kit/templates/project-types/mi-tipo.md`.
2. Editar `plugins/claudio-agents-kit/scripts/new-project.sh` — agregar case.
3. Editar `plugins/claudio-agents-kit/commands/new-project.md` — agregar a la lista.
4. Bump MINOR + CHANGELOG.
5. Commit + push + update.

## Montar estos agentes en un proyecto nuevo (step by step)

**Una sola vez, por máquina** (si nunca usaste este marketplace):

```bash
# 1. Registrar el marketplace
claude plugin marketplace add github:TU-USUARIO/claudio-enterprises

# 2. Instalar el plugin
claude plugin install claudio-agents-kit@claudio-enterprises

# 3. Linkear el CLAUDE global (recomendado: symlink para auto-update)
mkdir -p ~/.claude
ln -sf ~/.claude/plugins/claudio-enterprises/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
# Con symlink, cada vez que corras "claude plugin update claudio-agents-kit"
# el CLAUDE global se actualiza automáticamente. No hay paso manual.
#
# Alternativa (solo si pensás agregar reglas personales al CLAUDE.md):
#   cp ~/.claude/plugins/claudio-enterprises/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
```

**Por cada proyecto nuevo**:

```bash
# 4. Dentro de Claude Code, en cualquier carpeta donde arme el proyecto
/new-project
# Te pregunta: nombre, tipo (platform | proposal | portfolio | automation | data), destino.
# Crea carpeta con CLAUDE.md, .gitignore y estructura adecuada al tipo.

# 5. Entrá al proyecto
cd ~/projects/<nombre-proyecto>

# 6. Abrí Claude Code
claude

# 7. Primer mensaje al orquestador:
# "Leé el CLAUDE.md y llamá a discovery-agent para arrancar"
```

**Mantener actualizado** (cuando este marketplace reciba updates):

```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
# Si hiciste symlink, no hay más nada que copiar — el CLAUDE global ya se actualizó.
```

**Agregar / modificar / remover agentes**: desde Claude Code, dentro del repo `claudio-enterprises`, pedí:
```
> Usá agent-manager para <crear|modificar|remover> <agente|skill>
```

## Troubleshooting

**"No veo el plugin después de actualizar"**
→ El cache del marketplace puede tardar. Corré:
```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

**"Los cambios que hice no se reflejan"**
→ Olvidaste bumpear la versión. Claude Code usa caching basado en versión.

**"El slash command new-project no funciona"**
→ Verificá que `scripts/new-project.sh` tenga permisos ejecutables:
```bash
chmod +x plugins/claudio-agents-kit/scripts/new-project.sh
git add -A
git commit -m "fix: restore executable bit"
git push
```

## Desarrollo local (antes de subir cambios)

Para probar cambios sin pushear:

```bash
# En la máquina donde desarrollás
cd ~/claudio-marketplace

# Agregás como marketplace local (path absoluto)
claude plugin marketplace add $(pwd)

# Instalás desde local
claude plugin install claudio-agents-kit

# Cuando terminás de probar, removés y reinstalás desde GitHub
claude plugin uninstall claudio-agents-kit
claude plugin marketplace remove claudio-enterprises
claude plugin marketplace add github:TU-USUARIO/claudio-marketplace
claude plugin install claudio-agents-kit@claudio-enterprises
```

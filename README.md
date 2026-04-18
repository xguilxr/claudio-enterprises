# Claudio-Enterprises Marketplace

Marketplace privado de Claude Code para la agencia Claudio-Enterprises.

## Contenido

- **`claudio-agents-kit`** — equipo de 15 agentes + 11 skills + 5 templates de proyecto

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

## Cómo evolucionar el plugin (flujo real)

### Agregar un agente nuevo

1. Crear `plugins/claudio-agents-kit/agents/mi-experto.md` con frontmatter:
   ```yaml
   ---
   name: mi-experto
   description: [descripción específica para routing automático]
   model: sonnet
   ---
   ```
2. Bump de versión: `2.0.0` → `2.1.0`
3. Agregar entrada al CHANGELOG
4. Commit + push
5. `claude plugin update` en tus máquinas

### Agregar una skill nueva

1. Crear `plugins/claudio-agents-kit/skills/mi-skill/SKILL.md`
2. Bump MINOR
3. Commit + push + update

### Cambiar un prompt de agente existente

1. Editar el `.md` del agente
2. Bump PATCH (si es refinamiento) o MINOR (si cambia comportamiento)
3. Commit + push + update

### Agregar un nuevo tipo de proyecto

1. Crear `plugins/claudio-agents-kit/templates/project-types/mi-tipo.md`
2. Editar `plugins/claudio-agents-kit/scripts/new-project.sh` — agregar case
3. Editar `plugins/claudio-agents-kit/commands/new-project.md` — agregar a la lista
4. Bump MINOR
5. Commit + push + update

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

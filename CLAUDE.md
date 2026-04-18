# CLAUDE.md — Claudio-Enterprises Marketplace (repo-level)

Estás trabajando DENTRO del repo marketplace. Este archivo define cómo se edita el contenido del marketplace (agentes, skills, templates) sin romper a los consumidores del plugin.

> Si tu tarea NO es editar el marketplace, probablemente estás en el repo equivocado.

## Contexto del repo

Este es un **Claude Code plugin marketplace**. Contiene:

- `.claude-plugin/marketplace.json` — índice público de plugins
- `plugins/<plugin-name>/` — cada plugin (hoy: `claudio-agents-kit`)
- `CHANGELOG.md` — historial de cambios del marketplace

La estructura de un plugin es fija:

```
plugins/claudio-agents-kit/
├── .claude-plugin/plugin.json       ← metadata + versión
├── agents/<name>.md                 ← 1 archivo por agente
├── skills/<name>/SKILL.md           ← 1 carpeta por skill
├── commands/<name>.md               ← slash commands
├── scripts/*.sh                     ← referenciar con ${CLAUDE_PLUGIN_ROOT}
├── templates/                       ← plantillas (proyecto, agente, skill)
└── README.md
```

## Cómo se gestionan agentes y skills

**Regla de oro**: no edites a mano. Usá el meta-agente `agent-manager` (vive en `plugins/claudio-agents-kit/agents/agent-manager.md`).

`agent-manager` se encarga de:

1. **Crear** agente o skill desde plantilla (`templates/agent-template.md`, `templates/skill-template.md`).
2. **Validar frontmatter** (name, description, model, memory) antes de escribir.
3. **Modificar / renombrar** con sus referencias.
4. **Remover con limpieza** (archivo + menciones en CLAUDE-global.md y README).
5. **Bumpear versión** en `plugins/claudio-agents-kit/.claude-plugin/plugin.json` Y `.claude-plugin/marketplace.json` según SemVer.
6. **Actualizar CHANGELOG.md** con fecha y entrada Keep-a-Changelog.
7. **Commit + push** usando skill `commit-message-format` (Conventional Commits).

### Cuándo invocarlo

Cualquier pedido de "agregá", "modificá", "renombrá", "borrá" un agente o skill → delegar a `agent-manager`. No intentar editar directamente.

## Reglas de versionado (SemVer)

| Cambio | Bump |
|---|---|
| Typo, ajuste menor de descripción | PATCH (`2.1.0` → `2.1.1`) |
| Agente o skill nuevo, sin romper | MINOR (`2.1.0` → `2.2.0`) |
| Renombrar/remover agente existente, cambio de comportamiento que rompe flujos | MAJOR (`2.1.0` → `3.0.0`) |

**Ambos archivos deben estar sincronizados**: `plugin.json` y `marketplace.json`. Si no bumpeás, los consumidores no ven el cambio (caching).

## Formato esperado

### Agente (`agents/<name>.md`)
```yaml
---
name: <kebab-case>
description: <frase que permita routing automático. Mencionar cuándo invocarlo.>
model: sonnet | opus | haiku
memory: user
---

# Rol
# Responsabilidades
# Reglas
```

### Skill (`skills/<name>/SKILL.md`)
```yaml
---
name: <kebab-case>
description: <cuándo aplicarla. Verbo imperativo.>
---

# Contenido de la skill (convenciones, ejemplos, do/don't)
```

## Flujo de trabajo local antes de push

```bash
# 1. Branch dedicada (ya estás en una si seguís la convención)
git checkout -b claude/<tema>

# 2. Agent-manager hace los cambios + bump + CHANGELOG

# 3. Probar localmente
claude plugin marketplace add $(pwd)
claude plugin install claudio-agents-kit

# 4. Commit + push (agent-manager lo hace o lo hacés a mano)
git push -u origin <branch>
```

## Reporte post-cambio (obligatorio)

Cuando cualquier operación modifica archivos del marketplace, cerrás el turno con el reporte en **Markdown normal** — NO envuelto en un fence exterior. Si lo envolvés en triple-backticks, la prosa queda monoespaciada y los comandos anidados no son copiables (se invierte el efecto).

Estructura:

**📦 Cambios aplicados**

**Commits**
- `<hash>` &lt;mensaje&gt;

**Archivos modificados**
- `<ruta>` (+N −M)

**Cómo replicar en el ambiente**
1. Si falta merge: crear PR a `main` (dar URL o comando `gh pr create ...`).
2. En cada máquina consumidora: `claude plugin marketplace update && claude plugin update claudio-agents-kit`.
3. Si cambió `CLAUDE-global.md`: recopiar a `~/.claude/CLAUDE.md` (o `ln -sf` si usás symlink).

Reglas de formato:
- Prosa como Markdown plano (listas, headers, bold).
- Comandos copiables en backticks inline o fenced code block con lenguaje (` ```bash `).
- Nunca envolver TODO el reporte en un fence exterior.

Regla general completa: ver `templates/CLAUDE-global.md` → sección "Reporte post-cambio".

## No hacer

- ❌ Editar `plugin.json`/`marketplace.json` sin bumpear.
- ❌ Agregar un agente sin actualizar `CLAUDE-global.md` si pertenece al equipo core.
- ❌ Commits sin formato Conventional Commits (ver skill `commit-message-format`).
- ❌ Push a `main` directo. Siempre branch + PR.
- ❌ Remover un agente sin buscar referencias en templates y README primero.

## Herramientas que normalmente usás (Claudio)

Stack que asumimos en este marketplace y en los proyectos que lo instalan:

- **Python**: pytest, ruff, uv (preferido) o poetry.
- **Node/TypeScript**: pnpm, vitest, eslint, prettier, tsx para scripts.
- **SQL**: PostgreSQL 15+ como principal, SQLAlchemy async desde Python.
- **MCP comunes**: GitHub, Notion, Gmail, PostgreSQL cuando esté disponible.

Cualquier skill nueva debe respetar este stack por defecto; otros stacks van como skill opt-in.

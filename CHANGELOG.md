# Changelog

Todos los cambios notables del plugin `claudio-agents-kit` se registran acá.

El formato sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
y el versionado sigue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.2.1] — 2026-04-18

### Fixed
- **Formato del reporte post-cambio**: `templates/CLAUDE-global.md` y `CLAUDE.md` raíz ya no envuelven el bloque "📦 Cambios aplicados" en un fence exterior de triple-backticks. El wrapping anterior hacía que la prosa se renderizara en monoespaciado y los comandos anidados no fueran copiables (botón de copiar inhabilitado). Ahora el formato usa Markdown normal para la prosa, y backticks/fenced blocks solo para los comandos copiables. Regla explícita agregada: nunca envolver todo el reporte en un fence exterior.

---

## [2.2.0] — 2026-04-18

### Added
- **`templates/chrome-site-classification-prompt.md`** — prompt para pegar en Claude Chrome que lee el sitio activo, pregunta a Claudio cómo clasificar la extracción (`inspiration` / `competitor-research` / `skip`) y devuelve un bloque Markdown listo para pegar en Notion según el destino correcto. El formato de extracción cambia según el tipo (ref visual vs análisis competitivo + posicionamiento).
- Sección `🔍 Competidores` dentro de cada página de prospecto en la arquitectura de Notion (competitor research atado al prospecto, separado del branding propio del cliente).

### Changed
- `templates/notion-architecture.md`:
  - Sección 1.2 (Prospectos) incorpora la subsección `🔍 Competidores` con estructura por competidor (URL, similitudes/diferencias, branding observado, posicionamiento y pricing, aprendizajes para la propuesta).
  - Sección 2 (💡 Inspiración) aclara que es inspiración propia para crear, NO research de competidores de un cliente (esos van en Prospectos).
  - Nueva sección "Clasificación de extracciones desde websites" con tabla de ruteo `inspiration` vs `competitor-research` y link al prompt de Chrome.

---

## [2.1.0] — 2026-04-18

### Added
- **Meta-agente `agent-manager`** — gestiona el ciclo de vida de agentes y skills del marketplace (crear desde plantilla, listar/auditar, modificar, renombrar, remover con limpieza). Maneja bump SemVer de `plugin.json` y `marketplace.json`, actualiza `CHANGELOG.md` y crea commits con formato Conventional Commits.
- **Plantillas de scaffolding** en `templates/`:
  - `agent-template.md` — estructura base para crear un agente nuevo.
  - `skill-template.md` — estructura base para crear una skill nueva.
- **3 skills nuevas** para el flujo de propuestas y prospectos:
  - `consultora-branding-lookup` — trae logo, paleta, tipografías y plantilla de la consultora socia. Paso obligatorio antes de escribir cualquier propuesta.
  - `presentation-inspiration-lookup` — refs de FORMATO de propuestas/decks/one-pagers desde el vault de Notion.
  - `prospect-branding-lookup` — research de clientes potenciales en `🎨 Branding de Consultoras → Prospectos` con completitud variable vía tags (`solo-nombre`, `con-website`, `con-brief-inicial`, `con-propuesta-enviada`).
- **`templates/notion-architecture.md`** — documento de referencia para organizar el workspace de Notion de Claudio. Define 4 secciones raíz (🎨 Branding de Consultoras, 💡 Inspiración, 🧾 Inspiración — Presentaciones, 📊 Proyectos) con estructura interna, tags y guía de migración. Centraliza inspiración (antes dispersa dentro de cada proyecto) y separa branding de consultoras socias vs prospectos.
- **`templates/STYLE.md`** — plantilla de design system (tipografía, paleta, spacing, radius, motion, iconografía, componentes, voice/tone, accesibilidad). `new-project.sh` la copia a proyectos `platform` y `portfolio`. Establece jerarquía: brandbook cliente > consultora > STYLE.md proyecto > defaults plugin.
- **`CLAUDE.md` raíz del repo** — reglas para cuando Claude Code trabaja DENTRO del marketplace (convenciones del plugin, cómo bumpear, invocar agent-manager).
- Campo `version` en `plugin.json` (antes solo estaba en `marketplace.json`).

### Changed
- `templates/CLAUDE-global.md` refinado:
  - Stack desglosado en Python / Node-TS / SQL / Infra (antes mezclado).
  - Agregado `agent-manager` a la lista de agentes del equipo.
  - Nota sobre MCPs no conectados.
  - **Nueva regla global #10**: "Reporte post-cambio obligatorio" — todo turno que modifica archivos cierra con bloque `📦 Cambios aplicados` (commits + archivos + pasos concretos para replicar en el ambiente).
  - Deploy frontend: **Vercel por default** (antes Cloudflare Pages). Cloudflare/Netlify quedan como alternativas.
- `CLAUDE.md` raíz del marketplace: misma regla de reporte post-cambio.
- `templates/project-types/proposal.md`:
  - Campo nuevo "Consultora socia" al inicio (define branding a aplicar).
  - Flujo actualizado: paso 1 ahora es definir consultora + lookup de branding; paso 4 invoca `presentation-inspiration-lookup`.
  - Checklist pre-envío incluye verificación de branding.
  - Nombre de archivo final incluye consultora.
- `templates/project-types/portfolio-website.md`: deploy default a **Vercel** (antes Cloudflare Pages).
- `templates/project-types/platform.md`: deploy frontend a Vercel.
- `agents/devops-expert.md`: stack actualizado — Vercel primero, Cloudflare/Fly/Netlify como alternativas. Quitada referencia a la skill inexistente `cloudflare-deploy-patterns`.
- `agents/orquestador.md`: tabla de ruteo menciona Vercel/Cloudflare/Fly.
- `skills/proposal-writing/SKILL.md`: prerrequisitos nuevos al inicio (invocar `consultora-branding-lookup` + `presentation-inspiration-lookup` antes de escribir).
- README: step 3 del setup recomienda `ln -sf` (symlink) en lugar de `cp`, para que el CLAUDE global se actualice automáticamente con cada `plugin update`.

---

## [2.0.0] — 2026-04-18

### Added
- **3 agentes de planning**:
  - `discovery-agent` — interroga con una pregunta por turno, 7 capas de discovery
  - `product-analyst` — descompone en Epic → User Story → Test Case (nivel intermedio)
  - `design-researcher` — consulta vault Notion para inspiración visual
- **3 skills nuevas**:
  - `epic-user-story-format` — formato de artefactos de producto
  - `design-inspiration-lookup` — cómo consultar vault de Notion
  - `proposal-writing` — estructura de propuestas comerciales
- **5 templates de proyecto** (uno por tipo): `platform`, `proposal`, `portfolio-website`, `automation`, `data-analysis`
- **Slash command** `/claudio-agents-kit:new-project` para scaffolding guiado
- **Script** `new-project.sh` con `${CLAUDE_PLUGIN_ROOT}` para portabilidad

### Changed
- Los agentes core crecieron de 4 a 7
- `new-project.sh` ahora requiere argumento `<tipo>` además de `<nombre>`
- Estructura de carpetas de cada tipo de proyecto diferenciada (data tiene `data/raw`, automation tiene `.github/workflows/`, etc.)

### Migration from v1
Si estabas usando el kit v1 via `install.sh` manual:
1. Remover agentes viejos de `~/.claude/agents/` (backup antes)
2. Instalar el plugin desde el marketplace
3. Copiar `templates/CLAUDE-global.md` del plugin a `~/.claude/CLAUDE.md`

---

## [1.0.0] — 2026-04-18 (pre-plugin)

### Added
- 4 agentes core: `orquestador`, `documentador`, `limpiador`, `optimizador`
- 8 expertos: `data-expert`, `backend-expert`, `frontend-expert`, `devops-expert`, `qa-expert`, `db-architect`, `client-reporter`, `security-auditor`
- 8 skills: `pandas-conventions`, `postgres-query-patterns`, `fastapi-structure`, `pytest-style`, `react-query-patterns`, `git-flow`, `docstring-google-style`, `commit-message-format`
- Template CLAUDE-global.md y template genérico por proyecto
- Scripts `install.sh` y `new-project.sh`

### Notes
Distribuído como ZIP con `install.sh` manual. Reemplazado por plugin en v2.0.0.

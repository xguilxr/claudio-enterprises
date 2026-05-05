# Changelog

Todos los cambios notables del plugin `claudio-agents-kit` se registran acá.

El formato sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
y el versionado sigue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [4.4.0] — 2026-05-05

### Added
- **Skill nuevo `karpathy-principles`** — cuatro principios transversales que aplica todo agente que escribe o modifica código: (1) **Think Before Coding** (listar supuestos, preguntar antes de adivinar), (2) **Simplicity First** (mínimo código, sin abstracciones especulativas, sin try/except defensivo), (3) **Surgical Changes** (no tocar código adyacente, no reformatear, no "mejorar de paso"), (4) **Goal-Driven Execution** (criterio de éxito verificable antes de empezar; no cerrar hasta confirmar que se cumple). Excepción explícita: `limpiador` y `optimizador` se relajan en regla #3 dentro del scope de refactor que Claudio les asigna. Adaptación libre al contexto Claudio-Enterprises de los principios sintetizados por Andrej Karpathy sobre fallos típicos de LLMs al codear; skill original de Forrest Chang ([forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills), MIT) con atribución en el archivo.
- Regla global #11 nueva en `templates/CLAUDE-global.md` que hace al skill `karpathy-principles` aplicable por default a todos los agentes técnicos, con la excepción explícita para `limpiador`/`optimizador` documentada.

### Changed
- `plugin.json` description: "16 skills" → "17 skills" e incluye mención al skill nuevo.
- README del plugin: count de skills 16 → 17 con `karpathy-principles` en la lista.

### Notas
- Por default no se actualizó la sección "Skills que usás" de cada agente individual (serían 21 archivos para una regla que ya aplica vía CLAUDE-global). Si en uso intensivo se detecta que un agente específico ignora los principios, el fix es agregar la referencia explícita en su archivo en un PATCH posterior.
- `discovery-agent` ya cubría parcialmente la regla #1 a nivel de proyecto entero; `karpathy-principles` la baja al nivel de cada commit individual y suma las otras 3.

---

## [4.3.0] — 2026-05-05

### Added
- **Agente `navigator`** (modelo `sonnet`) — audita el flujo de navegación de una app/sitio: mapea sitemap real (rutas declaradas vs alcanzables vs huérfanas), recorre flujos críticos end-to-end, prueba "back" y "refresh" en cada paso, detecta dead-ends, loops, breadcrumbs rotos, back que pierde estado, profundidad excesiva (>3 clics) e inconsistencias de patrón. Output: lista priorizada (🔴/🟡/🟢) de recomendaciones accionables, no toca código. Se invoca cuando un proyecto con UI llega a estado funcional, antes del QA final.
- **Agente `ui-reviewer`** (modelo `opus`) — crítico visual de una página individual a partir de screenshot, URL navegable o código JSX. Evalúa en capas: layout macro, densidad informativa, jerarquía visual, consistencia y detalles. Detecta patrones como "panel gigante con dos KPIs adentro", botón secundario más prominente que el primario, niveles de gris arbitrarios, paddings fuera de escala. Output: diagnóstico con causa raíz + reorganización propuesta (con ASCII art del layout alternativo) + lista de cambios accionables para `frontend-expert`. Una página por invocación.
- Menciones de los 2 agentes nuevos en `templates/CLAUDE-global.md` (sección "Mi equipo de agentes" → biblioteca de expertos opt-in) y en el README del plugin.

### Changed
- `plugin.json` description: "19 agentes" → "21 agentes" e incluye `navigator` y `ui-reviewer` en el listado.

### Notas
- `navigator` y `ui-reviewer` son complementarios pero NO se solapan: navigator audita el grafo entre páginas (links, flujos, back/refresh), ui-reviewer audita una página por dentro (espacio, jerarquía, densidad). Si un proyecto necesita revisión completa de UX visual, invocar ambos en serie: primero `navigator` (mapa global), después `ui-reviewer` página por página sobre las críticas.
- Ninguno de los dos toca código. Los fixes los implementa `frontend-expert` consumiendo el reporte.

---

## [4.2.0] — 2026-04-24

### Added
- **Skill nuevo `vitest-patterns`** — convenciones para tests JS/TS con Vitest (preferido) o Jest, React Testing Library, MSW y Playwright. Reglas: MSW con `onUnhandledRequest: "error"` para detectar fetches no mockeados, mocks globales de SDKs externos (`openai`, `analytics`), nunca levantar `next dev` en tests (usar RTL + `renderHook` + imports directos de route handlers), Playwright siempre en job separado del gate de PR. Incluye config de `vitest.config.ts` que excluye `tests/e2e/`, scripts canónicos de `package.json` y checklist de validación.
- **Skill nuevo `github-actions-ci`** — convenciones para workflows de CI con caching agresivo y jobs paralelos. Define 4 jobs del gate de PR (`lint`, `typecheck`, `test-smoke`, `build`), caching obligatorio en `setup-python`/`setup-node` + caches por stack (`.next/cache`, `.mypy_cache`, `.turbo`), lock file + `--frozen-lockfile` / `npm ci` / `uv sync --frozen`, `concurrency: cancel-in-progress: true`, separación heavy/E2E en `nightly.yml` o `workflow_dispatch`. Objetivo explícito: `lint + typecheck + test-smoke` < 1 min con caché tibio.
- **Template `templates/pytest/conftest.py`** — conftest de referencia con engine session-scoped (schema UNA vez por worker de xdist), `db_session` function-scoped con SAVEPOINT + rollback (nunca `drop_all`), fixtures compartidas (`sample_tenant`, `admin_user`, `authed_client`), mocks `autouse=True` para PDF/LLM/S3/email que se saltean con `@pytest.mark.heavy`, config rápida (`BCRYPT_ROUNDS=4`, JWT hardcodeado, Celery eager) y `asyncio.sleep` neutralizado.
- **Template `templates/github/ci.yml`** — workflow de CI de referencia con los 4 jobs paralelos, caching pip/pnpm/mypy, comentarios opt-in para `uv` y para jobs de Node/frontend, y notas para crear `nightly.yml` separado para tests heavy + E2E.
- **Sección "Performance Requirements"** en `plugins/claudio-agents-kit/README.md` con números objetivo (suite <60s para <500 tests, gate PR <1 min), reglas aplicadas por default en cada skill (pytest / vitest / CI), checklist de validación obligatorio y regla transversal de detección de stack (no migrar pip→uv / jest→vitest / npm→pnpm sin permiso del humano).

### Changed
- **`skills/pytest-style/SKILL.md` extendido con 7 reglas de performance** (antes solo cubría naming + AAA + parametrize). Nuevas reglas: (1) schema UNA vez por worker + SAVEPOINT, (2) paralelismo por default con `pytest-xdist` (`-n auto --dist loadfile`), (3) mocks obligatorios para renderers/SDKs externos con tabla por área (PDF, LLM, Cloud, Email, HTTP, Celery), (4) fixtures de setup compartidas en vez de `_setup()` helpers, (5) config de seguridad rápida (`BCRYPT_ROUNDS=4`, JWT test), (6) markers registrados (`heavy`, `slow`, `integration`), (7) prohibición de `time.sleep` / `asyncio.sleep` reales. Incluye checklist de validación que bloquea el cierre si hay tests >2s sin marker o suite >60s para <500 tests.
- **`agents/qa-expert.md`** — stack actualizado (agrega `pytest-xdist`, marca Playwright como "nunca en gate de PR"), workflow extendido con paso de detección de stack y checklist de validación, skills que usa siempre ahora incluye `vitest-patterns` y `github-actions-ci`. Reglas estrictas nuevas: nunca `create_all`/`drop_all` por test, nunca sleep real, mocks por default, Playwright siempre en job aparte.
- **`agents/devops-expert.md`** — principio #4 de CI rápido ahora tiene target concreto (<1 min para gate de PR con caché tibio), entregables típicos incluyen `nightly.yml` separado para heavy+E2E, skills que usa siempre agrega `github-actions-ci`, reglas estrictas nuevas: lock file commiteado, caching obligatorio, tests heavy/E2E nunca en gate, `concurrency: cancel-in-progress` en todo workflow.
- **`agents/backend-expert.md`** — testing stack explicita `pytest-asyncio` + `pytest-xdist`, workflow de endpoint nuevo menciona fixtures compartidas con SAVEPOINT en vez de `_setup()` helpers, skills usadas remarca reglas de performance del `pytest-style`, reglas estrictas nuevas prohíben `create_all`/`drop_all` por test y establecen mocks por default para PDF/LLM/S3/email.
- **`plugins/claudio-agents-kit/README.md`** — cuenta de skills actualizada de "11 skills" a "16 skills" (incluye los 3 de branding/presentación que ya existían desde 2.1.0 + los 2 nuevos de 4.2.0).
- **`plugin.json` description** — menciona los skills nuevos y los templates de conftest + ci.yml.

### Notas
- Proyectos existentes no se migran automáticamente. Para adoptar las reglas: invocar al `qa-expert` sobre la suite, que detecta el stack y propone reemplazar fixtures en `conftest.py` + actualizar `.github/workflows/ci.yml` siguiendo los templates. El paso es incremental — el cambio mayor es reemplazar `create_all`/`drop_all` por engine session-scoped + SAVEPOINT, que típicamente recupera 70-80% del tiempo de suite.

---

## [4.1.1] — 2026-04-23

### Changed
- **Scaffold de `docs/project-management/` ampliado**: ahora `scripts/setup.sh` genera 3 archivos (antes eran 2):
  - `SPRINT.md` — solo sprint en curso (sección `DONE` removida).
  - `CHANGE_LOG.md` — **nuevo**: registro de actividades completadas. Cuando una tarea se completa en `SPRINT.md`, se mueve acá en lugar de quedar en la sección `DONE` del sprint.
  - `DECISIONS.md` — sin cambios respecto a 4.1.0.
- `SPRINT.md` pierde la sección `## DONE` (la función quedó en `CHANGE_LOG.md`). El comentario cabecera ahora explica el flujo sprint → changelog.
- `plugin.json` description actualizada para mencionar los 3 archivos del scaffold.

### Migration notes
- Proyectos scaffoldeados con 4.1.0 tienen `SPRINT.md` con sección `DONE` y sin `CHANGE_LOG.md`. Para migrar a mano: crear `docs/project-management/CHANGE_LOG.md` con el template de 4.1.1, mover filas de la sección `DONE` de `SPRINT.md` a la tabla del nuevo archivo, y borrar la sección `## DONE` del `SPRINT.md`.

---

## [4.1.0] — 2026-04-23

### Added
- **Agente `prompt-optimizer`** (modelo `sonnet`) — recibe prompts en crudo y devuelve prompts optimizados listos para copiar/pegar, siguiendo el sistema de 6 modos (INTAKE / BUG_FIX / FEATURE / REFACTOR / AUDIT / GREENFIELD). Detecta cuándo partir un prompt en sub-prompts (audit + implement separados, intakes con >5 items, US con >3 criterios complejos). Output siempre es prompt(s) listos para copiar, nunca explicaciones genéricas.
- **Agente `code-council`** (modelo `opus`) — convoca a un consejo de expertos técnicos (`backend-expert`, `frontend-expert`, `db-architect`, `devops-expert`, `security-auditor`, `qa-expert`, `optimizador`) para evaluar cambios complejos o decisiones arquitectónicas que cruzan múltiples dominios. Cada experto vota independientemente (✅/⚠️/❌/🔄) con pros, cons y riesgos; el consejo emite veredicto consolidado (🟢 APROBADO / 🟡 APROBADO CON CONDICIONES / 🔴 RECHAZADO / 🔵 REFINAR / ⚖️ ESCALAR). Veto de seguridad: si `security-auditor` vota ❌ por riesgo crítico, el veredicto es 🔴 aunque el resto apruebe.
- **`templates/prompt-system-reference.md`** — sistema completo de prompts en 3 capas (sistema/template/input) con templates por modo, reglas transversales, guía de selección rápida y spec original del agente `prompt-optimizer`. Reemplaza al `claude-code-prompt-system.md` que estaba en la raíz del repo.
- **Scaffold `docs/project-management/`** en `scripts/setup.sh` (Rama A — proyecto nuevo): genera `SPRINT.md` con la estructura de 5 secciones del sistema de prompts (CONTADORES / INBOX / QUEUE / IN-PROGRESS / DONE) y `DECISIONS.md` (ADR liviano para registrar decisiones arquitectónicas). Aplica a todos los tipos de proyecto excepto `proposal`.
- Menciones de los 2 agentes nuevos en `templates/CLAUDE-global.md` (sección "Mi equipo de agentes") y en el README del marketplace.

### Changed
- `plugin.json` description actualizada: "17 agentes" → "19 agentes" y referencia al nuevo scaffold de `docs/project-management/` y al sistema de prompts.

### Removed
- `claude-code-prompt-system.md` de la raíz del repo (movido a `plugins/claudio-agents-kit/templates/prompt-system-reference.md`).

### Notas para Claudio
- **Tensión `SPRINT.md` vs `PROJECT_QUEUE.md`**: el agente `project-manager` sigue manteniendo `PROJECT_QUEUE.md` en la raíz del proyecto (introducido en 3.1.0). El nuevo scaffold genera `docs/project-management/SPRINT.md` con un formato distinto, inspirado en el sistema de prompts. En cada proyecto, **elegí uno como fuente de verdad y borrá el otro** para evitar inconsistencias. Una unificación más profunda (que `project-manager` apunte directo a `docs/project-management/SPRINT.md`) queda para una versión futura, con su propio bump.
- **Slash command no aparece en Claude Code Desktop**: si tenés el plugin instalado y enabled (verificable con `claude plugin list`) pero no ves `/claudio-agents-kit:setup`, **reiniciá Claude Code Desktop completamente** (cerrar la ventana y abrir de nuevo). El Desktop no refresca slash commands de plugins instalados vía CLI hasta reiniciar.

---

## [4.0.0] — 2026-04-20

### Changed (BREAKING)
- **Slash command `/claudio-agents-kit:new-project` reemplazado por `/claudio-agents-kit:setup`**. El nuevo comando unifica 3 escenarios en un solo flujo:
  - **Rama A — Proyecto nuevo**: mismo comportamiento que el viejo `new-project` (pregunta nombre/tipo/destino, scaffoldea estructura, `git init`, commit inicial).
  - **Rama B — Enriquecer**: detecta `CLAUDE.md` existente, diagnostica secciones completas vs placeholders, contrasta stack declarado contra manifests reales (`pyproject.toml`, `package.json`, etc.), y propone `Edit` puntuales aprobados por Claudio. Nunca sobrescribe.
  - **Rama C — Adoptar**: repo con código pero sin `CLAUDE.md`. Infere tipo desde señales (manifests + estructura de carpetas), propone tipo, genera `CLAUDE.md` con stack detectado (no el stack default del template si difiere).
- **Script `scripts/new-project.sh` renombrado a `scripts/setup.sh`**. Lógica interna idéntica; el comando `/setup` lo invoca solo en Rama A.
- **Marketplace pasa a ser público** — `claude plugin marketplace add github:xguilxr/claudio-enterprises` ya no requiere auth de GitHub.

### Added
- `plugins/claudio-agents-kit/commands/setup.md` con prompt completo para las 3 ramas (detección CWD, flujo interactivo, mapeo tipo→agentes, reporte final).
- Tabla "tipo → agentes activos" en el prompt de `setup.md` como fuente canónica para generar/enriquecer la sección "Agentes activos en este proyecto" del CLAUDE.md del proyecto.

### Removed
- `plugins/claudio-agents-kit/commands/new-project.md`.
- `plugins/claudio-agents-kit/scripts/new-project.sh` (reemplazado por `setup.sh`).

### Migration notes
- Si tenías scripts, docs o notas con `/claudio-agents-kit:new-project` → cambiar a `/claudio-agents-kit:setup`.
- Si invocabas el script shell directo con `bash .../scripts/new-project.sh ...` → usar `bash .../scripts/setup.sh ...` (mismos argumentos posicionales).
- Usuarios nuevos: el install pasa a ser un one-liner: `claude plugin marketplace add github:xguilxr/claudio-enterprises && claude plugin install claudio-agents-kit@claudio-enterprises`.

---

## [3.1.0] — 2026-04-20

### Added
- **Agente `project-manager`** — convierte comentarios sueltos de Claudio en un plan operativo. Mantiene un `PROJECT_QUEUE.md` en la raíz del proyecto con 5 secciones fijas (`📥 Inbox`, `🏃 Sprint actual`, `📋 Backlog`, `✅ Hecho histórico`, `🚫 Descartadas`). Opera con TASK IDs correlativos (nunca reusa números), timestamps obligatorios en cada movimiento, y confirmación antes de cerrar sprints. Complementa a `product-analyst` (él maneja Epic/US/TC a nivel producto; éste gestiona ejecución día a día). Commits del queue con prefix `chore(queue):`.
- Mención de `project-manager` en `templates/CLAUDE-global.md` → sección "Agentes de planning".

---

## [3.0.0] — 2026-04-18

### Changed (BREAKING)
- **Migración de `💡 Inspiración` de árbol de carpetas a base de datos central de Notion**. Las skills ya no navegan subpáginas (`Websites/`, `Animaciones/`, `SaaS styling/`, `Snippets/`) — consultan una DB por propiedades. Database ID: `deae078a-ab7d-4d2a-97f9-00fdf23ddb86`; data source ID: `7342e2aa-a312-42d6-a8b5-39b2443ca210`.
- **`design-inspiration-lookup`** reescrita para operar via `databases.query` de la API de Notion. Input signatures nuevas: `asset_type`, `surface`, `style`, `library`, `project`, `include_generic`, `priority`, `status`, `technique_contains`. Soporta `legacy_path` como retrocompat (traduce paths viejos a filtros según tabla en `notion-architecture.md` §2.3). Fallback obligatorio cuando 0 matches (muestra filtros usados + causas + recomendación; nunca devuelve vacío silencioso).
- **`presentation-inspiration-lookup`** cambió de path: ahora vive en `🎨 Branding de Consultoras → Inspiración — Presentaciones` (antes era la raíz `🧾 Inspiración — Presentaciones`). Estructura interna de subpáginas sin cambios.
- **`prospect-branding-lookup`** ahora recorre subpáginas recursivamente sin asumir schema fijo (prefijos `Current Site —`, `Competitor —`, `Inspiration —` son hints, no requisitos). Al cerrar un prospecto ganado, agrega el cliente a `Project context` de la DB en vez de mover la página a un `📊 Proyectos` raíz (que ya no existe).
- **`consultora-branding-lookup`** path sin cambios; solo se documentó la existencia de `_Template Consultora` como plantilla vacía para duplicar.
- **`agents/design-researcher.md`** actualizado para reflejar DB + filtros y nueva jerarquía de fuentes (brandbook del cliente vive dentro del prospecto, no en un `📊 Proyectos` raíz).
- **`templates/chrome-site-classification-prompt.md`** ahora genera, para `inspiration`, un payload JSON con las propiedades exactas del schema de la DB (`Asset Type`, `Surface`, `Style Tags`, `Library / Stack`, `Project context`, `Is Generic`, `Priority`, `Difficulty`, `Status`, `Technique`) + body Markdown separado. Valores cerrados al schema; si falta un valor, pregunta antes de inventar.

### Removed
- **`📊 Proyectos` como raíz del workspace** — el trabajo por proyecto ahora vive dentro del prospecto en `🎨 Branding de Consultoras → Prospectos → <Cliente>`, junto con su sitio actual, competidores, inspiración del rubro y propuesta.
- Árbol de carpetas interno de `💡 Inspiración` (Websites/Landing/, Animaciones/Scroll-triggered/, SaaS styling/Dashboards/, Snippets/, etc.). Todo reemplazado por filtros de DB.

### Added
- **`templates/notion-architecture.md` §2.1 Schema** — schema completo de la DB `Inspiración` con tipos, valores cerrados de cada `select` y `multi_select`, IDs del DB y del data source.
- **`templates/notion-architecture.md` §2.3 Mapeo legacy** — tabla de equivalencias path-carpeta → filtros-DB para flujos antiguos.
- Subpáginas recomendadas por prospecto: `Current Site — <dominio>`, `Competitor — <Nombre>`, `Inspiration — <Nombre>`, `Redesign Proposal & Demo`, `🔍 Research adicional`. La plantilla `_Template Prospecto` es la base.
- Views en Notion: `All`, `By Asset Type`, `By Surface`, `By Project`, `Must-Haves only`, `Generic library` (creadas manualmente; las skills no las gestionan).

### Migration notes
- Si tenés flujos o skills externas que pasan paths viejos (`"Websites/Landing pages/"`), `design-inspiration-lookup` los acepta via `legacy_path` y los traduce a filtros — pero loguea la traducción para que actualices el caller.
- El `Inspiration Vault` dentro de `Shutterexx — Portfolio Build` es legacy. Sus 6 filas ya migraron a la DB central con `Project context=Shutterexx`, `Is Generic=false`. No leer del Vault.
- Prospectos referenciados hasta hoy como valores válidos de `Project context`: `Shutterexx`, `Integrity`, `DG`, `Claudio-Enterprises`. Cualquier prospecto nuevo debe agregarse explícitamente al schema antes de que las skills lo filtren.

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

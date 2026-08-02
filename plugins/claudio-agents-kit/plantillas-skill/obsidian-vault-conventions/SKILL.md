---
name: obsidian-vault-conventions
description: Estructura y convenciones del vault de Obsidian de David. Úsala antes de leer o escribir una nota, o de mapear un proyecto a su contexto.
---

# Obsidian Vault Conventions

Quick-reference de la estructura y convenciones del vault de David. El spec completo vive en el vault; esto es un puntero + resumen mínimo para que un agente no arranque en blanco.

## Identidad: David vs Claudio

Antes de leer cualquier README o nota del vault, tené claro:

- **David** = el ser humano dueño del vault y de la agencia Claudio-Enterprises (David Aguilar).
- **Claudio** = el **colectivo de agentes** del marketplace `claudio-agents-kit` (orquestador, backend-expert, etc.). Es la personalidad del equipo que ejecuta el trabajo.

Cuando una sección dice "Para David", se refiere a ítems que solo el humano puede destrabar. Cuando una skill dice "Claudio-Enterprises sigue X", se refiere al estándar interno de la agencia. Spec completo en `99-meta/conventions.md` sección "Quién es David vs quién es Claudio".

## Punto de partida

- **Vault**: `~/Documents/Obsidian Vault/` (Windows: `C:\Users\dagui\Documents\Obsidian Vault\`)
- **Source of truth**: `99-meta/conventions.md` — leer ANTES de escribir cualquier nota nueva o cambiar estructura.

## Modelo del vault (resumen rápido)

Dos macro procesos, loose-coupled. La conexión entre ellos es manual vía David — ningún script de un macro proceso invoca al del otro.

| Macro proceso | Raíz | Para qué |
|---|---|---|
| `knowledge-capture/` | capturar + procesar conocimiento | Notas de síntesis, ideas, inbox de lecturas |
| `portfolio-mgmt/` | crear + observar proyectos | Proyectos activos, scripts, archetypes, templates |
| `99-meta/` | transversal compartido | Convenciones, inventario de repos, templates de notas, audits |

### Subprocesos de `portfolio-mgmt/`

| Subdir | Para qué |
|---|---|
| `templates/` | librería de artefactos cliente-facing reusables (propuesta, contrato, presentación, entregables, roadmap) |
| `archetypes/` | composiciones de templates + boilerplate técnico (web-fullstack, api-backend, ai-agent, data-pipeline, lowcode-integration, proposal) |
| `scaffolding/` | la operación atómica `scaffold.py` que crea proyectos (repo + vault folder + clone) |
| `projects/` | proyectos activos (data del subproceso scaffolding) |
| `patterns/` | pattern library técnico (auth, errors, api, testing, ai, devops, data) |
| `repo-analytics/` | submódulo: observa evolución de repos para informar nuevos scaffolds |

## Dónde escribe Claude por defecto

| Qué | Dónde |
|---|---|
| README de proyecto | `portfolio-mgmt/projects/<slug>/README.md` |
| Decisiones / ADRs | `portfolio-mgmt/projects/<slug>/decisions.md` |
| Notas de síntesis | `knowledge-capture/notes/<area>/` |
| Ideas propias | `knowledge-capture/ideas/` |
| Captures crudos | `knowledge-capture/inbox/` (gitignored, efímero) |
| Audits del vault o del plugin | `99-meta/audits/<fecha>-<slug>.md` |

## Frontmatter de proyecto

Archivo: `portfolio-mgmt/projects/<slug>/README.md`

```yaml
project: <slug>
estado: activo | propuesta | atorado | pausado | archivado | superseded
tipo: platform | proposal | portfolio | automation | data | infra-interna | cliente
archetype: web-fullstack | api-backend | ai-agent | data-pipeline | lowcode-integration | proposal
milestone_proximo: <descripción>
fecha_objetivo: YYYY-MM-DD
ultima_actualizacion: YYYY-MM-DD
repo: <url-github>
repo_estado: activo | pendiente | sin-codigo
repos_aux:
  - <url-github-aux>
```

Ejemplo bien formado:

```yaml
project: warroom
estado: activo
tipo: infra-interna
archetype: ai-agent
milestone_proximo: "Fase 0 corre: app abre, persiste settings, dashboard vacío"
fecha_objetivo: 2026-07-15
ultima_actualizacion: 2026-05-21
repo: https://github.com/xguilxr/warroom
repo_estado: activo
repos_aux: []
```

## Convención obligatoria: sección `## Para David` en READMEs

Toda `portfolio-mgmt/projects/<slug>/README.md` incluye una sección `## Para David` que lista los ítems que **solo el humano puede destrabar** (decisiones, llamadas, firmas, definiciones estratégicas).

Es **distinta de**:
- `## Blockers` — impedimentos externos (cliente no responde, espera de datos).
- `## Roadmap corto` / `## Milestone próximo` — trabajo trackeable del entregable comprometido.

Formato canónico:

```markdown
## Para David
- [ ] {acción concreta en imperativo} · vence: {YYYY-MM-DD | sin fecha} · prioridad: {alta | media | baja}
- [ ] Confirmar datos fiscales con MID antes de firmar · vence: 2026-05-25 · prioridad: alta
- [x] Revisar mockups (cerrado)
```

Es el insumo primario de los slash commands `/atender` (ranking) y `/daily-standup` (actualización interactiva) del vault.

## Frontmatter de nota

Aplica a archivos en `knowledge-capture/notes/`, `ideas/`, `inbox/`:

```yaml
title: <título legible>
source: <url o nombre del libro/podcast>
author: <nombre>
date_captured: YYYY-MM-DD
date_published: YYYY-MM-DD
area: ia | tecnologia | finanzas | comercio | deportes | musica | diseño | lectura | general
tags:
  - <tag-kebab>
status: inbox | procesada | aplicada | archivada
ai_summary: <1-2 frases>
key_concepts:
  - <concepto>
connections:
  - "[[../otra-nota]]"
why_it_matters: <por qué importa para el trabajo de David>
```

## Naming

- Carpetas y archivos: kebab-case minúsculas (`analisis-de-mercado.md`, `data-pipeline/`).
- Excepciones en MAYÚSCULAS: `CLAUDE.md`, `README.md`.
- Slugs de proyecto: regex `^[a-z0-9-]+$`. Sin acentos en paths (la carpeta es `diseno`, el frontmatter es `area: diseño`).
- Los wikilinks en frontmatter usan la ruta relativa completa: `[[../portfolio-mgmt/projects/warroom/README]]`.

## Slash commands del vault (no del plugin)

El vault tiene su propio set de slash commands en `.claude/commands/` que NO viven en este plugin:

| Command | Para qué |
|---|---|
| `/scaffold` | Crear proyecto nuevo (repo + vault + clone atómico) |
| `/portfolio` | Snapshot cross-project agregado |
| `/atender` | Ranking de ítems abiertos en `## Para David` |
| `/daily-standup` | Catch-up interactivo por proyecto |
| `/promote <slug>` | Propuesta firmada → hermano técnico |
| `/status <slug>` | Snapshot profundo de un proyecto |
| `/brief`, `/synthesis`, `/procesar`, `/preguntar`, `/limpiar` | Knowledge-capture operations |

Esto NO es invocable desde proyectos externos (solo cuando estás parado en el vault). El plugin `claudio-agents-kit:setup` (este kit) atiende otro nicho: bootstrappear agentes/skills locales por proyecto.

## Cuándo usar

- Turno que lee o escribe cualquier archivo del vault.
- Turno que mapea un repo a su proyecto vault (ej: "¿a qué proyecto pertenece este repo?").
- Turno que necesita contexto cualitativo de un proyecto (estado, milestone, archetype).
- Turno que va a crear/editar una nota o un README de proyecto.

## Cuándo NO usar

- Turno puramente de código en un repo que no toca el vault.
- Turno que ya tiene el frontmatter del proyecto en contexto.

## Ejemplos buenos

```
# correcto: leer conventions.md antes de crear una nota nueva
1. Leer 99-meta/conventions.md
2. Escribir la nota en knowledge-capture/notes/<area>/<slug>.md
3. Llenar todos los campos de frontmatter antes de guardar
```

```
# correcto: agregar item a Para David
1. Abrir portfolio-mgmt/projects/<slug>/README.md
2. Localizar sección `## Para David`
3. Apendear bullet con formato canónico: - [ ] {acción} · vence: {fecha} · prioridad: {p}
4. Actualizar `ultima_actualizacion` en frontmatter
```

## Ejemplos malos

```
# incorrecto: asumir la estructura sin leer el spec
- Crear nota directamente en portfolio-mgmt/ porque "parece de proyecto"
- Usar CamelCase en el slug del archivo (viola naming)
- Omitir campo `status` asumiendo que es opcional
- Confundir "Claudio" como el humano (no, es el colectivo de agentes; el humano es David)
- Escribir "Para Claudio" en un README nuevo (la convención es "Para David" desde 2026-05-21)
```

## Ver también

- `github-repo-inventory` — inventario de repos GitHub y su mapeo a proyectos vault.
- `warroom-task-contract` — warroom es un proyecto dentro de `portfolio-mgmt/projects/warroom/`.
- `99-meta/conventions.md` en el vault — spec canónico; esta skill no reemplaza su lectura.
- `99-meta/refactor-portfolio-mgmt.md` en el vault — log vivo del refactor que renombró `scaffolding/` → `portfolio-mgmt/` y formalizó la convención `## Para David`.

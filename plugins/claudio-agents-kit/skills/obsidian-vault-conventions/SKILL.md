---
name: obsidian-vault-conventions
description: Pointer al spec canónico del vault de Obsidian de Claudio (99-meta/conventions.md). Invocar al inicio de cualquier turno que lea o escriba notas del vault, o que necesite mapear un proyecto/repo a su contexto cualitativo. NO duplica el spec; lo referencia + minimum quick-reference.
---

# Obsidian Vault Conventions

Quick-reference de la estructura y convenciones del vault de Claudio. El spec completo vive en el vault; esto es un puntero + resumen mínimo para que un agente no arranque en blanco.

## Punto de partida

- **Vault**: `~/Documents/Obsidian Vault/` (Windows: `C:\Users\dagui\Documents\Obsidian Vault\`)
- **Source of truth**: `99-meta/conventions.md` — leer ANTES de escribir cualquier nota nueva o cambiar estructura.

## Modelo del vault (resumen rápido)

Dos macro procesos, loose-coupled. La conexión entre ellos es manual vía Claudio — ningún script de un macro proceso invoca al del otro.

| Macro proceso | Raíz | Para qué |
|---|---|---|
| `knowledge-capture/` | capturar + procesar conocimiento | Notas de síntesis, ideas, inbox de lecturas |
| `scaffolding/` | crear + observar proyectos | Proyectos activos, scripts, arquitectura |
| `99-meta/` | transversal compartido | Convenciones, inventario de repos, templates |

## Dónde escribe Claude por defecto

| Qué | Dónde |
|---|---|
| README de proyecto | `scaffolding/projects/<slug>/README.md` |
| Decisiones / ADRs | `scaffolding/projects/<slug>/decisions.md` |
| Notas de síntesis | `knowledge-capture/notes/<area>/` |
| Ideas propias | `knowledge-capture/ideas/` |
| Captures crudos | `knowledge-capture/inbox/` (gitignored, efímero) |

## Frontmatter de proyecto

Archivo: `scaffolding/projects/<slug>/README.md`

```yaml
project: <nombre legible>
estado: activo | propuesta | atorado | pausado | archivado
tipo: platform | proposal | portfolio | automation | data | infra-interna
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
project: Warroom
estado: activo
tipo: platform
archetype: ai-agent
milestone_proximo: ADR-003 definir protocolo de comunicación planner↔executor
fecha_objetivo: 2026-06-30
ultima_actualizacion: 2026-05-21
repo: https://github.com/xguilxr/warroom
repo_estado: activo
repos_aux: []
```

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
why_it_matters: <por qué importa para el trabajo de Claudio>
```

## Naming

- Carpetas y archivos: kebab-case minúsculas (`analisis-de-mercado.md`, `data-pipeline/`).
- Excepciones en MAYÚSCULAS: `CLAUDE.md`, `README.md`.
- Slugs de proyecto: regex `^[a-z0-9-]+$`. Sin acentos en paths (la carpeta es `diseno`, el frontmatter es `area: diseño`).
- Los wikilinks en frontmatter usan la ruta relativa completa: `[[../scaffolding/projects/warroom/README]]`.

## Cuándo usar

- Turno que lee o escribe cualquier archivo del vault.
- Turno que mapea un repo a su proyecto vault (ej: "¿a qué proyecto pertenece este repo?").
- Turno que necesita contexto cualitativo de un proyecto (estado, milestone, archetype).

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

## Ejemplos malos

```
# incorrecto: asumir la estructura sin leer el spec
- Crear nota directamente en scaffolding/ porque "parece de proyecto"
- Usar CamelCase en el slug del archivo (viola naming)
- Omitir campo `status` asumiendo que es opcional
```

## Ver también

- `github-repo-inventory` — inventario de repos GitHub y su mapeo a proyectos vault.
- `warroom-task-contract` — warroom es un proyecto dentro de `scaffolding/projects/warroom/`.
- `99-meta/conventions.md` en el vault — spec canónico; esta skill no reemplaza su lectura.

---
description: Scaffolda un proyecto nuevo usando uno de los 5 templates (platform, proposal, portfolio, automation, data). Pregunta al usuario por nombre, tipo y carpeta destino.
---

# Crear proyecto nuevo con template

Ejecutá el script `${CLAUDE_PLUGIN_ROOT}/scripts/new-project.sh` para scaffoldear un proyecto nuevo.

## Pasos

1. **Preguntá al usuario** (Claudio), uno a uno:
   - Nombre del proyecto (kebab-case, ej: `farmax-inventario`)
   - Tipo de proyecto. Opciones:
     - `platform` — PaaS full-stack (backend + frontend + DB)
     - `proposal` — Propuesta comercial / cotización
     - `portfolio` — Website de portafolio (creativo o profesional)
     - `automation` — Automatización Python (script, scheduled job)
     - `data` — Data analysis / reportes
   - Carpeta destino (por defecto: `~/projects`)

2. **Corré el script** con bash:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/new-project.sh <nombre> <tipo> <destino>
```

3. **Mostrale al usuario** la estructura creada y sugerí los siguientes pasos:
   - `cd <carpeta>`
   - Completar las secciones del `CLAUDE.md` generado (brief del proyecto, cliente, convenciones)
   - Primer mensaje al orquestador: "Leé el CLAUDE.md y llamá a `discovery-agent` para arrancar"

## Notas

- El script usa los templates que viven en `${CLAUDE_PLUGIN_ROOT}/templates/project-types/`.
- Cada tipo de proyecto crea estructura de carpetas y `.gitignore` apropiados:
  - `data` → `data/{raw,interim,processed}` + notebooks
  - `automation` → `src/`, `tests/`, `.github/workflows/`
  - `platform` → `app/`, `tests/`, `.github/workflows/`
  - `portfolio` → vacío (el frontend-expert decide stack)
  - `proposal` → no hace git init (típicamente no va a repo)

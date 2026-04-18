---
name: git-flow
description: Flujo de branches y PRs estándar para proyectos de Claudio-Enterprises. Invocar cuando se arranca un proyecto nuevo, se hace un commit, o se abre un PR.
---

# Git Flow — Claudio-Enterprises

## Branches

```
main            ← producción, protegida, solo merge via PR
develop         ← staging, integración continua
feature/xxx     ← cada feature nueva
fix/xxx         ← bugfixes
chore/xxx       ← tareas de mantenimiento (deps, refactor sin feature)
```

## Flujo estándar

```bash
# 1. Crear branch desde develop
git checkout develop
git pull
git checkout -b feature/inventario-reporte

# 2. Trabajar, commits chicos y frecuentes
git add .
git commit -m "feat(reports): add monthly sales aggregation"

# 3. Push y abrir PR a develop
git push -u origin feature/inventario-reporte

# 4. Cuando develop está estable, PR develop → main
```

## Protección de branches (configurar en GitHub)

**`main`:**
- Requiere PR
- Requiere CI en verde
- Requiere al menos 1 review (por ahora, vos mismo en modo dual)
- No permitir force push
- No permitir delete

**`develop`:**
- Requiere PR
- Requiere CI en verde

## Commits atómicos

Un commit = un cambio lógico. Si tu commit necesita un "y" en el mensaje, probablemente deberían ser 2 commits.

## Ver también

- `commit-message-format` para el formato exacto de mensajes.

## Rebase vs Merge

- **Feature branch → develop**: `--no-ff` merge (mantiene historia de la feature)
- **Tu branch local con develop antes de PR**: rebase para mantener lineal:
  ```bash
  git checkout feature/xxx
  git fetch origin
  git rebase origin/develop
  ```

## Tags para releases

```bash
git checkout main
git pull
git tag -a v1.2.0 -m "Release 1.2.0: sales reports + user management"
git push origin v1.2.0
```

Esto dispara el workflow de deploy a producción.

## Hooks útiles (pre-commit)

`.pre-commit-config.yaml`:
```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.6.0
    hooks:
      - id: ruff
      - id: ruff-format
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-added-large-files
      - id: check-merge-conflict
```

Instalar: `pip install pre-commit && pre-commit install`

## Reglas

- **Nunca `git push --force` a `main` o `develop`.** Nunca. Para tu feature branch está bien.
- **Nunca commiteás `.env`, credenciales, o archivos de DB.** `.gitignore` bien armado desde el inicio.
- **PRs chicas.** Si tu PR tiene >500 líneas cambiadas, dividila.
- **Descripción de PR útil**: qué, por qué, cómo probarlo.

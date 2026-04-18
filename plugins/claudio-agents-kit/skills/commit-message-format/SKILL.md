---
name: commit-message-format
description: Formato de mensajes de commit siguiendo Conventional Commits. Invocar en cada commit para mantener historia limpia y permitir CHANGELOG automático.
---

# Commit Messages — Conventional Commits

## Formato

```
<type>(<scope>): <subject>

<body opcional>

<footer opcional>
```

## Types permitidos

| Type | Cuándo usarlo |
|---|---|
| `feat` | Nueva funcionalidad visible para el usuario |
| `fix` | Corrección de bug |
| `refactor` | Cambio de código sin cambiar comportamiento |
| `perf` | Optimización de performance |
| `test` | Agregar o modificar tests |
| `docs` | Solo documentación (README, docstrings) |
| `chore` | Mantenimiento (deps, configs, tooling) |
| `ci` | Cambios en CI/CD |
| `build` | Cambios en sistema de build |
| `style` | Formato, linter (sin cambio de código) |

## Scope

El módulo o área afectada:
- `feat(auth): ...`
- `fix(orders): ...`
- `chore(deps): ...`
- `refactor(etl): ...`

Si el commit toca varios módulos, no hay scope:
- `refactor: extract common validation logic`

## Subject

- Imperativo, presente: "add", "fix", "remove" (NO "added", "fixes")
- Minúscula al inicio
- Sin punto al final
- Máx 72 caracteres

## Ejemplos buenos

```
feat(orders): add filter by date range to list endpoint
fix(auth): prevent token refresh race condition
refactor(etl): extract CSV parsing into reusable function
perf(reports): use window function instead of subquery
test(orders): add edge cases for negative quantities
docs: update README installation steps for Windows
chore(deps): bump fastapi to 0.110.0
```

## Ejemplos malos

```
update code              ← ¿qué código? ¿qué update?
Fixed stuff.             ← pasado + no dice qué
feat: new feature        ← cero información
WIP                      ← no commitear WIPs a branches compartidos
asdasd                   ← en serio
```

## Body (opcional)

Cuándo agregar body: si el "por qué" no es obvio del subject.

```
refactor(etl): switch from iterrows to vectorization

Loop sobre 200k filas tardaba 45s, ahora 0.8s.
El resultado es idéntico (validado con hash del DataFrame final).

Closes #42
```

## Breaking changes

```
feat(api)!: change users endpoint response shape

BREAKING CHANGE: `GET /users` now returns `{items, total}` instead of `[...]`.
Frontend needs to update consumer.
```

## Commits que cierran issues

Footer:
```
Closes #123
Fixes #456
Refs #789
```

## Workflow antes de pushear

```bash
git add -p                              # stageá por hunks, revisá cada cambio
git commit -m "feat(x): add y"
git log --oneline -5                    # revisá últimos commits antes de push
```

## Cuándo splittear commits

Si tu diff tiene:
- Una feature nueva + un refactor no relacionado → 2 commits
- 3 bugs arreglados → 3 commits (uno por bug)
- Un feature grande con múltiples sub-partes coherentes → 1 commit está bien si están todas relacionadas

Regla: cada commit debería poder revertirse sin romper nada más.

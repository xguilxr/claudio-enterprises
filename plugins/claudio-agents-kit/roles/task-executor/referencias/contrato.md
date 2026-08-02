# El contrato

Lo que `task-executor` recibe. Es la única entrada: no hay conversación después.

Un contrato mal escrito produce trabajo que hay que tirar, y lo produce en silencio. Por eso
el rol valida el contrato **antes** de tocar un archivo y devuelve `blocked` si no pasa.

## Formato

```yaml
goal: <una frase clara y accionable>

context_files:                    # lo que hay que leer antes de escribir
  - src/api/routers/users.py
  - src/schemas/user.py

constraints:                      # solo lo NO obvio
  - No modificar tests existentes en tests/test_users.py
  - No cambiar el esquema UserOut, ya acordado con el frontend

definition_of_done:               # comandos, no deseos
  - pytest tests/test_users.py -q pasa en verde
  - ruff check src/api/routers/users.py sin errores

# ── Bloques que cierran las puertas de MCA ──────────────────────────────────

limites:                          # AUT-04 · opcional; solo puede APRETAR el catálogo
  iteraciones: 25
  minutos: 15

autorizaciones:                   # AUT-01 · ausencia = denegación
  - accion: empujar a la rama de trabajo
    justificacion: la rama es efímera y nadie más la tiene
  # Solo acciones de `catalogo.yaml` → irreversibles.autorizables_por_contrato.
  # Cada una con justificación escrita. Sin justificación no cuenta como autorizada.

traza:                            # AUT-05 · opcional
  destino: .claude/trazas/        # por omisión, esta misma ruta

report_back:                      # qué necesita saber quien planifica
  - Nombre del handler agregado y su ruta registrada
```

## Qué importa de cada campo

**`goal`** — accionable en una frase. Si no cabe en una, el contrato está mal desglosado:
son dos contratos. `mejorar el módulo de usuarios` devuelve `blocked`.

**`context_files`** — explícito mejor que implícito. Sin esta lista el rol explora a ciegas,
gasta iteraciones y asume cosas. Toda ruta debe caer dentro del ámbito: una que apunte fuera
del árbol de trabajo invalida el contrato entero.

**`constraints`** — solo lo que el rol podría violar sin saberlo. Lo que ya está implicado
por el objetivo no se repite: cada restricción de relleno le resta peso a las de verdad.

**`definition_of_done`** — comandos concretos con salida inequívoca. `que funcione` no es
verificable y devuelve `blocked`. Este campo es el que decide cuándo termina la sesión; si
es blando, no termina nunca o termina mintiendo.

**`limites`** — opcional, y **solo hacia abajo**. Un contrato que pida 80 iteraciones cuando
el techo son 40 no se negocia a la baja: se rechaza. El techo vive en `catalogo.yaml`.

**`autorizaciones`** — el mecanismo entero de AUT-01. Solo acciones que el catálogo liste
como autorizables, una por una, con justificación. Lo que no aparece aquí, no ocurre.

**`report_back`** — qué necesita quien planifica para decidir lo siguiente. Formato del
informe en `disciplina.md`.

## Cuándo NO se usa

Sesiones interactivas con una persona presente. El flujo normal no usa contratos, y forzarlo
solo añade ceremonia.

## Ejemplo que funciona

```yaml
goal: Agregar endpoint GET /users/{id} que devuelva UserOut o 404
context_files:
  - src/api/routers/users.py
  - src/models/user.py
  - src/schemas/user.py
constraints:
  - No modificar tests existentes en tests/test_users.py
  - No cambiar el esquema UserOut
definition_of_done:
  - pytest tests/test_users.py::test_get_user_by_id -v pasa
  - pytest tests/test_users.py::test_get_user_not_found -v pasa
  - ruff check src/api/routers/users.py sin errores
limites:
  iteraciones: 25
autorizaciones: []
report_back:
  - Nombre del handler y su ruta registrada
  - Cualquier rareza en el esquema existente
```

`autorizaciones: []` es una lista vacía **escrita a propósito**. Dice «revisé si hacía falta
autorizar algo y no hacía falta», que no es lo mismo que haberlo olvidado.

## Ejemplo que devuelve `blocked`

```yaml
goal: mejorar el código de usuarios          # ambiguo → blocked
context_files: []                            # el rol exploraría a ciegas
constraints: []
definition_of_done:
  - que funcione                             # no verificable → blocked
report_back:
  - lo que hiciste                           # nadie sabe qué esperar
```

Cuatro problemas y ninguno se detecta al leerlo rápido. Por eso la validación es del rol y
no de quien escribe el contrato.

## Ver también

- `disciplina.md` — cómo se comporta el rol con este contrato en la mano
- `traza.md` — qué queda registrado de la ejecución
- `../catalogo.yaml` — los techos que el contrato no puede levantar

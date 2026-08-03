# Claudio-Enterprises

Familia de **cuatro marcos de trabajo** y el paquete que los opera.

| | Qué gobierna | Requisitos |
|---|---|---|
| **MFB** | Cómo se construye un marco | 52 |
| **MCA** | Cómo trabaja Claude sobre un repositorio | 48 |
| **MCC** | Cómo se conduce un encargo de cliente | 92 |
| **MCS** | Cómo se construye software de calidad | 204 |

**Empezá por [`docs/ORQUESTADOR.md`](docs/ORQUESTADOR.md).** Son 396 requisitos y no se
cargan nunca todos: el orquestador dice qué entra y cuándo. Por defecto, nada.

- [`docs/README.md`](docs/README.md) — qué existe. **Es el inventario; los conteos se
  verifican ahí y en ningún otro lado**
- [`docs/AUDITORIA.md`](docs/AUDITORIA.md) — cómo se audita un proyecto: MCA → MCC → MCS
- [`docs/conocimiento/glosario.yaml`](docs/conocimiento/glosario.yaml) — el único eje común

---

## Instalación

En cualquier máquina donde uses Claude Code, una sola vez:

```bash
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

Verificá desde la terminal:

```bash
claude plugin list
```

Y dentro de Claude Code, `/skills` lista las 22 skills del kit.

### (Recomendado) Linkear el CLAUDE.md global

Para que las reglas globales se actualicen solas con cada `plugin update`:

```bash
mkdir -p ~/.claude
ln -sf ~/.claude/plugins/claudio-enterprises/claudio-agents-kit/templates/CLAUDE-global.md ~/.claude/CLAUDE.md
```

Si preferís editarlo con reglas personales, usá `cp` en vez de `ln -sf` y re-copiá cuando el
kit evolucione.

---

## Cómo se invoca

**El plugin no tiene slash commands propios desde la v6.0.0.** Todo lo que se invoca es una
skill, y una skill del plugin se llama con el prefijo del plugin:

```
/claudio-agents-kit:auditar-proyecto
```

Sin el prefijo, Claude Code no la encuentra. Tres formas válidas, en orden de preferencia:

| Forma | Cuándo |
|---|---|
| Pedilo en prosa — «auditá este proyecto» | Casi siempre. La `description` de cada skill está escrita para que active sola |
| `/claudio-agents-kit:<skill>` | Cuando querés esa skill y no otra |
| `/<skill>` a secas | Solo skills locales del proyecto, en `.claude/skills/` |

**El punto de entrada es `auditar-proyecto`.** Corre los tres marcos en orden y devuelve un
solo plan. No hace falta adjuntar nada: los documentos viajan dentro del plugin.

---

## Qué trae el paquete

```
plugins/claudio-agents-kit/
├── skills/            ← 22 skills que operan los marcos, en cualquier repositorio
├── marcos/            ← copia de docs/ que viaja con el plugin
├── plantillas-skill/  ← 27 skills de stack, se copian al proyecto que las necesita
├── corpus/            ← 7 documentos de conocimiento de referencia
├── roles/             ← 1 rol: task-executor
├── templates/         ← plantillas de proyecto y CLAUDE-global.md
└── scripts/           ← sincronizar-marcos.sh
```

**El inventario completo de las 22 skills está en [`docs/README.md`](docs/README.md) §4**,
con marco y requisitos que cierra cada una. Acá no se repite: una tabla duplicada se
desactualiza, y esta ya se desactualizó una vez.

Los cinco puntos de entrada más usados:

| Quiero… | Skill |
|---|---|
| Saber en qué estado está un proyecto | `auditar-proyecto` |
| Que Claude trabaje bien en este repo | `andamiaje-entorno` |
| Ver qué tiene un repo en 20 minutos | `quick-scan` |
| Encuadrar lo que un cliente pide | `encuadrar-encargo` |
| Convertir algo que repito en una skill | `destilar-skill` |

### Las plantillas de skill no se cargan

`plantillas-skill/` no entra en contexto nunca desde el plugin. Existe para que el
conocimiento de un stack no le cueste contexto a los proyectos que no usan ese stack.
`andamiaje-entorno` copia al proyecto solo las que le correspondan. Es MCA CAP-06.

### Agentes: no hay

Los 22 agentes se retiraron en la v6.0.0. Se les aplicó la rúbrica de autonomía de MCS-G04
track E y **uno solo pasó el umbral**: `task-executor`, y sigue en estado `candidato`. Los
otros 21 se descompusieron en skills y corpus. El detalle y la puntuación de cada uno están
en [`docs/migracion/03-disposicion.md`](docs/migracion/03-disposicion.md).

---

## Actualizar el kit

```bash
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

**Cerrá Claude Code antes de correrlo.** Actualizar con el proceso abierto deja el caché a
medio escribir; ver Troubleshooting.

---

## Evolucionar el kit (solo dentro de este repo)

Pedile la skill de mantenimiento:

```
> Usá mantener-marketplace para agregar una skill que audite contratos
```

`mantener-marketplace` hace el bookkeeping: crea desde plantilla, valida frontmatter,
sincroniza `marcos/`, bumpea `plugin.json` + `marketplace.json`, actualiza el `CHANGELOG.md`,
commitea en Conventional Commits y pushea a una rama.

El procedimiento completo, paso por paso, está en [`CLAUDE.md`](CLAUDE.md).

| Cambio | Bump |
|---|---|
| Typo, ajuste de descripción, corrección de documentación | PATCH |
| Skill, plantilla o documento nuevo, sin romper | MINOR |
| Renombrar o quitar algo existente; cambio que rompe flujos | MAJOR |

**Si no bumpeás, los consumidores no ven el cambio.** Claude Code cachea por versión.

---

## Estructura del repo

```
claudio-enterprises/
├── .claude-plugin/marketplace.json   ← índice público del marketplace
├── docs/                             ← los marcos. Contenido normativo, fuente de verdad
│   ├── ORQUESTADOR.md · README.md · CONVENCIONES.md · AUDITORIA.md
│   ├── conocimiento/  mfb/  mcs/  mcc/  mca/
│   └── migracion/                    ← salida de MCS-OP02, no es documento de marco
├── plugins/claudio-agents-kit/       ← el paquete instalable
├── CHANGELOG.md
├── CLAUDE.md                         ← reglas para trabajar DENTRO del repo
└── README.md
```

`docs/` es la fuente; `plugins/claudio-agents-kit/marcos/` es una copia de publicación.
**Si tocás `docs/`, sincronizá:**

```bash
bash plugins/claudio-agents-kit/scripts/sincronizar-marcos.sh
```

Sin eso, las skills quedan con una copia vieja del procedimiento. Con `--verificar` el script
falla y no copia: detecta original desaparecido, copia vieja y copia huérfana.

---

## Desarrollo local

Para probar cambios sin pushear:

```bash
cd ~/claudio-enterprises
claude plugin marketplace add "$(pwd)"
claude plugin install claudio-agents-kit
```

**El marketplace local se llama igual que el remoto** (`claudio-enterprises`, sale de
`marketplace.json`). Uno pisa al otro. Al terminar, devolvé la máquina al remoto:

```bash
claude plugin uninstall claudio-agents-kit
claude plugin marketplace remove claudio-enterprises
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

---

## Troubleshooting

### `Unknown command: /claudio-agents-kit:<skill>`

El plugin no cargó en esa sesión. Si la skill te funcionó antes y dejó de funcionar sin que
cambiara nada del repo, es el caché a medio actualizar. Las dos causas habituales:

- Correr `claude plugin update` **con Claude Code abierto**. Los archivos están tomados y la
  actualización queda parcial.
- Cerrar Claude Code **desde el Administrador de tareas**. El proceso muere sin escribir su
  estado, y la sesión siguiente arranca con el registro de plugins a medias.

Cerrá **todas** las ventanas de Claude Code y corré, en ese orden:

```bash
claude plugin list
claude plugin marketplace update
claude plugin update claudio-agents-kit
```

Si `claude plugin list` no muestra `claudio-agents-kit`, o lo muestra en una versión vieja,
reinstalá limpio:

```bash
claude plugin uninstall claudio-agents-kit
claude plugin marketplace remove claudio-enterprises
claude plugin marketplace add github:xguilxr/claudio-enterprises
claude plugin install claudio-agents-kit@claudio-enterprises
```

Abrí una sesión nueva y comprobá con `/plugin` que está habilitado y con `/skills` que
aparecen las 22.

### La skill existe pero el nombre no

En la v7.0.0 se renombró **`auditoria-conformidad` → `auditar-software`**. El nombre viejo
devuelve `Unknown command`. Los tres nombres de auditoría por marco son:

| Marco | Skill |
|---|---|
| MCA | `auditar-entorno` |
| MCC | `auditar-encargo` |
| MCS | `auditar-software` |

Para los tres en orden, `auditar-proyecto`.

### «No veo los cambios después de editar»

Olvidaste bumpear versión en `plugin.json` **y** en `marketplace.json`. Claude Code cachea
por versión: sin bump, el consumidor se queda en la vieja.

### «La auditoría no encuentra los documentos»

No adjuntes nada. Viajan en `marcos/`, dentro del plugin. Si la skill dice que no los
encontró, **debe parar y decirlo** — no reconstruir el procedimiento de memoria. Si en vez de
eso te devolvió una auditoría igual, es una auditoría inventada: descartala. Revisá que
`marcos/` esté sincronizado con `sincronizar-marcos.sh --verificar`.

### «La auditoría devuelve no conforme en casi todo»

Falta `conformidad.yaml` en la raíz del proyecto auditado, o declara un nivel objetivo que no
es el que querés. Sin nivel objetivo la auditoría no informa ninguna decisión. La tabla de
perfiles está en [`docs/AUDITORIA.md`](docs/AUDITORIA.md) §2.

---

## Versionado público

El CHANGELOG sigue [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Cada release
incluye notas de migración cuando rompe algo.

Versión actual: **7.0.1** (ver [`CHANGELOG.md`](CHANGELOG.md)).

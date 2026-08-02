---
id: MIG-03
titulo: Tabla de disposición y catálogo destino
marco: MCS
capa: operativa
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: un solo uso
depende_de: [MCS-OP02, MCS-G04, MIG-01, MFB-CORE, glosario]
---

# Disposición de los 63 activos y catálogo destino

Etapa 2 de MCS-OP02. Rúbrica aplicada: **MCS-G04 v0.1.0, Track E**, pendiente de validación.

Nada se ha movido ni borrado. Este documento es la fila de justificación que MCS-OP02 exige
antes de tocar cualquier activo.

---

# 1. Puntuación de los 22 agentes

Dimensiones: **1** selección · **2** secuencia · **3** bucle · **4** herramientas ·
**5** terminación · **6** recuperación. Umbral de rol: ≥9 **y** dimensión 4 en 2.

| Activo | 1 | 2 | 3 | 4 | 5 | 6 | Σ | Decisión |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
| **task-executor** | 2 | 2 | 2 | **2** | 2 | 1 | **11** | **ROL** |
| discovery-agent | 1 | 1 | 2 | 0 | 2 | 1 | 7 | Skill |
| navigator | 2 | 1 | 1 | 1 | 1 | 0 | 6 | Skill |
| optimizador | 1 | 0 | 2 | 2 | 1 | 0 | 6 | Skill |
| agent-manager | 1 | 0 | 0 | 2 | 0 | 1 | 4 | Skill |
| project-manager | 1 | 0 | 0 | 2 | 0 | 1 | 4 | Skill |
| limpiador | 0 | 0 | 1 | 2 | 0 | 1 | 4 | Skill |
| design-researcher | 1 | 0 | 1 | 1 | 0 | 1 | 4 | Fusionar |
| orquestador | 1 | 1 | 0 | 1 | 0 | 0 | 3 | **Ya existe** |
| code-council | 1 | 0 | 0 | 1 | 0 | 1 | 3 | Skill |
| security-auditor | 0 | 0 | 0 | 1 | 0 | 1 | 2 | Skill |
| documentador | 0 | 0 | 0 | 2 | 0 | 0 | 2 | Fusionar |
| backend · frontend · data · db · devops · qa | 0 | 0 | 0 | 2 | 0 | 0 | 2 | Corpus + skills |
| product-analyst | 0 | 0 | 0 | 0 | 0 | 1 | 1 | Plantilla + rúbrica |
| ui-reviewer | 0 | 0 | 0 | 1 | 0 | 0 | 1 | Skill |
| prompt-optimizer | 1 | 0 | 0 | 0 | 0 | 0 | 1 | Skill |
| client-reporter | 0 | 0 | 0 | 0 | 0 | 0 | 0 | Skill |

**Un rol de veintidós.** Es el resultado que MCS-OP02 anticipaba, y no por casualidad:
`task-executor` es el único activo que describe una sesión con herramientas que itera hasta
un criterio propio. Los demás describen qué hacer, no cómo decidirlo.

## 1.1 Los tres casos que merecen explicación

**`task-executor` = 11.** Recibe objetivo y restricciones, decide los pasos, escribe
código, corre los comandos del DoD, lee el resultado y sigue hasta cumplirlo o bloquearse.
Pierde un punto en recuperación: replanifica dentro del alcance pero nunca lo amplía, por
diseño explícito. Esa restricción es una virtud del activo, no un defecto — y aun así es lo
único que lo separa de 12.

**`orquestador` = 3, y no se convierte en nada.** Su contenido es una tabla de enrutamiento
entre agentes. Esa función ya la cumple `docs/ORQUESTADOR.md`, que además rutea marcos y no
solo agentes. El activo desaparece sin pérdida: su conocimiento ya está mejor expresado en
otro sitio. Es el único de los 22 que no deja descendencia.

**`discovery-agent` = 7, el más alto que no es rol.** Itera de verdad —repregunta cuando la
respuesta es vaga— y decide cuándo cerrar según un criterio propio del 80 %. Solo falla en
la dimensión 4: no tiene herramientas, produce texto. Es exactamente el caso que MCS-G04
§1.4 describe: un procedimiento bien escrito que no es un agente.

---

# 2. Disposición del resto de activos

| Activo actual | Destino | Justificación |
|---|---|---|
| 21 skills existentes | Ver §3 | 19 se conservan, 2 se fusionan |
| `templates/prompt-system-reference.md` | Corpus + skill | Contiene el prompt de `prompt-optimizer` duplicado (deriva D-02). El sistema de 6 modos es corpus; la operación es skill |
| `templates/CLAUDE-global.md` | **Partir en tres** | Es la causa de las derivas D-03 y D-04: declara stack, catálogo de agentes y reglas en un solo archivo. → `INSTRUCCIONES-PROYECTO.md` (L1) + corpus de stack + plantilla |
| `templates/notion-architecture.md` | Corpus | Documenta un sistema externo. No es plantilla: no se rellena |
| `templates/chrome-site-classification-prompt.md` | Prompt | Es una operación conversacional completa, no una plantilla |
| `templates/STYLE.md` | Plantilla | Se conserva. Es plantilla real |
| `templates/agent-template.md` · `skill-template.md` | **Retirar** | Reemplazadas por `MFB-T05` y por la desaparición de los agentes-rol |
| `templates/project-types/*.md` (5) | Plantilla | Se conservan. Son CLAUDE.md por tipo de proyecto |
| `templates/github/ci.yml` · `pytest/conftest.py` | Referencia de skill | Pasan a `referencias/` de `github-actions-ci` y `pytest-style` (divulgación progresiva) |
| `commands/setup.md` | Comando | Se conserva |
| `scripts/setup.sh` | **RETIRAR** | El CHANGELOG v5.1.0 lo declara superado por `/scaffold` del vault. 334 líneas muertas |

**Único activo propuesto para retirada real: `scripts/setup.sh`.** Todo lo demás se
transforma o se conserva. Las dos plantillas retiradas quedan cubiertas por MFB-T05.

---

# 3. Catálogo destino

## 3.1 Roles (1)

| Rol | Puntuación | Ámbito de herramientas a declarar |
|---|---|---|
| `task-executor` | 11 · dim4 = 2 | Pendiente: hoy hereda todo el entorno. IA-01 e IA-03 exigen acotarlo |

Absorbe la skill `executor-discipline`, hoy duplicada en tres sitios (deriva D-01).

**Antes de desplegarlo como rol** hay que cerrar las puertas de MCS-G04 §4: ADR con la
puntuación (IA-06), conjunto de evaluación con umbral (IA-07, IA-08), límites de iteración
y coste (IA-03), y acciones irreversibles con confirmación (IA-10). Hoy no cumple ninguna.

## 3.2 Skills — 34

### Marco · MFB (2)
| Skill | Cierra |
|---|---|
| `crear-marco` | EST-01..05 |
| `auditar-marco` | Todos los de MFB |

### Marco · MCS (12)
| Skill | Origen | Cierra |
|---|---|---|
| `auditar-software` (antes `auditoria-conformidad`) | MCS-P01 | GOB-03 |
| `quick-scan` | MCS-P03 | — |
| `redactar-adr` | MFB-T06 | ARQ-02, GOB-02 |
| `glosario-canonico` | nueva | LEN-01, DAT-01 |
| `definir-indicador` | nueva | DAT-10, DAT-13 |
| `rubrica-autonomia` | **MCS-G04** | IA-06 |
| `impacto-documental` | `documentador` | DOC-06 |
| `andamiaje-n1` | `scripts/setup.sh` + devops | CFG-01..06, INT-01 |
| `modelado-amenazas` | `security-auditor` (diseño) | SEG-06 |
| `auditar-deriva` | nueva | DAT-01..08 |
| `auditar-seguridad` | `security-auditor` (código) | SEG-01, SEG-04 |
| `optimizar-performance` | `optimizador` | — |

### Marco · MCC (5)
| Skill | Cierra |
|---|---|
| `encuadrar-encargo` | CTR-01..06 |
| `inmersion-sectorial` | INV-01..09 |
| `estimar-esfuerzo` | ESF-01..07 |
| `costear-solucion` | ECO-01..09 |
| `plan-por-tandas` | PLA-01..05 |

`encuadrar-encargo` absorbe el árbol de 7 capas de `discovery-agent`, que es su mejor
insumo y hoy vive suelto.

### Stack (10) — se conservan sin cambio de contenido
`commit-message-format` · `git-flow` · `karpathy-principles` · `pytest-style` ·
`vitest-patterns` · `github-actions-ci` · `fastapi-structure` ·
`postgres-query-patterns` · `pandas-conventions` · `react-query-patterns`

### Producto y UX (4)
| Skill | Origen |
|---|---|
| `epic-user-story-format` | se conserva; absorbe los criterios de corte de `product-analyst` |
| `docstring-google-style` | se conserva |
| `auditar-navegacion` | `navigator` |
| `criticar-pagina` | `ui-reviewer` |

### Ecosistema y operación (11)
| Skill | Origen |
|---|---|
| `buscar-inspiracion` | fusión de `design-inspiration-lookup` + `presentation-inspiration-lookup` |
| `buscar-branding` | fusión de `consultora-branding-lookup` + `prospect-branding-lookup` |
| `obsidian-vault-conventions` | se conserva |
| `github-repo-inventory` | se conserva |
| `warroom-task-contract` | se conserva |
| `mantener-marketplace` | `agent-manager` |
| `gestionar-queue` | `project-manager` |
| `reportar-a-cliente` | `client-reporter` |
| `refactorizar-legibilidad` | `limpiador` |
| `consejo-tecnico` | `code-council` |
| `optimizar-prompt` | `prompt-optimizer`, sin la duplicación del template |

**Las cuatro búsquedas en Notion pasan a dos.** Cada par es un mismo procedimiento sobre
dos fuentes: buscar referencias visuales, y buscar la identidad de una parte. El detalle por
fuente va a `referencias/`, que es divulgación progresiva y no un archivo por cada consulta.

## 3.3 Corpus (5)

| Corpus | Origen | Por qué no es skill |
|---|---|---|
| `stack.md` | los 6 expertos técnicos + `CLAUDE-global.md` | Conocimiento declarativo. Cierra la deriva D-03 |
| `sistema-prompts.md` | `prompt-system-reference.md` | Los 6 modos son conocimiento; la operación es skill |
| `notion-arquitectura.md` | `notion-architecture.md` | Describe un sistema externo |
| `discovery-capas.md` | `discovery-agent` | Árbol de indagación. Insumo de `encuadrar-encargo` |
| `veredicto-consejo.md` | `code-council` | Tabla de síntesis y veto de seguridad. Es rúbrica (CON-10) |

## 3.4 Balance

| | Hoy | Destino | Δ |
|---|---|---|---|
| Agentes / roles | 22 | **1** | −21 |
| Skills | 21 | 34 | +13 |
| Corpus | 0 | 5 | +5 |
| Retiradas reales | — | 3 | `setup.sh` + 2 plantillas |

MCS-OP02 declara la señal de éxito: *«no es que el repositorio tenga más archivos, sino que
tenga menos agentes y más skills»*. 22 → 1 y 21 → 34.

---

# 4. Efecto medido sobre la velocidad

## 4.1 Lo que se carga hoy en cada turno

| Fuente | Chars | ~Tokens |
|---|---|---|
| Descripciones de 22 agentes | 8 427 | 2 106 |
| Descripciones de 21 skills | 5 742 | 1 435 |
| `plugin.json` → `description` | 1 310 | 327 |
| **Total permanente** | **15 479** | **~3 870** |

Se carga se invoque o no. **Es el requisito ACT-01 incumplido**: *«Ningún marco DEBE
requerir carga permanente en contexto para el trabajo diario»*. El paquete viola hoy el
requisito del marco que aloja.

Los 22 agentes declaran además `memory: user`, que acumula entre sesiones sin techo
declarado.

## 4.2 Lo que queda después

Retirar 22 descripciones de agente ahorra los 2 106 tokens íntegros. Las 34 skills cuestan
más que las 21 actuales en número, pero ACT-04 pide descripciones en las palabras de quien
las necesita, no exhaustivas: un objetivo de 180 chars por skill deja el catálogo en ~6 100
chars.

| | Hoy | Destino |
|---|---|---|
| Permanente por turno | ~3 870 tokens | **~1 600 tokens** |

**Ahorro: ~2 270 tokens en cada turno de cada sesión.**

## 4.3 La causa mayor no está en el repositorio

`docs/` pesa **~69 000 tokens**. En esta sesión esos documentos entraron como adjuntos y se
reenvían completos en cada turno. Ya están en git: pedirlos por ruta en vez de adjuntarlos
es, con diferencia, la corrección de mayor efecto, y no requiere cambiar nada del código.

Es el principio del ORQUESTADOR aplicado a la conversación: por defecto no se carga nada.

---

# 5. Lo que este documento no decide

- **No mueve ni borra nada.** MCS-OP02 exige aprobar el plan antes de modificar archivos.
- **La puntuación no es autoritativa** hasta que David valide MCS-G04 (CON-08).
- **`scripts/setup.sh` es la única retirada propuesta** con evidencia propia; las otras dos
  son plantillas sustituidas por MFB-T05.
- **No se sabe qué agentes usa David hoy.** Trece conservan su commit inicial como único
  commit. La rúbrica dice qué son; no dice cuáles se echarán de menos.

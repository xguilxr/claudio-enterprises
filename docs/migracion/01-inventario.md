# Reabsorción MCS-P04 · Etapa 1 — Inventario y arqueología

| Campo | Valor |
|---|---|
| Tipo de documento | Referencia (Diátaxis) |
| Responsable | David Aguilar |
| Estado | Cerrado — pendiente de Punto de Control 1 |
| Fecha | 2026-08-02 |
| Prompt aplicado | `marco/prompts/MCS-P04-reabsorcion.md`, Etapa 1 |
| Marco de referencia | MCS-CORE v2.0.0 |
| Depende de | `marco/erratas-MCS-CORE-2.0.0.md` (E-06 es bloqueante para la Etapa 2) |

> **Alcance de esta etapa:** describir qué hay. No propone destinos, no propone estructura,
> no retira nada. Esas decisiones son de las Etapas 2 y 3, y P04 las condiciona a respuestas
> que solo David puede dar.

---

## 1.1 Inventario de activos

Fechas y número de commits obtenidos de `git log` por archivo. «Tipo declarado» es la
carpeta donde vive; «comportamiento real» es lo que el contenido hace efectivamente.

### Agentes — `plugins/claudio-agents-kit/agents/`

| Ruta | Tipo declarado | Qué hace realmente | Líneas | Últ. mod. | Commits |
|---|---|---|---|---|---|
| `orquestador.md` | agente | Tabla de enrutamiento a otros agentes + formato de plan. Pide confirmación humana antes de delegar | 60 | 2026-04-18 | 2 |
| `discovery-agent.md` | agente | Cuestionario estructurado de 7 capas, una pregunta por turno, con plantilla de brief consolidado | 128 | 2026-04-18 | 1 |
| `product-analyst.md` | agente | Plantillas Epic/US/TC + reglas de corte y workflow de 7 pasos | 147 | 2026-04-18 | 1 |
| `project-manager.md` | agente | Especificación del artefacto `PROJECT_QUEUE.md` + 6 operaciones sobre él | 184 | 2026-04-20 | 1 |
| `agent-manager.md` | agente | Procedimiento de mantenimiento del marketplace: crear/modificar/retirar, bump, CHANGELOG, commit | 195 | 2026-04-18 | 1 |
| `code-council.md` | agente | Convoca expertos, recoge votos en formato fijo, sintetiza con tabla de veredicto + veto de seguridad | 128 | 2026-04-23 | 1 |
| `task-executor.md` | agente | Persona para `claude -p`: parsea contrato, trabaja al DoD, emite report-back YAML | 69 | 2026-05-21 | 1 |
| `prompt-optimizer.md` | agente | Puntero a `templates/prompt-system-reference.md`; el prompt real vive en el template | 70 | 2026-04-23 | 1 |
| `design-researcher.md` | agente | Procedimiento de consulta a la DB `Inspiración` de Notion + formato de entrega | 160 | 2026-04-18 | 3 |
| `navigator.md` | agente | Procedimiento de auditoría del grafo de navegación + criterios de hallazgo | 138 | 2026-05-05 | 1 |
| `ui-reviewer.md` | agente | Criterios de crítica visual de una página + formato de salida | 161 | 2026-05-05 | 1 |
| `limpiador.md` | agente | Checklist de refactor de legibilidad + workflow de 5 pasos + reglas de no-cambio | 55 | 2026-04-18 | 1 |
| `optimizador.md` | agente | Catálogo de antipatrones de performance por stack + workflow medir→cambiar→medir | 79 | 2026-04-18 | 1 |
| `documentador.md` | agente | Qué documentar / qué no + workflow. Delega el formato a la skill `docstring-google-style` | 51 | 2026-04-18 | 1 |
| `security-auditor.md` | agente | Checklist OWASP-like por categoría + workflow de escaneo + formato de reporte por severidad | 94 | 2026-04-18 | 1 |
| `backend-expert.md` | agente | Stack + estructura de proyecto + 5 principios + workflow de endpoint + reglas | 87 | 2026-04-24 | 2 |
| `frontend-expert.md` | agente | Stack + convenciones React/Tailwind + reglas | 89 | 2026-04-18 | 1 |
| `data-expert.md` | agente | Stack + 5 principios de pipeline + workflow + reglas Pandas | 69 | 2026-04-18 | 1 |
| `db-architect.md` | agente | Stack + convenciones de schema, índices y migraciones | 88 | 2026-04-18 | 1 |
| `devops-expert.md` | agente | Stack + convenciones de Docker/CI/deploy por plataforma | 91 | 2026-04-24 | 3 |
| `qa-expert.md` | agente | Stack de testing + criterios de cobertura y casos edge | 105 | 2026-04-24 | 2 |
| `client-reporter.md` | agente | Registro de comunicación no técnica + plantillas de update/reporte | 96 | 2026-04-18 | 1 |

**22 agentes. 2 344 líneas.** Ninguno declara catálogo de herramientas. Ninguno define un
bucle con decisión dinámica de acciones. Trece de los veintidós conservan su commit inicial
como único commit.

### Skills — `plugins/claudio-agents-kit/skills/`

| Ruta | Qué contiene realmente | Líneas | Últ. mod. |
|---|---|---|---|
| `commit-message-format/` | Convención Conventional Commits + ejemplos buenos/malos | 119 | 2026-04-18 |
| `git-flow/` | Modelo de ramas, protección, tags, hooks | 104 | 2026-04-18 |
| `karpathy-principles/` | 4 principios transversales de escritura de código + atribución de fuente | 108 | 2026-05-05 |
| `pytest-style/` | 7 reglas de performance + estilo + checklist de cierre | 274 | 2026-04-24 |
| `vitest-patterns/` | 5 reglas + config canónica + checklist | 202 | 2026-04-24 |
| `github-actions-ci/` | Principios de CI, caching, jobs del gate, plantilla, antipatrones | 244 | 2026-04-24 |
| `fastapi-structure/` | Árbol de proyecto + patrón thin router / fat service | 166 | 2026-04-18 |
| `postgres-query-patterns/` | Patrones de query, índices, antipatrones, lectura de EXPLAIN | 140 | 2026-04-18 |
| `pandas-conventions/` | Patrones preferidos, tipos, merges, checklist de performance | 110 | 2026-04-18 |
| `react-query-patterns/` | Setup, hooks por recurso, keys, paginación, antipatrones | 168 | 2026-04-18 |
| `docstring-google-style/` | Formato de docstring por tipo de símbolo | 123 | 2026-04-18 |
| `epic-user-story-format/` | Plantillas Epic/US/TC + criterios de corte | 152 | 2026-04-18 |
| `proposal-writing/` | Estructura de 4 documentos comerciales | 205 | 2026-04-18 |
| `design-inspiration-lookup/` | Coordenadas y filtros de la DB Notion `Inspiración` | 205 | 2026-04-18 |
| `consultora-branding-lookup/` | Dónde vive el branding de consultoras socias + modalidades | 101 | 2026-04-18 |
| `prospect-branding-lookup/` | Recorrido recursivo del research de prospectos en Notion | 156 | 2026-04-18 |
| `presentation-inspiration-lookup/` | Dónde viven las refs de formato de presentación | 90 | 2026-04-18 |
| `obsidian-vault-conventions/` | Puntero al spec del vault + quick-reference | 198 | 2026-05-21 |
| `github-repo-inventory/` | Puntero al inventario de repos del vault | 102 | 2026-05-21 |
| `warroom-task-contract/` | Esquema YAML del contrato planner↔executor | 103 | 2026-05-21 |
| `executor-discipline/` | 5 reglas de comportamiento headless + formato de report-back | 106 | 2026-05-21 |

**21 skills. 3 176 líneas.** Todas tienen `name` y `description`; ninguna declara qué
requisitos MCS ayuda a cumplir, ni qué acciones exigen confirmación humana, ni usa
divulgación progresiva (todo el contenido está en el `SKILL.md`, sin `referencias/`).

### Plantillas, comandos y scripts

| Ruta | Tipo declarado | Qué hace realmente | Líneas | Últ. mod. |
|---|---|---|---|---|
| `templates/prompt-system-reference.md` | plantilla | Sistema completo de 6 modos de prompt + **la especificación y el prompt del agente `prompt-optimizer` embebidos** | 416 | 2026-04-23 |
| `templates/CLAUDE-global.md` | plantilla | Configuración global: identidad, stack, catálogo de agentes, flujos por tipo de proyecto, 11 reglas, formato de reporte post-cambio | 227 | 2026-05-05 |
| `templates/notion-architecture.md` | plantilla | Arquitectura del workspace Notion: es documentación de un sistema externo, no una plantilla rellenable | 217 | 2026-04-18 |
| `templates/chrome-site-classification-prompt.md` | plantilla | Prompt conversacional completo para Claude Chrome. No es plantilla: es una operación | 195 | 2026-04-18 |
| `templates/STYLE.md` | plantilla | Plantilla real de tokens de diseño por proyecto | 189 | 2026-04-18 |
| `templates/agent-template.md` | plantilla | Andamiaje de agente nuevo | 41 | 2026-04-18 |
| `templates/skill-template.md` | plantilla | Andamiaje de skill nueva | 44 | 2026-04-18 |
| `templates/project-types/platform.md` | plantilla | CLAUDE.md de proyecto tipo PaaS | 122 | 2026-04-18 |
| `templates/project-types/proposal.md` | plantilla | CLAUDE.md de proyecto tipo propuesta | 107 | 2026-04-18 |
| `templates/project-types/portfolio-website.md` | plantilla | CLAUDE.md de proyecto tipo portfolio | 131 | 2026-04-18 |
| `templates/project-types/automation.md` | plantilla | CLAUDE.md de proyecto tipo automatización | 133 | 2026-04-18 |
| `templates/project-types/data-analysis.md` | plantilla | CLAUDE.md de proyecto tipo análisis de datos | 142 | 2026-04-18 |
| `templates/github/ci.yml` | plantilla | Workflow de CI de referencia | 210 | 2026-04-24 |
| `templates/pytest/conftest.py` | plantilla | `conftest.py` de referencia con SAVEPOINT | 208 | 2026-04-24 |
| `commands/setup.md` | comando | Procedimiento interactivo de bootstrap de agentes/skills locales | 181 | 2026-05-21 |
| `scripts/setup.sh` | script | Scaffolding de proyecto por tipo. Declarado obsoleto en el CHANGELOG v5.1.0 | 334 | 2026-04-23 |

### Raíz

| Ruta | Qué hace | Líneas |
|---|---|---|
| `.claude-plugin/marketplace.json` | Índice público del marketplace. Versión 5.1.0 | 18 |
| `plugins/claudio-agents-kit/.claude-plugin/plugin.json` | Manifiesto del plugin. Versión 5.1.0 | 24 |
| `CLAUDE.md` | Instrucciones de trabajo dentro del repo marketplace | 141 |
| `README.md` | Instalación y catálogo | 189 |
| `CHANGELOG.md` | Keep a Changelog, hasta 5.1.0 | 296 |
| `LICENSE` | MIT | — |

**Total inventariado: 63 activos, ~9 000 líneas.**

### Actividad

Último commit del repositorio: **2026-05-21**. Han pasado **73 días** sin cambios.
Trece de los veintidós agentes no se han tocado desde el commit inicial del 18 de abril.

---

## 1.2 Arqueología del conocimiento

Naturalezas conforme a P04 §1.2: TERMINOLOGÍA · REGLA · PROCEDIMIENTO · CRITERIO ·
PLANTILLA · EJEMPLO · RETÓRICA.

### Lo que contienen los agentes

| Agente | Conocimiento que contiene | Naturaleza dominante |
|---|---|---|
| `discovery-agent` | Árbol de 7 capas de indagación, regla de una pregunta por turno, criterio de cierre al 80 %, plantilla de brief | **PROCEDIMIENTO** + PLANTILLA |
| `product-analyst` | Jerarquía Epic→US→TC, criterios de corte (Epic = demo-eable, US = 1-3 días, TC = validable sin ambigüedad), plantillas | **PROCEDIMIENTO** + CRITERIO |
| `project-manager` | Esquema completo de `PROJECT_QUEUE.md`, 6 operaciones, 10 reglas de integridad (append-only, numeración no reutilizable, timestamp obligatorio) | **PROCEDIMIENTO** + REGLA |
| `agent-manager` | Secuencia de mantenimiento del marketplace con bump SemVer, CHANGELOG y commit | **PROCEDIMIENTO** |
| `code-council` | Tabla dominio→experto, formato de voto, **tabla de síntesis de veredicto y veto de seguridad** | **CRITERIO** (rúbrica real) + PROCEDIMIENTO |
| `navigator` | Qué constituye un dead-end, un loop, una ruta huérfana; umbral de ≤3 clics | **CRITERIO** |
| `ui-reviewer` | Criterios de densidad, jerarquía, uso del espacio, consistencia de tokens | **CRITERIO** |
| `design-researcher` | Cómo consultar Notion y qué extraer | **PROCEDIMIENTO** |
| `optimizador` | Catálogo de antipatrones por stack + regla «medir antes» | **REGLA** + PROCEDIMIENTO |
| `limpiador` | Qué sí / qué no toca, workflow, regla «no cambiás lógica» | **REGLA** + PROCEDIMIENTO |
| `security-auditor` | Checklist por categoría (secrets, authn/authz, injection, config, deps, PII) | **REGLA** (checklist) |
| `documentador` | Qué documentar / qué no | REGLA |
| `task-executor` | Parseo de contrato, criterio de `status`, formato de report-back | **PROCEDIMIENTO** — *duplicado, ver D-01* |
| `prompt-optimizer` | Nada propio: apunta al template | — *duplicado, ver D-02* |
| `orquestador` | Tabla de enrutamiento entre agentes | CRITERIO — *depende del catálogo, ver D-04* |
| `backend-expert` | Stack, estructura de proyecto, 5 principios, workflow de endpoint, reglas | REGLA — *parcialmente duplicado, ver D-03* |
| `frontend-expert`, `data-expert`, `db-architect`, `devops-expert`, `qa-expert` | Ídem: stack + principios + reglas por dominio | REGLA — *parcialmente duplicado, ver D-03* |
| `client-reporter` | Registro y plantillas de comunicación no técnica | PLANTILLA + REGLA |

### Retórica

Los 22 agentes abren con la misma estructura: `# Rol` seguido de *«Sos el X del equipo de
Claudio-Enterprises»*. Esa declaración no aporta competencia y es exactamente lo que
**CON-02** prohíbe:

> El conocimiento del dominio DEBE residir en artefactos versionados. NO DEBE implementarse
> únicamente mediante instrucciones de rol dirigidas a un modelo.

Volumen estimado de retórica pura: **60–80 líneas** repartidas en los 22 archivos. Es poco
en líneas y mucho en efecto: es el mecanismo por el que hoy se aparenta competencia.

**Matiz importante y contrario a la lectura fácil de P04:** la retórica es la capa fina.
Debajo hay procedimiento y criterio reales y bien escritos —el árbol de 7 capas de
`discovery-agent`, las 10 reglas de integridad de `project-manager`, la tabla de veredicto
de `code-council`—. Este repositorio **no** es un catálogo de roles vacíos. Es un cuerpo de
conocimiento operativo con una capa de rol encima. La reabsorción debe conservar lo primero
y retirar lo segundo, y no al revés.

### Duplicaciones verificadas

Deriva conceptual en el sentido de MCS-CORE §3.4: un mismo concepto definido en más de un
lugar, sin fallo detectable.

| ID | Concepto | Definido en | Consecuencia |
|---|---|---|---|
| **D-01** | Disciplina del executor headless | `agents/task-executor.md` (reglas + formato report-back) · `skills/executor-discipline/` (5 reglas + formato report-back) · `skills/warroom-task-contract/` (esquema del contrato) | Tres activos, un procedimiento. Los formatos de report-back deben coincidir y nada lo verifica |
| **D-02** | El agente `prompt-optimizer` | `agents/prompt-optimizer.md` · `templates/prompt-system-reference.md` §7, que contiene «Especificación» y «Prompt del agente» completos | El mismo agente está definido dos veces en el repositorio. Editar uno no actualiza el otro |
| **D-03** | El stack tecnológico | `templates/CLAUDE-global.md` §«Stack preferido» · sección «Stack estándar» de 6 agentes técnicos · skills `fastapi-structure`, `pandas-conventions`, `postgres-query-patterns`, `react-query-patterns`, `pytest-style`, `vitest-patterns` | Tres capas declaran el mismo stack. Cambiar de Vercel a otro proveedor exige tocar ≥8 archivos |
| **D-04** | El catálogo de agentes activos | `templates/CLAUDE-global.md` §«Mi equipo» · tabla de enrutamiento de `orquestador` · tabla de convocatoria de `code-council` · descripción de `plugin.json` · `README.md` · 5 templates de `project-types/` | Seis lugares. Añadir un agente exige seis ediciones coordinadas y ninguna verificación lo comprueba |

### Cifras vivas embebidas

CON-04 prohíbe que valores dependientes del momento de consulta residan en el corpus.

| Ubicación | Cifra viva | Riesgo |
|---|---|---|
| `plugin.json` → `description` | «Equipo de 22 agentes… con 21 skills… 5 templates» + historia de versiones de v5.0.0 y v5.1.0 en prosa | El campo funciona como CHANGELOG. Los conteos coinciden hoy (verificado: 22 / 21 / 5) y derivarán al primer cambio |
| `README.md` línea 3 | «22 agentes + 21 skills + 5 templates» | Ídem |
| `README.md` | «debe mostrar claudio-agents-kit con versión 5.1.0+» | Se desactualiza en cada release |
| `templates/CLAUDE-global.md` | «Vercel (default actual)», «PostgreSQL 15+», «SQLAlchemy 2.0», «Pydantic v2» | Decisiones de stack fechadas sin fecha declarada |
| `skills/design-inspiration-lookup/` y `design-researcher` | «migrado el 2026-04-18» + coordenadas de la DB de Notion | Identificadores de un sistema externo dentro del corpus |

### Autoridad no determinada

`skills/karpathy-principles/` es la **única** skill del repositorio que declara fuente y
licencia (*forrestchang/andrej-karpathy-skills*, MIT). Las otras veinte afirman
convenciones sin fuente, jurisdicción ni vigencia. Conforme a P04 §5.3, ese material se
conserva marcado **AUTORIDAD NO DETERMINADA**; no se promueve a normativo.

---

## 1.3 Estado del repositorio — reconocimiento MCS-P03

Aplicado `marco/prompts/MCS-P03-quickscan.md` a este repositorio, tratado como proyecto de
software. **P03 declara que no determina nivel de conformidad y este resultado no se
registra como evaluación.**

### Banderas rojas

**Ninguna.** No se hallaron secretos en el historial completo (37 commits, búsqueda de
patrones `sk-`, `ghp_`, `github_pat_`, `AKIA`, `xoxb-`, `ntn_`, claves privadas PEM). No hay
`.env`, `.pem` ni `.key` en el historial. No hay datos personales de terceros.

*Limitación declarada:* la búsqueda fue por patrón, no con una herramienta dedicada de
detección de secretos. Cubre las formas conocidas de credencial, no las arbitrarias.

### Inventario de herramientas

| Elemento | Estado | Nota |
|---|---|---|
| Gestor de dependencias y archivo de bloqueo | **NO APLICABLE** | El repositorio no tiene dependencias ejecutables |
| Linter / formateador | **AUSENTE** | Ni de Markdown ni de JSON |
| Verificador de tipos | **NO APLICABLE** | — |
| Pruebas | **AUSENTE** | Ninguna. Nada verifica que un `SKILL.md` tenga frontmatter válido, que un agente referencie skills existentes, ni que `plugin.json` y `marketplace.json` declaren la misma versión |
| Canalización de CI | **AUSENTE** | No existe `.github/` |
| Dockerfile / definición de entornos | **NO APLICABLE** | — |
| Migraciones | **NO APLICABLE** | — |
| Documentación | **PRESENTE** | README, CLAUDE.md, CHANGELOG al día hasta 5.1.0 |
| Componentes de IA (prompts, herramientas, evals) | **PARCIAL** | 22 agentes y 21 skills versionados (CFG-12 ✔). **Cero conjuntos de evaluación** |
| Definiciones de métricas | **NO APLICABLE** | — |

### Las doce comprobaciones

| # | Comprobación | Resultado | Evidencia |
|---|---|---|---|
| 1 | ¿Secretos en el historial completo? | **NO** | 37 commits recorridos, sin coincidencias |
| 2 | ¿Rama principal protegida? | **PARCIAL** | 14 de 16 commits de primer padre en `main` son merges de PR. Los 2 directos son el bootstrap (`c3f5c6a`, `d224e4d`). La práctica se cumple; la **regla que la impone no es verificable desde el repositorio**. Conforme a P01 regla 4, la disciplina humana no es un control |
| 3 | ¿Archivo de bloqueo determinista? | **NO APLICABLE** | Sin dependencias |
| 4 | ¿La CI ejecuta pruebas y bloquea el merge? | **NO** | No hay CI. Es la carencia estructural del repositorio |
| 5 | ¿Coma flotante en cálculo monetario? | **NO APLICABLE** | Sin rutas de cálculo |
| 6 | ¿Autorización sobre el objeto? | **NO APLICABLE** | — |
| 7 | ¿Filtro de inquilino en la consulta? | **NO APLICABLE** | — |
| 8 | ¿Dependencias vulnerables? | **NO APLICABLE** | — |
| 9 | ¿Copias de seguridad probadas? | **NO VERIFICADO** | El repositorio vive en GitHub; no se verificó política de respaldo |
| 10 | ¿La misma métrica implementada en más de un sitio? | **NO APLICABLE** literalmente; **SÍ** en su equivalente de conocimiento | Ver D-01 a D-04 |
| 11 | ¿Componente de IA que calcula cifras o corre con privilegios elevados? | **NO** | Ningún agente declara herramientas ni privilegios. Con el matiz de que la ausencia de catálogo de herramientas es también lo que impide llamarlos agentes |
| 12 | ¿Cifras o versiones dentro de prompts o documentos? | **SÍ** | Ver «Cifras vivas embebidas» en §1.2 |

### Lo que este repositorio hace bien

Se registra porque afecta decisiones de las etapas siguientes, no como elogio:

- **CFG-12 cumplido de origen.** Prompts, skills y definiciones de agente viven en el
  repositorio y se despliegan con el paquete. Nada se edita en consolas externas.
- **CFG-04 y CFG-08 cumplidos.** Conventional Commits y CHANGELOG en formato
  Keep a Changelog, mantenido con detalle hasta 5.1.0.
- **CFG-06 aplicado** a la versión pública, con `plugin.json` y `marketplace.json`
  sincronizados en 5.1.0.
- **La disciplina de PR se sostiene** desde el segundo día del repositorio.

Esto importa para la Etapa 4: la base de gestión de configuración ya existe, así que el
esfuerzo de reabsorción no arranca de cero. Lo que falta es la capa de verificación
automática, no la de disciplina.

### Carencias estructurales

Ordenadas por lo que condicionan aguas abajo:

1. **Sin CI ni verificación automática de nada.** Toda la coherencia del repositorio
   —frontmatter válido, versiones sincronizadas, referencias entre activos vivas— depende
   hoy de que quien edita se acuerde. Es la causa raíz de que D-01 a D-04 puedan existir
   sin ser detectadas.
2. **Sin conjuntos de evaluación.** IA-07 e IA-08 exigen que ninguna funcionalidad de nivel
   agente se despliegue sin evaluación previa con umbral que condicione el despliegue. Hoy
   no hay forma de saber si una skill se activa cuando debe ni si deja de activarse cuando
   no debe.
3. **Sin glosario canónico (LEN-01).** «Agente», «skill», «experto», «core», «kit»,
   «paquete» y «marketplace» se usan con sentido variable entre `README.md`, `CLAUDE.md`,
   `CLAUDE-global.md` y las descripciones de los propios agentes.
4. **Sin declaración de conformidad (GOB-01).** No existe `mcs.yaml`. Se emitirá en la
   Etapa 7, no antes: declarar un nivel sin auditoría sería exactamente lo que P03 prohíbe.
5. **Metadatos documentales ausentes (DOC-01).** Ningún documento del repositorio declara
   responsable, estado, fecha de revisión ni periodicidad. Los documentos creados por esta
   reabsorción sí lo hacen, para no pedir lo que no se practica.

---

## Lo que esta etapa NO decidió

Por diseño de P04, y para que el Punto de Control 1 sirva de algo:

- No se propuso destino para ningún activo.
- No se propuso estructura de repositorio.
- **No se retiró, movió ni renombró nada.** El paquete `plugins/claudio-agents-kit/` está
  intacto y los consumidores instalados no ven ningún cambio.
- No se aplicó la rúbrica del Track E: no fue entregada. Ver errata **E-06**, bloqueante
  para la Etapa 2.

## ⏸ Punto de Control 1

P04 exige detenerse aquí y preguntar a David tres cosas antes de proponer destinos:

1. **Qué activos son intocables.**
2. **Cuáles ya sabe que están muertos.**
3. **Qué uso real les da hoy.** Trece de los veintidós agentes no se han modificado desde
   el commit inicial, y el repositorio lleva 73 días quieto. Eso puede significar «están
   terminados» o «no se usan», y la diferencia cambia por completo la tabla de disposición.

Y una cuarta, derivada de E-06: **cómo resolver la ausencia de la rúbrica del Track E**,
porque sin ella la Etapa 2 no tiene criterio declarado para decidir qué sobrevive como
agente.

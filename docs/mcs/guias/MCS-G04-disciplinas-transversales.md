---
id: MCS-G04
titulo: Disciplinas transversales — Track E, autonomía
marco: MCS
capa: guia
version: 0.1.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCS-CORE, glosario]
cubre_codigo: []
---

# Disciplinas transversales

Guía de aplicación de MCS-CORE. Explica el razonamiento; no impone requisitos.

> ## ⚠️ PENDIENTE DE VALIDACIÓN — versión 0.1.0
>
> **Alcance real de este documento: solo el Track E.** Los tracks L (lenguaje), M
> (métricas) y K (documentación viva) están declarados en el índice y **no existen**.
>
> El Track E se redactó el 2026-08-02 a partir de MCS-CORE §3.7, §3.8, IA-06 y las
> entradas `agente`, `flujo-trabajo` y `skill` del glosario canónico. **No se recuperó de
> ningún documento previo: no existía.** MCS-OP02 lo daba por escrito y lo exigía para
> decidir qué activo sobrevive como rol.
>
> Se emite en 0.1.0 —por debajo de 1.0.0— porque CON-08 exige que el conjunto de
> evaluación de un dominio lo construya o certifique una persona experta distinta de quien
> desarrolla. Aquí no ocurrió. Hasta que David valide la rúbrica, sus puntuaciones son
> defendibles pero no autoritativas.
>
> **Qué haría cambiar esta rúbrica:** que la ejecución sobre casos reales produzca
> puntuaciones que contradigan el juicio de David sobre qué es un agente. Si eso pasa, la
> rúbrica está mal y se corrige ella, no el juicio.

---

# 1. Track E — Autonomía

## 1.1 El problema concreto

Un archivo declara `Sos el Backend Expert. Construís APIs REST limpias`. Otro archivo
recibe un contrato con un objetivo, escribe código, corre las pruebas, lee el fallo,
corrige y vuelve a correr hasta que pasan.

Los dos están en `agents/`. Solo el segundo es un agente.

La diferencia no es de calidad ni de importancia: es de mecanismo. El primero es una
declaración de identidad que consume contexto en cada sesión. El segundo es lo que
MCS-CORE §3.8 define como agente.

## 1.2 Las dos definiciones que gobiernan

**§3.7 flujo de trabajo.** *Secuencia de pasos predefinida en código, en la que un modelo
de lenguaje ejecuta pasos concretos sin decidir el orden.*

**§3.8 agente.** *Sistema en el que un modelo de lenguaje determina dinámicamente qué
acciones ejecutar y en qué orden, mediante un bucle con herramientas.*

Cinco propiedades salen de §3.8: **qué acciones** (selección), **en qué orden**
(secuencia), **dinámicamente** (decisión en ejecución), **bucle** (iteración con
realimentación), **herramientas** (capacidad de actuar). La sexta —**cuándo parar**— es
implícita: un bucle sin criterio de terminación propio es una secuencia con contador.

El glosario añade la exclusión: *«Una declaración de rol no constituye un agente.»*

## 1.3 La rúbrica

Puntuar de 0 a 2 cada dimensión. Máximo 12.

| # | Dimensión | 0 | 1 | 2 |
|---|---|---|---|---|
| 1 | **Selección de acción** | Ejecuta acciones fijas | Elige de un catálogo cerrado y declarado | Elige de un repertorio abierto según lo que encuentra |
| 2 | **Secuencia** | El orden está escrito | Ramas predefinidas sobre condiciones conocidas | El orden se decide en ejecución |
| 3 | **Bucle con realimentación** | Una sola pasada | Reintento acotado del mismo paso | Itera leyendo su propio resultado y ajusta |
| 4 | **Herramientas** | Ninguna, solo produce texto | Solo lectura | Herramientas que cambian estado, con ámbito declarado |
| 5 | **Terminación** | Acaba al terminar la secuencia | Condición fija evaluada por el sistema | Evalúa si el objetivo se cumplió y decide parar |
| 6 | **Recuperación** | Falla o continúa igual | Camino de error predefinido | Replanifica ante lo inesperado |

## 1.4 Umbral

| Puntuación | Decisión |
|---|---|
| 0–8 | **No es un rol.** Se descompone conforme a §1.6 |
| 9–12 | **Rol**, y solo si la dimensión 4 puntúa 2 |

La rúbrica responde una sola pregunta: ¿es un rol? **No decide entre skill y corpus.** Esa
distinción no es de autonomía sino de naturaleza, y la resuelve §1.6: si hay pasos, es
skill; si hay conocimiento declarativo, es corpus. Un procedimiento excelente y nada
autónomo puntúa 4 y es una skill de primera.

**La dimensión 4 es condición necesaria, no un sumando más.** Un sistema que puntúa 10 sin
herramientas que actúen no es un agente: es un procedimiento bien escrito. MCS-OP02 lo dice
como *«y tenga catálogo de herramientas real»*.

Heredar todas las herramientas del entorno **no es un catálogo**. Es la ausencia de uno.
Puntúa 2 quien declara qué puede tocar y qué no; IA-01 lo exige por otra vía.

## 1.5 Por qué el umbral está en 9 y no en 7

Asimetría de coste, la misma lógica que MFB-G01 §3 aplica a los marcos.

Convertir una skill en rol cuando hiciera falta cuesta una tarde: ya tiene procedimiento,
solo hay que darle herramientas y bucle.

Mantener un rol que debió ser skill cuesta permanentemente. Un rol ocupa contexto en cada
sesión aunque no se invoque, no se carga bajo demanda, no se compone con otros y no se
evalúa por separado. Y aparenta competencia ante quien lo lee.

**Ante la duda, skill.**

## 1.6 Qué se hace con lo que no supera el umbral

No se descarta: se descompone. Un activo que puntúa 3 casi siempre contiene material bueno
mal empaquetado.

| Lo que contiene | Dónde va |
|---|---|
| Secuencia de pasos para lograr algo | Skill |
| Conocimiento declarativo de una materia | Corpus |
| Nombres y definiciones | Glosario canónico |
| Criterio de elección entre alternativas | Rúbrica declarada (CON-10) |
| Estructura que se rellena | Plantilla |
| Declaración de identidad, tono o personalidad | Se descarta |

La última fila es la única que se pierde, y no se pierde nada: CON-02 la prohíbe.

---

# 2. Registro de la puntuación

IA-06 exige registrar en un ADR el nivel de autonomía de cada funcionalidad. El registro
mínimo es la fila de la rúbrica más la decisión:

```
Activo: task-executor
Dimensiones (1–6): 2 · 2 · 2 · 2 · 2 · 1  = 11
Dimensión 4 = 2: sí
Decisión: ROL
Fecha: 2026-08-02 · Rúbrica: MCS-G04 v0.1.0
```

Sin la versión de la rúbrica, la puntuación no es reproducible: la rúbrica puede cambiar.

---

# 3. Antipatrones

1. **Puntuar la utilidad en vez del mecanismo.** `security-auditor` es útil y puntúa bajo.
   Son cosas distintas. La rúbrica mide autonomía, no valor.
2. **Contar como herramientas las que se heredan del entorno.** Si no está declarado el
   ámbito, la dimensión 4 puntúa 0 o 1, nunca 2.
3. **Confundir «decide qué experto invocar» con decisión dinámica.** Elegir de una tabla
   fija escrita en el propio documento es la dimensión 1 en 1, no en 2.
4. **Crear un rol para dar autoridad a un texto.** La autoridad viene de la fuente
   declarada (CON-03), no del encabezado.
5. **Puntuar sin haber leído el activo entero.** La capa de rol está siempre arriba; el
   procedimiento real suele estar en la mitad inferior del archivo.
6. **Aplicar la rúbrica y no registrar el resultado.** Incumple IA-06 y obliga a repetir el
   trabajo en la siguiente revisión.

---

# 4. Puertas de calidad

Antes de declarar un activo como rol:

- [ ] Rúbrica aplicada con las seis dimensiones puntuadas por separado
- [ ] Dimensión 4 en 2, con el ámbito de herramientas escrito
- [ ] Puntuación registrada en un ADR con la versión de la rúbrica (IA-06)
- [ ] Conjunto de evaluación previo, con umbral que condicione el despliegue (IA-07, IA-08)
- [ ] Límites de iteraciones y de coste por ejecución declarados (IA-03)
- [ ] Acciones irreversibles identificadas y sujetas a confirmación humana (IA-10)

Antes de descomponer un activo que no supera el umbral:

- [ ] Fila en la tabla de disposición con destino y justificación
- [ ] Cada naturaleza de §1.6 tiene destino asignado
- [ ] La retórica descartada no se llevó por delante ningún procedimiento

---

# 5. Tracks pendientes

| Track | Materia | Estado |
|---|---|---|
| L | Lenguaje y terminología | **No redactado.** Su contenido normativo está en el dominio LEN |
| M | Métricas | **No redactado.** Su contenido normativo está en DAT §5.7.2 |
| E | Autonomía | Este documento |
| K | Documentación viva | **No redactado.** Su contenido normativo está en DOC |

Los tres pendientes tienen requisitos vigentes en MCS-CORE. Que falte la guía no suspende
el requisito: significa que nadie ha escrito el razonamiento que lo sostiene, que es el
antipatrón 9 de MFB-G01.

# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Data analysis / reportes**

## Cliente / Contexto

- **Cliente**: [nombre]
- **Industria**: [...]
- **Pregunta de negocio a responder**:
  > "[la pregunta textual que el cliente hizo, o que estamos respondiendo]"

## Brief

**Objetivo del análisis:**
[1-2 líneas]

**Decisiones que este análisis va a informar:**
- [decisión 1 que se toma con los resultados]
- [decisión 2]

**Si no hacemos este análisis:**
[qué pasa, qué se decide a ciegas]

**Fuentes de datos:**
- [origen 1]: [formato, volumen aprox, quién da acceso]
- [origen 2]: ...

**Entregable final:**
- [ ] Dashboard interactivo (Streamlit / Plotly Dash / Metabase)
- [ ] Reporte PDF estático
- [ ] Notebook .ipynb para entregar
- [ ] Presentación (PPTX) con hallazgos
- [ ] Dataset limpio + diccionario de datos
- [ ] Combinación: [especificar]

## Stack de este proyecto

- **Procesamiento**: Pandas (default) o Polars (dataset >5M filas)
- **DB**: PostgreSQL si hay que cargar data
- **Notebooks**: Jupyter para exploración
- **Visualización**: matplotlib/seaborn (estático) o plotly (interactivo)
- **Reportes**: Quarto o Jupyter + nbconvert para PDFs pulidos
- **Dashboards**: Streamlit (rápido) / Plotly Dash (más control)

## Agentes activos en este proyecto

### Discovery
- [x] `discovery-agent`           — preguntas sobre qué decisión se toma y cómo se mide

### Core
- [x] `orquestador`
- [x] `documentador`              — CRÍTICO en análisis: asunciones, filtros aplicados, diccionario
- [x] `limpiador`                 — para notebooks, que quedan desprolijos por naturaleza
- [x] `optimizador`               — si el análisis tarda mucho o el dataset es grande

### Expertos
- [x] `data-expert`               — el protagonista
- [x] `client-reporter`           — traduce hallazgos a lenguaje del cliente
- [ ] `db-architect`              — activar si hay que modelar tablas de staging
- [ ] `backend-expert`            — NO salvo que el análisis termine siendo un endpoint
- [ ] `frontend-expert`           — solo si entregable es dashboard custom
- [ ] `devops-expert`             — NO salvo que el análisis deba correr recurrente
- [ ] `qa-expert`                 — NO (el "test" es la validación del dato)
- [ ] `security-auditor`          — activar si hay PII en los datos
- [ ] `product-analyst`           — NO
- [ ] `design-researcher`         — NO

## Estructura típica

```
proyecto/
├── data/
│   ├── raw/                  # datos originales (NO commitear si son grandes/sensibles)
│   ├── interim/              # datos en proceso
│   └── processed/            # datos finales limpios
├── notebooks/
│   ├── 01_exploracion.ipynb
│   ├── 02_limpieza.ipynb
│   ├── 03_analisis.ipynb
│   └── 04_visualizacion.ipynb
├── src/                      # si hay código reutilizable
│   ├── cleaning.py
│   └── viz.py
├── reports/
│   ├── figures/
│   └── final_report.pdf
├── data-dictionary.md        # qué es cada columna, de dónde viene, qué significa
├── assumptions.md            # supuestos que se hicieron
└── README.md
```

## Artefactos esperados

1. **Brief consolidado** (output de discovery)
2. **Diccionario de datos** — qué es cada columna, fuente, unidad, valores posibles
3. **Documento de supuestos** — qué decidimos en el limbo (ej: "nulos en fecha_venta se droppean")
4. **Notebooks limpios y ordenados** (1-exploración → 2-limpieza → 3-análisis → 4-viz)
5. **Dataset limpio final** (CSV o Parquet)
6. **Entregable final** (según brief: PDF / dashboard / PPTX)
7. **Resumen ejecutivo del cliente** (1 página, generado por `client-reporter`)

## Flujo de trabajo

```
1. discovery-agent — qué pregunta, qué decisión, qué datos
2. data-expert carga y hace EDA (exploratory data analysis)
3. data-expert propone limpieza; Claudio aprueba supuestos
4. data-expert corre análisis, genera hallazgos
5. documentador genera diccionario de datos y assumptions.md
6. data-expert arma visualizaciones
7. client-reporter genera resumen ejecutivo
8. limpiador revisa notebooks para entrega (remueve cells rotas, ordena)
9. Empaquetar entregable final
10. Entregar a Claudio para revisión; Claudio envía al cliente
```

## Reglas específicas para este tipo de proyecto

- **Siempre diccionario de datos** antes de analizar. Si no sabés qué es una columna, no la analices.
- **Siempre documentar supuestos** en `assumptions.md`. "Dropeamos nulos" es supuesto, debe estar documentado.
- **Validar row counts** en cada transformación (skill `pandas-conventions`).
- **Nunca borrar raw data.** Los `data/raw/` son sagrados. Si tocás, copiás.
- **Visualizaciones accesibles**: contrast OK, labels claros, unidades presentes.
- **El resumen ejecutivo NO tiene código ni jerga**. Es para el dueño del negocio.

## Checklist pre-entrega

- [ ] Todos los notebooks corren end-to-end desde vacío sin error
- [ ] Outputs (figuras, tablas) tienen títulos, ejes, unidades
- [ ] `data-dictionary.md` completo
- [ ] `assumptions.md` completo
- [ ] Hallazgos principales en 3-5 bullets accionables
- [ ] Resumen ejecutivo no tiene "outliers", "distribución", "correlación" — tiene frases en lenguaje normal
- [ ] Reproducibilidad: con solo `data/raw/` y el código, se genera todo lo demás

## Bitácora

- [fecha] — [decisión metodológica]

## Estado actual

- **Fase**: [Discovery / EDA / Limpieza / Análisis / Visualización / Reporte / Entregado]
- **Hallazgos preliminares**: [resumen]

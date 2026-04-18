---
name: epic-user-story-format
description: Formato intermedio de Epics, User Stories y Test Cases usado por Claudio-Enterprises. Invocar cuando se descompongan features en artefactos de producto, se trabaje en plataformas/PaaS, o se necesite documentar un backlog.
---

# Epic / User Story / Test Case — Formato Claudio

## Nivel de rigor: INTERMEDIO

- Epics = features grandes demo-eables
- User Stories = tareas accionables (1-3 días)
- Test Cases = checklist manual unívoca

No usamos INVEST formal. No usamos Given-When-Then formal. Pero seguimos estructura mínima para que no haya ambigüedad.

## IDs y numeración

```
EPIC-001
├── US-001-1
│   ├── TC-001-1-1
│   └── TC-001-1-2
└── US-001-2
    └── TC-001-2-1
```

Jamás reutilizar IDs aunque borres la historia. Los IDs son para siempre (permite referenciar en commits, PRs, Notion).

## Plantilla EPIC

```markdown
## EPIC-001: Gestión de inventario

**Objetivo de negocio:** Que FarmaX pueda ver stock actual en tiempo real sin abrir 3 sistemas.
**Métrica de éxito:** Reducir tiempo de consulta de inventario de 15 min a <1 min.
**Prioridad:** P0
**Estimación rough:** L
**Depende de:** ninguno
**Estado:** [Pending / In progress / Done]

### User Stories
- [ ] US-001-1: Ver inventario consolidado por sucursal
- [ ] US-001-2: Filtrar por categoría y stock mínimo
- [ ] US-001-3: Exportar a Excel

### Non-goals en este Epic
- NO incluye ajustes de stock (eso es otro epic)
- NO incluye alertas automáticas (fase 2)
```

## Plantilla USER STORY

```markdown
### US-001-1: Ver inventario consolidado por sucursal

**Como** encargado de operaciones,
**quiero** ver el inventario de todas las sucursales en una sola pantalla,
**para** detectar faltantes sin abrir cada sistema por separado.

**Contexto técnico:**
Endpoint GET /api/inventory con query param `?branch_id=`. Data source: ETL diario que consolida CSVs del ERP a la tabla `inventory_snapshots`.

**Criterios de aceptación:**
- CA1: Muestra por defecto todas las sucursales
- CA2: Cada fila tiene: SKU, descripción, cantidad, sucursal, última actualización
- CA3: Si el ETL no corrió hoy, muestra warning con fecha de último update
- CA4: Ordenable por cualquier columna
- CA5: Paginado de a 50 filas

**Test Cases:** TC-001-1-1 a TC-001-1-5
**Estimación:** M (1-2 días)
**Agente técnico sugerido:** backend-expert + frontend-expert
```

## Plantilla TEST CASE

```markdown
#### TC-001-1-1: Listar inventario de todas las sucursales (happy path)

**Tipo:** happy path
**Pre-condición:** Hay al menos 1 SKU en `inventory_snapshots` para 2 sucursales distintas, ETL corrió hoy.
**Pasos:**
1. Abrir /inventory sin filtros
2. Esperar carga

**Resultado esperado:**
- Status 200
- Lista muestra SKUs de ambas sucursales
- Orden por defecto: SKU ascendente
- Último update visible en encabezado
- Sin mensaje de warning

**Prioridad:** must
```

```markdown
#### TC-001-1-2: ETL desactualizado muestra warning

**Tipo:** edge case
**Pre-condición:** `inventory_snapshots.last_updated_at` es > 24hs vieja
**Pasos:**
1. Abrir /inventory
**Resultado esperado:**
- Banner amarillo: "Los datos son del [fecha]. El ETL no corrió hoy."
- Resto de la UI funciona normal

**Prioridad:** must
```

## Cuándo simplificar

Para proyectos **chicos o no-plataforma**, saltás US y vas Epic → TC directo:

```markdown
## EPIC-001: Automatización envío de reportes semanales

**Objetivo:** Cliente recibe PDF automático todos los lunes 8am con ventas de la semana pasada.

### Test Cases (acceptance)
- [ ] TC-001-1: El lunes a las 8am, el cliente recibe email con PDF adjunto
- [ ] TC-001-2: PDF contiene tabla de ventas + gráfico de barras + total
- [ ] TC-001-3: Si el ETL falla, Claudio recibe alerta por email
- [ ] TC-001-4: El email se genera correctamente aunque no haya ventas la semana pasada
```

## Priorización

- **P0 / must** — sin esto no hay MVP
- **P1 / should** — importante pero no bloquea lanzamiento
- **P2 / nice** — se hace si queda tiempo / fase 2

## Estimaciones

No usamos story points. Usamos camisetas:

| Talla | Significa | Dev real |
|---|---|---|
| XS | cambio de una línea, fix trivial | <1h |
| S | una función nueva, un endpoint simple | medio día |
| M | feature chica end-to-end | 1-2 días |
| L | feature con varias piezas | 3-5 días |
| XL | **partir en piezas más chicas** | — |

Si algo es XL, se refactoriza la US en 2-3 US más chicas antes de estimar.

## Anti-patterns

- **US que describen implementación**: "Crear tabla `inventory`" — eso es un task técnico, no US. La US es "Ver inventario".
- **TC sin pre-condición**: "pasa esto" — ¿en qué estado? No válido.
- **TC ambiguos**: "El sistema es rápido" — no medible.
- **Epics con 15 US**: están mal cortados. Dividir en 2-3 Epics.
- **US sin criterios de aceptación**: no es una US, es un deseo.

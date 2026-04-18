---
name: presentation-inspiration-lookup
description: Consulta el vault de Notion de Claudio para extraer inspiración de FORMATO de presentaciones y propuestas (layouts de slides, jerarquía visual, hooks narrativos, cierres, dashboards tipo one-pager). Distinto de `design-inspiration-lookup` (que cubre sitios y productos) y de `consultora-branding-lookup` (que cubre identidad corporativa). Invocar antes de escribir una propuesta larga, un deck, o un informe visual para cliente.
---

# Presentation Inspiration Lookup

El vault de Notion de Claudio tiene una sección dedicada a **presentaciones que le gustaron** (propias, de consultoras referentes, o externas). Esta skill describe cómo extraer ideas de FORMATO — no de branding corporativo, que es otra skill.

## Dónde viven las refs

```
📓 Notion → "Inspiración — Presentaciones"
            ├── Propuestas que cerraron deals
            ├── Decks de pitch (kickoff, venture, producto)
            ├── One-pagers ejecutivos
            ├── Reportes de cierre de proyecto
            └── Referencias externas (McKinsey, Pitch, Tome, Linear, etc.)
```

Cada página típicamente tiene:

- Screenshots de 2-5 slides clave
- Link original si aplica
- **Notas de Claudio**: qué le gustó puntualmente (hook, flow, cierre, jerarquía, balance texto/gráfico)
- Tag de **categoría** (propuesta / kickoff / reporte / one-pager)

## Qué buscar según el caso

| Tarea | Query recomendado |
|---|---|
| Escribiendo propuesta para PyME | `"propuesta pyme"`, `"cotización"`, `"SOW corto"` |
| Deck de venture / pitch | `"pitch deck"`, `"venture"`, `"seed"` |
| Reporte de cierre de sprint | `"reporte sprint"`, `"wrap-up"`, `"retrospectiva visual"` |
| One-pager ejecutivo | `"one-pager"`, `"executive summary"`, `"ficha proyecto"` |
| Dashboard narrativo para cliente | `"weekly update"`, `"cliente reporte"`, `"steering"` |

## Qué extraer (en orden de prioridad)

1. **Estructura narrativa** → cómo arranca, cómo cierra, cuántos slides/páginas.
2. **Jerarquía visual** → qué tamaño tiene el titular vs cuerpo, dónde va la CTA.
3. **Densidad** → cuántas palabras por slide, cuántos gráficos, cuánto whitespace.
4. **Hooks** → cómo despierta atención en slide 1 y cómo cierra en el último.
5. **Soporte gráfico** → qué tipo de tablas, diagramas, screenshots usa.

## Output esperado

```markdown
## Inspiración de formato — [tipo de pieza]

Refs elegidas (2-3 máximo):

1. [Nombre de la ref] — [link Notion]
   - Qué nos sirve: [1 línea]
   - Qué aplicamos: [ej: "slide 2 con problema en grande + 1 línea"]

2. [Nombre de la ref] — [link Notion]
   - Qué nos sirve: ...
   - Qué aplicamos: ...
```

## Diferencia con las otras skills de inspiración

| Skill | Cubre |
|---|---|
| `consultora-branding-lookup` | Identidad corporativa (logo, colores, tipografías, plantillas fijas) |
| `presentation-inspiration-lookup` | **FORMATO** de presentaciones (este archivo: jerarquía, narrativa, layouts) |
| `design-inspiration-lookup` | Sitios web, dashboards, productos digitales |

Si el proyecto es una propuesta/deck → necesitás **las dos primeras**: branding de la consultora + formato inspiracional.

## Reglas

- **Nunca más de 3 refs** en el brief. Más de 3 paraliza.
- **Siempre link directo** a la página de Notion.
- **Respetar el branding primero**. La inspiración de formato NO sobrescribe el brandbook de la consultora: adapta ideas dentro de ese marco.
- **Si el vault está vacío** para ese tipo de pieza → avisar a Claudio y proponer agregar 3-5 refs antes de avanzar.

## Ver también

- `consultora-branding-lookup` — antes que esta, siempre.
- `proposal-writing` — estructura del contenido textual.
- `design-inspiration-lookup` — para productos digitales, no presentaciones.

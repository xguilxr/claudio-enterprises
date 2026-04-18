---
name: design-inspiration-lookup
description: Consulta la base de datos central "Inspiración" del workspace de Notion de Claudio via `databases.query` con filtros por Asset Type, Surface, Style Tags, Library/Stack, Project context e Is Generic. Reemplaza la navegación por carpetas que había antes. Invocar cuando cualquier agente necesite referencias visuales antes de proponer UI, o código pegable para resolver un patrón concreto.
---

# Cómo consultar la DB `Inspiración` de Notion

La inspiración de diseño vive en una **base de datos central** en Notion (antes era un árbol de carpetas — migrado el 2026-04-18). Esta skill define cómo filtrarla para encontrar refs útiles.

> Changelog:
> - Migrated from folder-based lookup to database query on `Inspiración` DB (2026-04-18).

## Coordenadas del DB

- Path en Notion: `📓 Claudio-Enterprises → 💡 Inspiración → [DATABASE: Inspiración]`
- Database ID: `deae078a-ab7d-4d2a-97f9-00fdf23ddb86`
- Data source ID: `7342e2aa-a312-42d6-a8b5-39b2443ca210`
- Schema completo: ver `templates/notion-architecture.md` → sección "💡 Inspiración (Database)".

## Propiedades filtrables (resumen)

| Propiedad | Tipo | Notion filter API |
|---|---|---|
| `Asset Type` | select | `{ select: { equals: "Website" } }` |
| `Surface` | multi_select | `{ multi_select: { contains: "Hero" } }` |
| `Style Tags` | multi_select | `{ multi_select: { contains: "minimal" } }` |
| `Library / Stack` | multi_select | `{ multi_select: { contains: "GSAP" } }` |
| `Project context` | multi_select | `{ multi_select: { contains: "Integrity" } }` |
| `Is Generic` | checkbox | `{ checkbox: { equals: true } }` |
| `Priority` | select | `{ select: { equals: "Must Have" } }` |
| `Status` | select | `{ select: { equals: "Researched" } }` |
| `Technique` | rich_text | `{ rich_text: { contains: "parallax" } }` |

Valores válidos de cada propiedad: ver `notion-architecture.md` (son cerrados; si pedís un valor que no existe, la skill avisa y sugiere agregarlo al schema).

## Signatures de input que la skill acepta

Cualquier combinación de estos parámetros (todos opcionales):

| Parámetro | Tipo | Ejemplo |
|---|---|---|
| `asset_type` | single string | `"Website"` |
| `surface` | array | `["Hero", "Landing"]` |
| `style` | array | `["minimal", "dark"]` |
| `library` | array | `["Framer Motion", "GSAP"]` |
| `project` | single string | `"Integrity"` |
| `include_generic` | boolean | `true` (también trae `Is Generic = true` aunque no sea del proyecto) |
| `priority` | single string | `"Must Have"` |
| `status` | single string | `"Researched"` |
| `technique_contains` | string | `"parallax"` |
| `legacy_path` | string | `"Websites/Landing pages/"` (retrocompat) |

Si se pasa `legacy_path`, la skill lo traduce a filtros usando la tabla de mapeo en `notion-architecture.md` sección 2.3 y **avisa en el output** que se tradujo un path viejo (así Claudio migra la llamada).

## Lógica de la query

1. Construir el filtro `and` con cada parámetro provisto.
2. Si `project` y `include_generic=true`: envolver en un `or` de dos ramas:
   ```json
   {
     "or": [
       { "property": "Project context", "multi_select": { "contains": "<project>" } },
       { "property": "Is Generic", "checkbox": { "equals": true } }
     ]
   }
   ```
   Y combinar el resto de filtros con `and` sobre eso.
3. Sort: `Priority` ascendente (Must Have primero), luego `Added` descendente.
4. Paginar si hay más de 20 resultados (el default alcanza casi siempre).

### Ejemplo de body `databases.query`

Buscar animaciones de hero con GSAP para el proyecto Integrity, incluyendo librería genérica:

```json
{
  "filter": {
    "and": [
      { "property": "Asset Type", "select": { "equals": "Animation" } },
      { "property": "Surface", "multi_select": { "contains": "Hero" } },
      { "property": "Library / Stack", "multi_select": { "contains": "GSAP" } },
      {
        "or": [
          { "property": "Project context", "multi_select": { "contains": "Integrity" } },
          { "property": "Is Generic", "checkbox": { "equals": true } }
        ]
      }
    ]
  },
  "sorts": [
    { "property": "Priority", "direction": "ascending" },
    { "property": "Added", "direction": "descending" }
  ],
  "page_size": 20
}
```

## Casos de uso típicos → filtros sugeridos

| Necesidad | Filtros |
|---|---|
| Diseñar un hero de landing | `asset_type=Website`, `surface=["Hero","Landing"]`, `style=[<tono>]` |
| Portfolio de profesional creativo | `asset_type=Website`, `surface=["Portfolio Gallery"]` |
| Dashboard analítico | `asset_type=Dashboard`, `surface=["Dashboard"]` |
| Empty state para tabla vacía | `asset_type=Component`, `surface=["Empty State"]` |
| Hover lift en cards | `asset_type=Animation`, `technique_contains="hover"` |
| Parallax hero | `asset_type=Animation`, `surface=["Hero"]`, `library=["ScrollTrigger","GSAP"]` |
| Snippet React listo | `asset_type=Snippet`, `library=["React"]` |
| Librería genérica para cualquier proyecto | `include_generic=true`, sin `project` |

## Lo que la skill devuelve por cada resultado

Para cada página matcheada, extrae y devuelve:

- `title` (propiedad `Site / Source`)
- `url` (propiedad `URL`)
- `asset_type`
- `surface` (lista)
- `style_tags` (lista)
- `library` (lista)
- `project_context` (lista)
- `is_generic` (bool)
- `priority`, `difficulty`, `status`
- `technique` (texto libre — prioritario para entender qué aplica)
- `notion_page_url` (link directo a la página dentro del DB)
- `body_markdown` — opcional; solo si el caller lo pide con `include_body: true` (requiere `blocks.children.list` sobre la página)

## Fallback (CRÍTICO — no devolver vacío silencioso)

Si el resultado tiene 0 filas, la skill responde con este formato, nunca con array vacío:

```markdown
## Sin matches en la DB `Inspiración`

**Filtros usados**:
- Asset Type: <valor o "—">
- Surface: <valores o "—">
- Style Tags: <...>
- Library / Stack: <...>
- Project context: <valor o "—">
- Is Generic: <true/false/no-seteado>

**Posibles causas**:
1. No hay refs todavía para esta combinación — sugerir agregar 3-5 a la DB.
2. Algún valor no existe en el schema (ej: pasaste `"Hover"` pero `Surface` no lo tiene todavía como opción).
3. Los filtros son demasiado restrictivos — proponer cuál soltar.

**Recomendación**:
- Si el proyecto es nuevo, verificar que `<proyecto>` esté en la propiedad `Project context` (si no, agregarlo al schema).
- Si es un tipo de pieza poco cubierto, decidir con Claudio si vale la pena agregar refs o seguir con defaults del `STYLE.md`.
```

**Nunca** la skill inventa refs que no estén en la DB. Nunca.

## Retrocompat con paths viejos

Si el caller pasa `legacy_path="Websites/Landing pages/"` (u otro de la tabla 2.3 de `notion-architecture.md`), la skill:

1. Resuelve el path a filtros según esa tabla.
2. Ejecuta la query con esos filtros.
3. **Incluye una nota en el output**: `"Traduje legacy_path='Websites/Landing pages/' a Asset Type=Website + Surface contains 'Landing'. Actualizá el caller para pasar filtros directos."`

Casos de ambigüedad en la tabla (resueltos pero marcados con `approx` en el doc):
- `Websites/E-commerce/` → por ahora `Surface contains "Pricing"`. Si aparecen varios e-commerce, agregar valor `E-commerce` a `Surface`.
- `Animaciones/Hover / micro-interactions/` → `Technique contains "hover"`. Podría promoverse a valor `Hover` en `Surface` si se vuelve recurrente.

## Output ideal (cuando hay matches)

Un moodboard en Markdown con:
- Links directos a las páginas de Notion (URL del bloque en el DB).
- Descripción breve de por qué cada ref importa (de `technique`).
- Elementos extraídos listos para pasar a `frontend-expert`.
- **Snippets listos para pegar** con sus dependencias (cuando `Asset Type = Snippet`).

Ver el agente `design-researcher` para el formato completo del moodboard.

## Cuántas refs devolver

- **Sitio chico** (portfolio 1-page): 3 refs.
- **Sitio mediano** (multi-page): 5-7 refs, algunas específicas por sección.
- **Plataforma / dashboard**: 4-6 refs, priorizando `Asset Type = Dashboard`.
- **Una animación específica**: 1-2 refs + 1 snippet si hay.
- **Pattern común** (ej: card hover, empty state): 1 ref + 1 snippet basta.

Aplicá siempre el `page_size` acorde + `sorts` de prioridad.

## Relación con otras skills

| Skill | Cubre |
|---|---|
| `design-inspiration-lookup` (esta) | Inspiración **visual y código** en la DB `Inspiración` |
| `presentation-inspiration-lookup` | Inspiración de formato de slides/propuestas (subpáginas bajo `🎨 Branding de Consultoras`) |
| `consultora-branding-lookup` | Branding de consultoras socias (identidad corporativa) |
| `prospect-branding-lookup` | Research de prospectos (sitio actual + competidores + inspiración del rubro) |

## Reglas

- **Nunca inventar colores ni tipografías** que no salgan de una ref concreta (propiedades de la DB o body de la página) o del `STYLE.md` del proyecto.
- **Siempre link** a la página de Notion origen (URL del bloque dentro del DB).
- **Respetar STYLE.md y brandbook del cliente** por encima de la inspiración. Si la ref propone una paleta distinta, se toma layout/animación y se ajusta paleta al marco del proyecto.
- **Considerar accesibilidad**: si una ref tiene bajo contraste, se toma como inspiración pero se ajusta al exportar.
- **No más de 7 refs** en un moodboard (Claudio no decide con más).
- **Para snippets**, verificar que las deps (`Library / Stack`) sean compatibles con el stack del proyecto antes de proponerlos.
- **Fallback obligatorio**: 0 resultados nunca se devuelve silencioso. Explicar filtros + causas + recomendación.
- **Si falta un valor en el schema** (ej: un prospecto nuevo no está en `Project context`), avisar a Claudio y pedir que lo agregue antes de volver a correr la query. No filtrar "a mano" ni usar otro valor aproximado.

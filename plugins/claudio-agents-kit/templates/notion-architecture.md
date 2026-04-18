# Notion — Arquitectura recomendada para Claudio-Enterprises

Este doc describe cómo organizar el workspace de Notion de Claudio para que las skills del plugin (`consultora-branding-lookup`, `prospect-branding-lookup`, `design-inspiration-lookup`, `presentation-inspiration-lookup`) encuentren lo que buscan sin adivinar.

> **Cambio mayor (2026-04-18)**: `💡 Inspiración` dejó de ser un árbol de carpetas y ahora es una **base de datos central de Notion**. Los skills consultan la DB por propiedades, no navegan subpáginas. `📊 Proyectos` se eliminó como raíz (el trabajo por proyecto vive dentro del prospecto). `🧾 Inspiración — Presentaciones` se mudó bajo `🎨 Branding de Consultoras`.

---

## Workspace root

```
📓 Claudio-Enterprises
├── 🎨 Branding de Consultoras
│   ├── Consultoras socias
│   ├── Prospectos
│   └── Inspiración — Presentaciones
└── 💡 Inspiración
    └── [DATABASE: Inspiración]
```

Solo dos raíces. Todo lo demás cuelga de una de estas dos.

---

## 1. 🎨 Branding de Consultoras

Centraliza TODO lo necesario para homogeneizar artefactos de propuestas y documentación oficial.

```
🎨 Branding de Consultoras
├── Consultoras socias
│   ├── _Template Consultora
│   ├── Claudio-Enterprises            ← tu propia identidad
│   └── <Consultora A>
├── Prospectos
│   ├── _Template Prospecto
│   ├── <Cliente X>
│   │   ├── Current Site — <dominio>
│   │   ├── Competitor — <Nombre 1>
│   │   ├── Competitor — <Nombre 2>
│   │   ├── Inspiration — <Nombre>   (opcional, refs específicas del rubro)
│   │   └── Redesign Proposal & Demo
│   └── <Cliente Y>
│       └── ...
└── Inspiración — Presentaciones
    ├── Propuestas que cerraron deals
    ├── Decks de pitch
    ├── One-pagers ejecutivos
    ├── Reportes de cierre
    └── Referencias externas
```

### 1.1 Consultoras socias — estructura de cada subpágina

Cada consultora (incluso Claudio-Enterprises como tu propia marca) tiene esta estructura uniforme. La página `_Template Consultora` es la plantilla vacía que se duplica al agregar una consultora nueva.

```
<Nombre Consultora>
├── 📎 Logos (SVG + PNG light/dark + isotipo)
├── 🎨 Paleta (primario, secundario, neutros, semánticos — HEX + uso)
├── 🔤 Tipografías (titulares, cuerpo, monospace)
├── 📄 Especificaciones de documentos (plantillas Word, PPT, GDoc, GSlides)
├── ✍️ Firma y footer (texto exacto, mail comercial, disclaimer)
├── 🎯 Idioma y tono (formal/cercano/técnico, ES/EN, ejemplos de copy)
└── 📝 Notas (historia de cambios, do/don't visuales)
```

**Tags recomendados en la página raíz de cada consultora:**
- `estado`: `activa` / `pausada` / `archivada`
- `modalidad`: `socia-frecuente` / `socia-ocasional` / `solo-referencia`

### 1.2 Prospectos — research de clientes potenciales

Sección flexible. Cada prospecto es una página con subpáginas arbitrarias según lo que haya: sitio actual, competidores, referencias del rubro, propuesta. La página `_Template Prospecto` es el esqueleto recomendado.

**Subpáginas típicas dentro de cada prospecto:**

| Subpágina | Qué contiene |
|---|---|
| `Current Site — <dominio>` | Captura y análisis del sitio actual del prospecto (lo que ellos tienen hoy) |
| `Competitor — <Nombre>` | Sitio de un competidor directo o indirecto. Una subpágina por competidor. |
| `Inspiration — <Nombre>` | Referencia del rubro que no es competidor pero inspira (opcional) |
| `Redesign Proposal & Demo` | Propuesta concreta para este prospecto (links, decks, mockups) |
| Otras | Claudio puede agregar sub-research libre bajo `🔍 Research adicional` |

**Tags de completitud en la página raíz del prospecto:**
- `solo-nombre` — solo conocés el nombre
- `con-website` — tenés URL para research visual
- `con-brief-inicial` — ya hubo llamada y hay notas
- `con-propuesta-enviada` — propuesta ya fue
- `cerrado-ganado` / `cerrado-perdido` / `archivado`

La skill `prospect-branding-lookup` recorre las subpáginas del prospecto **recursivamente, sin asumir un schema fijo** — se adapta a lo que haya. Los tags solo indican completitud general; las subpáginas son el contenido.

**Por qué todo el research del prospecto vive bajo el prospecto y no disperso**: al armar una propuesta necesitás contexto + competidores + inspiración del rubro juntos. Si está disperso, se pierde la unidad narrativa.

### 1.3 Inspiración — Presentaciones

Refs de **formato** de propuestas/decks/one-pagers. Vive bajo `🎨 Branding de Consultoras` porque el formato de presentación es parte del toolkit comercial (no inspiración de diseño digital).

```
Inspiración — Presentaciones
├── Propuestas que cerraron deals
├── Decks de pitch
├── One-pagers ejecutivos
├── Reportes de cierre
└── Referencias externas (McKinsey, Pitch, Tome, Linear, etc.)
```

Cada página: screenshots de 2-5 slides clave + link original + notas de Claudio + tag de categoría. La consulta es por navegación (no DB).

---

## 2. 💡 Inspiración (Database)

El corazón del research visual. **Es una sola base de datos de Notion**, no un árbol de carpetas. Los skills filtran por propiedades para encontrar refs.

**Ubicación**: `📓 Claudio-Enterprises → 💡 Inspiración → [DATABASE: Inspiración]`

**IDs (para API de Notion):**
- Database ID: `deae078a-ab7d-4d2a-97f9-00fdf23ddb86`
- Data source (collection) ID: `7342e2aa-a312-42d6-a8b5-39b2443ca210`

### 2.1 Schema

| Propiedad | Tipo | Valores |
|---|---|---|
| `Site / Source` | `title` | free text |
| `URL` | `url` | — |
| `Asset Type` | `select` | `Website`, `Animation`, `Component`, `Snippet`, `Dashboard`, `Presentation` |
| `Surface` | `multi_select` | `Hero`, `Portfolio Gallery`, `Landing`, `Dashboard`, `Form`, `Navigation`, `Magazine`, `Video Page`, `About`, `Contact`, `Pricing`, `Empty State`, `Settings / Profile`, `Tables / Data Grid`, `Sitewide` |
| `Style Tags` | `multi_select` | `minimal`, `brutalist`, `editorial`, `playful`, `dark`, `serif`, `maximal`, `monochrome`, `colorful`, `corporate`, `experimental` |
| `Library / Stack` | `multi_select` | `GSAP`, `ScrollTrigger`, `Framer Motion`, `Lenis`, `Three.js`, `CSS Only`, `Tailwind`, `TanStack Query`, `TanStack Table`, `React`, `Astro`, `Custom JS`, `Nuxt`, `Framer`, `Barba.js`, `Locomotive Scroll`, `Swup`, `react-spring`, `Lottie` |
| `Project context` | `multi_select` | `Shutterexx`, `Integrity`, `DG`, `Claudio-Enterprises` (agregar nuevos valores cuando aparezca un prospecto nuevo) |
| `Is Generic` | `checkbox` | `true` = reusable cross-project (library base) |
| `Priority` | `select` | `Must Have`, `Nice to Have`, `Explore Later` |
| `Difficulty` | `select` | `Easy`, `Medium`, `Complex` |
| `Status` | `select` | `Researched`, `Code Extracted`, `Prototyped`, `Implemented`, `Rejected` |
| `Technique` | `rich_text` | descripción libre de qué se encontró |
| `Added` | `created_time` | auto |

### 2.2 Views existentes

Creadas manualmente en la UI de Notion:
- `All` — todo sin filtro
- `By Asset Type` — agrupado por `Asset Type`
- `By Surface` — agrupado por `Surface`
- `By Project` — agrupado por `Project context`
- `Must-Haves only` — `Priority = Must Have`
- `Generic library` — `Is Generic = true`

Los skills no crean ni modifican views; solo leen la DB via API con filtros explícitos.

### 2.3 Mapeo del layout viejo (carpetas) al nuevo (filtros)

Cuando una skill o un flujo viejo pase un path tipo `Websites/Landing pages/`, se traduce a filtros así:

| Path viejo | Filtro equivalente |
|---|---|
| `Websites/Landing pages/` | `Asset Type = Website` AND `Surface contains "Landing"` |
| `Websites/Portfolio sites/` | `Asset Type = Website` AND `Surface contains "Portfolio Gallery"` |
| `Websites/Corporate / about/` | `Asset Type = Website` AND `Surface contains "About"` |
| `Websites/E-commerce/` | `Asset Type = Website` AND `Surface contains "Pricing"` (approx — agregar valor `E-commerce` a `Surface` si aparece recurrente) |
| `Websites/Editorial / blog/` | `Asset Type = Website` AND `Style Tags contains "editorial"` |
| `Animaciones/Scroll-triggered/` | `Asset Type = Animation` AND `Library / Stack contains "ScrollTrigger"` |
| `Animaciones/Hover / micro-interactions/` | `Asset Type = Animation` AND `Technique contains "hover"` (approx — considerar agregar `Hover` a `Surface`) |
| `Animaciones/Page transitions/` | `Asset Type = Animation` AND `Library / Stack contains "Barba.js"` OR `"Swup"` |
| `Animaciones/Loaders / skeletons/` | `Asset Type = Animation` AND `Technique contains "loader"` OR `"skeleton"` |
| `Animaciones/Hero reveals/` | `Asset Type = Animation` AND `Surface contains "Hero"` |
| `SaaS styling/Dashboards/` | `Asset Type = Dashboard` AND `Surface contains "Dashboard"` |
| `SaaS styling/Tables / data grids/` | `Asset Type = Component` AND `Surface contains "Tables / Data Grid"` |
| `SaaS styling/Forms/` | `Asset Type = Component` AND `Surface contains "Form"` |
| `SaaS styling/Settings / profile/` | `Asset Type = Component` AND `Surface contains "Settings / Profile"` |
| `SaaS styling/Empty states/` | `Asset Type = Component` AND `Surface contains "Empty State"` |
| `SaaS styling/Pricing pages/` | `Asset Type = Website` AND `Surface contains "Pricing"` |
| `Snippets/` | `Asset Type = Snippet` |

### 2.4 Inspiration Vault (legacy)

La subpágina `Inspiration Vault` dentro de `Shutterexx — Portfolio Build` es legacy. Sus 6 filas se migraron a la DB central con `Project context = Shutterexx`, `Is Generic = false`. **No leas desde el Vault viejo** — queda ahí solo como backup histórico hasta deprecar.

---

## Clasificación de extracciones desde websites

Cuando Claudio lee un sitio con Claude Chrome (u otra herramienta de browsing) y decide guardarlo, **cada extracción se clasifica en uno de dos tipos** antes de escribir en Notion:

| Tipo | Destino | Cuándo aplica |
|---|---|---|
| `inspiration` | Nueva fila en el DB `💡 Inspiración` (con `Project context` según aplique + `Is Generic` si es reusable) | El sitio te gusta estéticamente o resuelve un patrón bien. Se guarda como ref buscable por propiedades. |
| `competitor-research` | Subpágina `Competitor — <Nombre>` dentro de `🎨 Branding de Consultoras → Prospectos → <Cliente>` | El sitio es de un competidor directo o indirecto de un prospecto concreto. Se guarda atado a ese prospecto para posicionar su propuesta. |

El prompt [`chrome-site-classification-prompt.md`](./chrome-site-classification-prompt.md) automatiza esta decisión: al leer una página, pregunta a Claudio cómo clasificarla y genera el payload adecuado (fila de DB para inspiration, bloque Markdown para subpágina de prospecto en competitor-research).

Regla: **si dudás, es `inspiration` con `Is Generic = true`**. Se puede re-etiquetar (cambiar `Project context` o desmarcar `Is Generic`) mucho más fácil que reubicar una subpágina.

---

## Cómo las skills del plugin usan esta estructura

| Skill | Fuente | Mecanismo |
|---|---|---|
| `consultora-branding-lookup` | `🎨 Branding de Consultoras → Consultoras socias → <nombre>` | Navegación de subpágina (MCP Notion) |
| `prospect-branding-lookup` | `🎨 Branding de Consultoras → Prospectos → <cliente>` | Navegación recursiva de subpáginas (sin schema fijo) |
| `design-inspiration-lookup` | DB `💡 Inspiración` | `databases.query` con filtros por `Asset Type`, `Surface`, `Style Tags`, `Library / Stack`, `Project context`, `Is Generic` |
| `presentation-inspiration-lookup` | `🎨 Branding de Consultoras → Inspiración — Presentaciones → <categoría>` | Navegación de subpágina |

Si alguna skill no encuentra lo que busca, **avisa explícitamente** qué filtros/path usó y sugiere cómo arreglar (agregar a la DB, crear la página del prospecto, ampliar filtros, etc.). Nunca devuelve vacío silenciosamente ni inventa refs.

---

## Mantenimiento mínimo

- **Al arrancar un proyecto nuevo**: agregar el valor del prospecto a la propiedad `Project context` de la DB (si no existe), y crear su página en `Prospectos` con `_Template Prospecto` como base.
- **Al ver algo visual que te gusta**: 2 min para agregarlo a la DB `💡 Inspiración` con `Asset Type`, 1-2 valores de `Surface`, 1-2 `Style Tags` y `Project context` (o `Is Generic = true` si es librería reusable). No postergues.
- **Al cerrar un proyecto (cerrado-ganado)**: mover refs del prospecto que valgan cross-project a la DB central con `Is Generic = true`.
- **Cada 3 meses**: pasada de limpieza — archivar prospectos cerrados-perdidos, marcar como `Status = Rejected` en la DB las refs que dejaron de gustarte, revisar vigencia de brandbooks de consultoras.

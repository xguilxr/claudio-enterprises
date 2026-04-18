---
name: design-inspiration-lookup
description: Estrategia para consultar la sección centralizada "💡 Inspiración" del workspace de Notion de Claudio (Websites / Animaciones / SaaS styling / Snippets). Invocar cuando cualquier agente necesite referencias visuales antes de proponer UI, o código pegable para resolver un patrón concreto.
---

# Cómo consultar la Inspiración de Notion

El vault está organizado de forma **centralizada por tipo de pieza**, no por proyecto (ver `templates/notion-architecture.md` del plugin). Una ref vive en un solo lugar y los proyectos la linkean.

```
💡 Inspiración
├── Websites         ← páginas completas (landing, portfolio, corporate, e-commerce, editorial)
├── Animaciones      ← micro-interacciones, scroll, transitions, loaders
├── SaaS styling     ← dashboards, tables, forms, settings, empty states, pricing
└── Snippets         ← código pegable, taggeado por framework
```

## Decidí primero QUÉ buscás

| Necesidad | Subsección | Búsqueda típica |
|---|---|---|
| "Diseñar un hero de landing" | Websites → Landing pages | `hero`, tag tono |
| "Portfolio de profesional creativo" | Websites → Portfolio sites | `portfolio`, tag tono |
| "Dashboard analítico" | SaaS styling → Dashboards | `dashboard`, `analytics` |
| "Empty state para tabla vacía" | SaaS styling → Empty states | `empty`, `blank state` |
| "Hover lift en cards" | Animaciones → Hover / micro | `hover`, `card` |
| "Parallax hero" | Animaciones → Scroll-triggered | `parallax`, `hero-scroll` |
| "Un snippet React listo" | Snippets | tag de framework + tipo |

## Búsqueda dentro de cada subsección

### Websites / SaaS styling
Buscar por combinación de tipo de pieza + tono:
```
query: "landing minimal"
query: "dashboard dark"
query: "pricing editorial"
query: "portfolio brutalist"
```

Tags que Claudio usa: `minimal`, `brutalist`, `editorial`, `playful`, `dark`, `serif-elegant`, `glassmorphism`, `playful-illustrated`, `dark-corporate`.

### Animaciones
Buscar por **mecánica** + **lib**:
```
query: "scroll parallax framer"
query: "page transition gsap"
query: "loader skeleton css"
query: "hover lift framer-motion"
```

Tags de tecnología: `framer-motion`, `gsap`, `lottie`, `css-only`, `react-spring`.

### Snippets
Buscar por **framework + tipo**:
```
query: "react hero"
query: "tailwind card"
query: "tanstack table sort"
query: "framer-motion scroll-reveal"
query: "astro image"
```

Tags de framework: `react`, `astro`, `next`, `vue`, `tailwind`, `framer-motion`, `gsap`, `tanstack-query`, `tanstack-table`, `vanilla-css`.
Tags de tipo: `component`, `hook`, `animation`, `layout`, `pattern`.

## Cómo extraer valor de una página

### Si es Website / SaaS styling
1. Screenshot full-page (referencia visual directa).
2. URL del sitio original.
3. **Notas de Claudio** (prioridad alta — ese es el filtro de "taste").
4. Tags (tono + tipo de pieza).
5. Paletas si hay.

### Si es Animación
1. GIF o video corto (lo más importante).
2. URL original.
3. Lib identificada (framer-motion / gsap / etc.).
4. Notas de Claudio sobre por qué le gustó.

### Si es Snippet
1. **Código** — es el deliverable.
2. Screenshot del resultado visual.
3. Dependencias requeridas (`framer-motion@^11`, `@tanstack/react-table@^8`).
4. Notas / gotchas (ej: "requiere `prefers-reduced-motion` wrap").
5. Link al original (si es adaptado de un autor externo).

## Cuántas refs usar

- **Sitio chico** (portfolio 1-page): 3 refs.
- **Sitio mediano** (multi-page): 5-7 refs, algunas específicas por sección.
- **Plataforma / dashboard**: 4-6 refs, priorizando dashboards reales (no landings).
- **Una animación específica**: 1-2 refs + 1 snippet si hay.
- **Pattern común** (ej: card hover, empty state): 1 ref + 1 snippet es suficiente.

## Output ideal

Un moodboard en Markdown con:
- Links directos a las páginas de Notion (abribles por Claudio).
- Descripción breve de por qué cada ref importa.
- Elementos extraídos listos para pasar a frontend-expert.
- **Snippets listos para pegar** con sus dependencias.

Ver el agente `design-researcher` para el formato completo.

## Qué hacer si la Inspiración no tiene refs para este caso

1. Avisar a Claudio: "no hay refs guardadas en `<subsección>` para `<tipo>`".
2. Sugerir que dedique 15 min a agregar 3-5 refs al vault (Dribbble, Awwwards, Godly, Mobbin, Page Flows, o sitios que le hayan gustado recientemente).
3. Alternativamente, ir con los defaults del `STYLE.md` del proyecto — no es bloqueante, pero la curaduría es más pobre.

## Relación con otras skills

| Skill | Cubre |
|---|---|
| `design-inspiration-lookup` (esta) | Inspiración **visual y código** para sitios/productos |
| `presentation-inspiration-lookup` | Inspiración de formato de slides/propuestas |
| `consultora-branding-lookup` | Branding de consultoras socias (identidad corporativa) |
| `prospect-branding-lookup` | Research de branding de clientes potenciales |

## Reglas

- **Nunca inventar colores ni tipografías** que no salgan de una ref concreta o del STYLE.md del proyecto.
- **Siempre link** a la página de Notion origen.
- **Respetar STYLE.md y brandbook del cliente** por encima de la inspiración. Si la ref propone una paleta distinta, se toma layout/animación y se ajusta paleta al marco del proyecto.
- **Considerar accesibilidad**: si una ref tiene bajo contraste, se toma como inspiración pero se ajusta al exportar.
- **No más de 7 refs** en un moodboard (Claudio no decide con más).
- **Para snippets**, verificar que las deps sean compatibles con el stack del proyecto antes de proponerlos.

# Notion — Arquitectura recomendada para Claudio-Enterprises

Este doc describe cómo organizar el workspace de Notion de Claudio para que las skills del plugin (`consultora-branding-lookup`, `prospect-branding-lookup`, `design-inspiration-lookup`, `presentation-inspiration-lookup`) encuentren lo que buscan sin adivinar.

> **Side gig**: el objetivo es que Claudio dedique poco tiempo a mantenimiento de Notion pero que cualquier propuesta o proyecto arranque con assets listos para usar.

## Workspace root

```
📓 Claudio-Enterprises
├── 🎨 Branding de Consultoras
├── 💡 Inspiración
├── 🧾 Inspiración — Presentaciones
└── 📊 Proyectos
```

---

## 1. 🎨 Branding de Consultoras

Centraliza TODO lo necesario para homogeneizar artefactos de propuestas y documentación oficial.

```
🎨 Branding de Consultoras
├── Consultoras socias
│   ├── Claudio-Enterprises            ← tu propia identidad
│   ├── <Consultora A>
│   ├── <Consultora B>
│   └── ...
└── Prospectos
    ├── <Cliente X>
    ├── <Cliente Y>
    └── ...
```

### 1.1 Consultoras socias — estructura de cada subpágina

Cada consultora (incluso Claudio-Enterprises como tu propia marca) tiene esta estructura uniforme:

```
<Nombre Consultora>
├── 📎 Logos
│   ├── Logo principal (SVG)
│   ├── Logo principal (PNG light)
│   ├── Logo principal (PNG dark)
│   ├── Isotipo solo
│   └── Logo en fondo oscuro
├── 🎨 Paleta
│   ├── Primario (HEX, uso: CTA, headers)
│   ├── Secundario (HEX, uso: acento)
│   ├── Neutros (HEX x 3-5, uso: fondo, texto, borders)
│   └── Semánticos (éxito, error, warning)
├── 🔤 Tipografías
│   ├── Titulares (familia + weight + tamaño recomendado)
│   ├── Cuerpo (familia + weight + line-height)
│   └── Monospace (si aplica)
├── 📄 Especificaciones de documentos
│   ├── Plantilla Word (.docx adjunto)
│   ├── Plantilla PowerPoint (.pptx adjunto)
│   ├── Plantilla Google Docs (link)
│   ├── Plantilla Google Slides (link)
│   └── Márgenes / grillas / layout base
├── ✍️ Firma y footer
│   ├── Texto exacto que va al pie
│   ├── Mail del contacto comercial
│   └── Disclaimer legal si aplica
├── 🎯 Idioma y tono
│   ├── Formal / cercano / técnico
│   ├── Español / inglés / bilingüe
│   └── Ejemplos de copy (hook, cierre)
└── 📝 Notas
    ├── Historia del cambio de brandbook
    └── Do / Don't visuales
```

**Tags recomendados en la página raíz de cada consultora:**
- `estado`: `activa` / `pausada` / `archivada`
- `modalidad`: `socia-frecuente` / `socia-ocasional` / `solo-referencia`

### 1.2 Prospectos — research de clientes potenciales

Sección flexible. A veces solo tenés el nombre, a veces el website, a veces ya hiciste un brief. Se maneja con **tags de completitud**.

```
Prospectos
├── <Cliente X>  [tag: solo-nombre]
├── <Cliente Y>  [tag: con-website, con-brief-inicial]
└── <Cliente Z>  [tag: con-website, con-propuesta-enviada]
```

**Estructura esperada de cada prospecto** (rellená solo lo que tengas):

```
<Cliente>
├── 🌐 Website (URL)
├── 🎨 Branding detectado del website (si hay scraping/manual)
│   ├── Colores dominantes
│   ├── Tipografías visibles
│   └── Tono (formal / juvenil / técnico / etc.)
├── 🏢 Industria
├── 📝 Notas del discovery (si ya hablaste)
├── 💰 Budget percibido
└── 📎 Propuesta enviada (link si ya mandaste)
```

**Tags útiles:**
- `solo-nombre` — únicamente sabés cómo se llaman
- `con-website` — tenés URL para research visual
- `con-brief-inicial` — ya hubo llamada y hay notas
- `con-propuesta-enviada` — propuesta ya fue
- `cerrado-ganado` / `cerrado-perdido` — outcome
- `archivado` — no tracking activo

Las skills (`prospect-branding-lookup`) usan estos tags para decidir qué pueden extraer: si solo hay nombre, preguntan a Claudio; si hay website, scrapean colores/fonts.

---

## 2. 💡 Inspiración

Referencias visuales para websites y frontends. Centralizado (antes vivía disperso dentro de cada proyecto).

```
💡 Inspiración
├── Websites
├── Animaciones
├── SaaS styling
└── Snippets
```

### 2.1 Websites

Páginas completas que te gustan. Organizadas por **tipo de pieza** (no por proyecto).

```
Websites
├── Landing pages
├── Portfolio sites
├── Corporate / about
├── E-commerce
└── Editorial / blog
```

Cada página:
- Screenshot full-page
- URL
- Notas de Claudio ("qué me gusta puntualmente")
- Tags: `minimal`, `brutalist`, `editorial`, `playful`, `dark`, `serif`, etc.

### 2.2 Animaciones

Micro-interacciones, transiciones, scroll effects, loaders, hover states.

```
Animaciones
├── Scroll-triggered
├── Hover / micro-interactions
├── Page transitions
├── Loaders / skeletons
└── Hero reveals
```

Cada página:
- GIF o video corto
- URL original
- Tag de tecnología: `framer-motion`, `gsap`, `lottie`, `css-only`, `react-spring`

### 2.3 SaaS styling

Componentes de producto (dashboards, tablas, forms, settings) que funcionan bien.

```
SaaS styling
├── Dashboards
├── Tables / data grids
├── Forms
├── Settings / profile
├── Empty states
└── Pricing pages
```

### 2.4 Snippets

Fragmentos de código pegables. **Taggeados por framework.**

```
Snippets
├── <Snippet 1: Hero parallax con Framer Motion>
├── <Snippet 2: Table con sort + filter TanStack>
├── <Snippet 3: Card hover lift CSS only>
└── ...
```

Cada snippet:
- Código en bloque (copiable)
- Screenshot o demo
- Tag de framework/lib: `react`, `tailwind`, `framer-motion`, `gsap`, `astro`, `vanilla-css`, `tanstack-query`, `tanstack-table`
- Tag de tipo: `component`, `hook`, `animation`, `layout`, `pattern`
- Dependencias requeridas
- Notas de uso / gotchas

---

## 3. 🧾 Inspiración — Presentaciones

(Esta sección ya existe según la skill `presentation-inspiration-lookup`.)

```
🧾 Inspiración — Presentaciones
├── Propuestas que cerraron deals
├── Decks de pitch
├── One-pagers ejecutivos
├── Reportes de cierre
└── Referencias externas
```

---

## 4. 📊 Proyectos

Las páginas que ya tenés por proyecto siguen existiendo, pero **sin duplicar inspiración**: si una ref visual aplica al proyecto, se linkea desde Proyectos → `[link]` a la página en `Inspiración`. No se pega la imagen dos veces.

```
📊 Proyectos
├── <proyecto-1>
│   ├── Brief
│   ├── Referencias usadas → links a 💡 Inspiración
│   ├── Moodboard (curaduría específica del proyecto)
│   └── Decisiones visuales tomadas
└── <proyecto-2>
```

---

## Migración desde la estructura actual

1. Crear las 4 páginas raíz nuevas.
2. Por cada proyecto existente, recorrer las refs que tengas adentro:
   - Moverlas a `💡 Inspiración → <subsección correcta>`.
   - Dejar un link en `📊 Proyectos → <proyecto> → Referencias usadas`.
3. Unificar branding: si alguna consultora tenía assets desperdigados, moverlos a `🎨 Branding de Consultoras`.
4. Crear `Claudio-Enterprises` como una "consultora" más (es tu default cuando no hay socio).

Esto toma ~1h si son 5-10 proyectos. Peor en backlog, mejor que seguir disperso.

---

## Cómo las skills del plugin usan esta estructura

| Skill | Lee de |
|---|---|
| `consultora-branding-lookup` | `🎨 Branding de Consultoras → Consultoras socias → <nombre>` |
| `prospect-branding-lookup` | `🎨 Branding de Consultoras → Prospectos → <cliente>` (flexible según tags) |
| `design-inspiration-lookup` | `💡 Inspiración → Websites / Animaciones / SaaS styling / Snippets` |
| `presentation-inspiration-lookup` | `🧾 Inspiración — Presentaciones → <categoría>` |

Si alguna skill no encuentra la ruta (ej: falta la consultora pedida), avisa explícitamente y pide a Claudio que la cree antes de avanzar.

---

## Mantenimiento mínimo

- **Al arrancar un proyecto**: 5 min para confirmar que la consultora y el cliente están en Notion (crear si faltan).
- **Al ver algo visual que te gusta**: 2 min para guardarlo en `💡 Inspiración` con 2-3 tags. No postergues.
- **Al cerrar un proyecto**: mover refs útiles del proyecto a Inspiración (si todavía no estaban ahí).
- **Cada 3 meses**: pasada de limpieza — archivar prospectos cerrados-perdidos, revisar que brandbooks de consultoras estén vigentes.

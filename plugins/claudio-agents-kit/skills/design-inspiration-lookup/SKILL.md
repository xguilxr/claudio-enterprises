---
name: design-inspiration-lookup
description: Estrategia para consultar el vault de Notion de Claudio (organizado por proyecto/referencia) y extraer inspiración visual. Invocar cuando cualquier agente necesite referencias de diseño antes de proponer UI.
---

# Cómo consultar el vault de Notion de Claudio

El vault está organizado **por proyecto/referencia**, no por tipo de recurso. Es decir: una página por cliente o por sitio-que-me-gustó, dentro cada uno tiene screenshots, notas, paletas, links.

Esto significa que no podés buscar "tipografías serif" y encontrar una página con 50 tipografías. Tenés que buscar por **proyecto-con-ese-tipo-de-diseño** y extraer la tipografía de ahí.

## Queries recomendadas (con el conector Notion MCP)

### Búsqueda 1 — Por tipo de pieza
```
query: "landing page"
query: "portfolio site"
query: "dashboard"
query: "pricing"
query: "hero section"
```

### Búsqueda 2 — Por estética/tono
```
query: "editorial minimalist"
query: "brutalist"
query: "playful illustrated"
query: "dark corporate"
query: "serif elegant"
query: "glassmorphism"
```

### Búsqueda 3 — Por industria cliente
Si el brief menciona "cliente farmacéutico", buscás:
```
query: "farma" (proyectos anteriores tuyos)
query: "pharmacy" (referencias externas)
query: "healthcare" / "salud"
```

### Búsqueda 4 — Por tecnología de animación
```
query: "framer motion"
query: "gsap"
query: "lottie"
query: "parallax"
```

## Cómo extraer valor de una página de Notion

Cada página de inspiración típicamente tiene:

1. **Screenshots o embeds** — la referencia visual directa
2. **URL del sitio original** — para que Claudio pueda abrir y ver live
3. **Notas de Claudio** — qué le gustó específicamente (muy importante, ese es el filtro de "taste")
4. **Paletas guardadas** — a veces como text, a veces como bloques de color

Extraé en este orden de prioridad:
1. Las notas de Claudio (qué le llamó la atención)
2. Los colores dominantes (si los mencionó)
3. El layout (estructura de secciones)
4. Movimiento/animación (si hay video o gif)

## Cómo decidir cuántas referencias usar

- **Para un sitio chico** (portfolio 1-page): 3 refs es suficiente
- **Para un sitio mediano** (multi-página): 5-7 refs, algunas específicas por sección
- **Para una plataforma/dashboard**: 4-6 refs, priorizando dashboards reales, no landings

## Output ideal

Un moodboard en Markdown con:
- Links directos a las páginas de Notion (que Claudio pueda abrir)
- Descripción breve de por qué esa ref importa
- Elementos extraídos listos para pasar al frontend

Ver el agente `design-researcher` para el formato completo.

## Qué hacer si el vault no tiene refs para el proyecto

1. Avisá a Claudio que no hay refs guardadas para ese tipo de pieza.
2. Sugerí que antes de arrancar agregue 3-5 refs al vault (pasará 15 minutos pero salva horas de iteración).
3. Si no hay tiempo, proponé buscar en Dribbble/Awwwards/Godly por keyword y que Claudio elija 3 que le gusten — se suman al vault antes de diseñar.

## Reglas

- **Nunca inventar colores ni tipografías** que no salgan de una ref concreta del vault.
- **Siempre link** a la página de Notion origen.
- **Respetar brand del cliente** por encima de inspiración. Si el cliente tiene brand book, ese es el filtro primario.
- **Considerar accesibilidad**: si una ref tiene texto blanco sobre amarillo, se toma como inspiración pero se ajusta contrast al exportar.
- **No más de 7 refs en un moodboard.** Si hay más, Claudio no decide.

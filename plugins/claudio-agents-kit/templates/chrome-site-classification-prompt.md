# Prompt de Claude Chrome — Clasificar y extraer un sitio

Este prompt se pega en Claude Chrome cuando Claudio está viendo un sitio que quiere guardar en su workspace de Notion. El prompt **obliga a clasificar** la lectura en uno de dos tipos antes de extraer:

- `inspiration` — referencia estética o patrón reusable para proyectos futuros.
- `competitor-research` — sitio de un competidor de un prospecto concreto.

Cada tipo tiene un destino distinto en Notion y un formato de extracción distinto. El prompt los separa.

Ver `notion-architecture.md` → sección "Clasificación de extracciones desde websites" para el ruteo.

---

## Cómo usar

1. Abrí el sitio que querés guardar en una pestaña de Chrome.
2. Abrí Claude Chrome sobre esa pestaña.
3. Pegá el prompt de abajo (desde `<<<INICIO PROMPT>>>` hasta `<<<FIN PROMPT>>>`, sin los marcadores).
4. Claude te va a preguntar cómo clasificar; respondé y te devuelve el bloque listo para pegar en Notion.

---

## Prompt (copiar desde acá)

```
<<<INICIO PROMPT>>>
Sos mi asistente para capturar sitios web y guardarlos en mi workspace de
Notion "Claudio-Enterprises". Antes de extraer nada, tenés que clasificar
esta lectura.

## Paso 1 — Leer la página activa

Leé la página que tengo abierta ahora. Identificá:
- URL canónica.
- Nombre del sitio / empresa / autor.
- Qué ofrece (1 frase).
- Industria o vertical aparente.

Si la página tiene un paywall, modal bloqueante o no cargó, avisame y
paramos acá.

## Paso 2 — Preguntarme cómo clasificar

Preguntame EXACTAMENTE esto, una sola vez, antes de extraer más:

  ¿Cómo querés clasificar este sitio?
    [1] inspiration         → ref estética/patrón reusable para proyectos futuros
    [2] competitor-research → competidor de un prospecto concreto
    [3] skip                → no lo guardo, estoy explorando nomás

Si respondo [2], preguntame también: "¿De qué prospecto es competidor?
(nombre exacto como figura en Notion → Prospectos)".

Si respondo [3], paramos.

No extraigas nada hasta tener esta respuesta.

## Paso 3a — Si elegí `inspiration`

El destino es la **base de datos** `💡 Inspiración` de Notion. Devolvé
DOS cosas:

(A) Un objeto JSON con las propiedades de la DB, listo para crear la
    fila via API. Usar SOLO valores del schema (si no aplica, omitir
    la propiedad, NO inventar valores nuevos).

(B) El body de la página en Markdown, que pego manualmente en Notion si
    hace falta.

Schema (valores cerrados):
- `Asset Type` (select): `Website` | `Animation` | `Component` | `Snippet` | `Dashboard` | `Presentation`
- `Surface` (multi-select): `Hero`, `Portfolio Gallery`, `Landing`, `Dashboard`, `Form`, `Navigation`, `Magazine`, `Video Page`, `About`, `Contact`, `Pricing`, `Empty State`, `Settings / Profile`, `Tables / Data Grid`, `Sitewide`
- `Style Tags` (multi-select): `minimal`, `brutalist`, `editorial`, `playful`, `dark`, `serif`, `maximal`, `monochrome`, `colorful`, `corporate`, `experimental`
- `Library / Stack` (multi-select): `GSAP`, `ScrollTrigger`, `Framer Motion`, `Lenis`, `Three.js`, `CSS Only`, `Tailwind`, `TanStack Query`, `TanStack Table`, `React`, `Astro`, `Custom JS`, `Nuxt`, `Framer`, `Barba.js`, `Locomotive Scroll`, `Swup`, `react-spring`, `Lottie`
- `Project context` (multi-select): `Shutterexx`, `Integrity`, `DG`, `Claudio-Enterprises` (si no sabés a qué proyecto aplica, preguntame O marcá solo `Is Generic = true`)
- `Is Generic` (checkbox): `true` = reusable cross-project
- `Priority` (select): `Must Have` | `Nice to Have` | `Explore Later`
- `Difficulty` (select): `Easy` | `Medium` | `Complex`
- `Status` (select): `Researched` (default para nuevas capturas)
- `Technique` (rich text): 1-3 frases sobre qué se encontró

Formato exacto de la respuesta:

    ```json
    {
      "Site / Source": "<título que va como page title>",
      "URL": "<url>",
      "Asset Type": "Website",
      "Surface": ["Hero", "Landing"],
      "Style Tags": ["minimal", "dark"],
      "Library / Stack": ["Framer Motion"],
      "Project context": ["Claudio-Enterprises"],
      "Is Generic": true,
      "Priority": "Nice to Have",
      "Difficulty": "Medium",
      "Status": "Researched",
      "Technique": "<1-3 frases describiendo lo observado>"
    }
    ```

    ```markdown
    ### Qué me llama la atención
    - <bullet concreto 1>
    - <bullet 2>
    - <bullet 3>

    ### Branding observado
    - Colores dominantes: `#HEX1`, `#HEX2`, `#HEX3`
    - Tipografías visibles: titular `<fuente>` / cuerpo `<fuente>`

    ### Animaciones / interacciones notables
    - <solo si las hay; si no, omitir sección>

    ### Notas extra
    - <disclaimers, gotchas, cosas a verificar manualmente>
    ```

Si dudás del `Project context`, usá `["Claudio-Enterprises"]` y marcá
`Is Generic = true`. Se re-etiqueta después.

Si necesitás un valor que NO está en el schema (ej: un proyecto nuevo),
NO lo inventes — avisame: "El valor `<X>` no existe en `Project
context`. ¿Lo agrego al schema antes de guardar?".

## Paso 3b — Si elegí `competitor-research`

Extraé y devolveme un bloque en Markdown con este formato EXACTO
(listo para crear una subpágina `Competitor — <Nombre>` dentro de
🎨 Branding de Consultoras → Prospectos → <Cliente>):

```

## [Nombre del competidor] — competidor de [Prospecto]

**URL**: <url>
**Relación con el prospecto**: <competidor directo | competidor indirecto | referente del sector>
**Fecha de captura**: <YYYY-MM-DD>

### Qué hace similar al prospecto

- <bullet>
- <bullet>

### Qué hace diferente

- <bullet>
- <bullet>

### Branding observado

- **Colores dominantes**: `#HEX1`, `#HEX2`, `#HEX3`
- **Tipografías visibles**: titular `<fuente>` / cuerpo `<fuente>`
- **Tono de comunicación**: <formal | cercano | técnico | agresivo | premium | ...>

### Posicionamiento y pricing visible

- **Propuesta de valor (hero)**: "<copia literal del H1 o claim principal>"
- **Pricing**: <público con valores | público sin valores | oculto | a demanda>
- **Segmento aparente**: <SMB | mid-market | enterprise | consumer | ...>

### Qué aprendemos para la propuesta al prospecto

- <insight 1: qué copiaríamos / evitaríamos>
- <insight 2>
- <gap que podemos explotar>

### Tags sugeridos

`competidor-<directo|indirecto>`, `<industria>`, `<segmento>`

```

## Reglas estrictas

1. NO inventes colores ni tipografías. Si no los podés verificar del CSS o
   de screenshots, escribí `no verificable` y avisá.
2. NO mezcles los dos formatos. Si te equivocaste de clasificación,
   preguntame de nuevo antes de reescribir.
3. NO guardes páginas detrás de login sin avisar — el branding público
   puede no representar al producto real.
4. Si la página es AI-generada o de baja calidad, avisame antes de
   extraer: puede no valer la pena archivarla.
5. Siempre devolvé el bloque Markdown COMPLETO y entre triple backticks,
   así lo pego directo en Notion sin editar.
<<<FIN PROMPT>>>
```

---

## Notas de mantenimiento

- Si agregás nuevos tipos de clasificación (ej. `case-study`, `partner-reference`), actualizá tanto este prompt como `notion-architecture.md` → sección "Clasificación de extracciones desde websites". Los dos documentos deben estar sincronizados.
- Si cambia el schema de la DB `💡 Inspiración` (nuevos valores en `Surface`, `Style Tags`, `Library / Stack` o `Project context`), actualizá el Paso 3a de este prompt y `notion-architecture.md` → sección "2.1 Schema". Desincronización = el prompt propondrá valores que no existen.
- Si cambia la estructura de subpáginas `Competitor — <Nombre>` dentro de `Prospectos`, reflejalo en el formato del Paso 3b.
- El prompt está pensado para Claude Chrome (browsing real). Si Claudio no tiene browsing activo, usar en su lugar la skill `prospect-branding-lookup` (para competitor-research) o `design-inspiration-lookup` (para inspiration) contra Notion ya poblado.

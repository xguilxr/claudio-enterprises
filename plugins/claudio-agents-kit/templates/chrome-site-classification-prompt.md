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

Extraé y devolveme un bloque en Markdown con este formato EXACTO
(listo para pegar en Notion → 💡 Inspiración):

```

## [Nombre del sitio]

**URL**: <url>
**Tipo de pieza**: <landing | portfolio | corporate | e-commerce | editorial | dashboard | pricing | otro>
**Subsección sugerida**: <Websites → Landing pages | Websites → Portfolio sites | SaaS styling → Dashboards | ...>

### Qué me llama la atención

- <bullet 1, concreto, qué ver>
- <bullet 2>
- <bullet 3>

### Branding observado

- **Colores dominantes**: `#HEX1`, `#HEX2`, `#HEX3`
- **Tipografías visibles**: titular `<fuente o familia>` / cuerpo `<fuente o familia>`
- **Tono**: <minimal | brutalist | editorial | playful | dark | serif-elegant | glassmorphism | dark-corporate | ...>

### Animaciones / interacciones notables

- <solo si las hay; si no, omitir esta sección>

### Tags sugeridos

`<tono>`, `<tipo-pieza>`, `<otro>`

```

## Paso 3b — Si elegí `competitor-research`

Extraé y devolveme un bloque en Markdown con este formato EXACTO
(listo para pegar en Notion → 🎨 Branding de Consultoras → Prospectos →
<Cliente> → 🔍 Competidores):

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
- Si cambia la estructura de `🔍 Competidores` dentro de `Prospectos`, reflejalo en el formato del Paso 3b.
- El prompt está pensado para Claude Chrome (browsing real). Si Claudio no tiene browsing activo, usar en su lugar la skill `prospect-branding-lookup` (para competitor-research) o `design-inspiration-lookup` (para inspiration) contra Notion ya poblado.

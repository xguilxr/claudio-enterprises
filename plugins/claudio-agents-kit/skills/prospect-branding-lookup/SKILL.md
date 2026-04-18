---
name: prospect-branding-lookup
description: Consulta la sección "Prospectos" del workspace de Notion de Claudio para traer lo que se conozca sobre un cliente potencial (sitio actual, competidores, inspiración del rubro, notas de discovery, propuesta enviada). Recorre subpáginas recursivamente sin asumir schema fijo. Invocar cuando se arranca un proyecto tipo `proposal` y el cliente todavía no es un cliente activo, o cuando design-researcher necesita inferir branding/posicionamiento desde el material de research del prospecto.
---

# Prospect Branding Lookup

El research de prospectos vive en Notion bajo:

```
📓 Claudio-Enterprises
  └── 🎨 Branding de Consultoras
        └── Prospectos
              ├── _Template Prospecto
              ├── <Cliente X>  [tag: con-website, con-brief-inicial]
              │   ├── Current Site — <dominio>
              │   ├── Competitor — <Nombre 1>
              │   ├── Competitor — <Nombre 2>
              │   ├── Inspiration — <Nombre>   (opcional, refs del rubro)
              │   └── Redesign Proposal & Demo
              └── <Cliente Y>  [tag: con-propuesta-enviada]
                  └── ...
```

A diferencia de `consultora-branding-lookup` (donde la estructura es rígida), acá la **completitud es variable** y **las subpáginas son arbitrarias** según lo que Claudio haya armado. Los tags de la página raíz del prospecto indican completitud general; el contenido real son las subpáginas. La skill las **recorre recursivamente sin asumir un schema fijo** — se adapta a lo que encuentre.

## Tags de completitud

| Tag | Qué implica para la skill |
|---|---|
| `solo-nombre` | No hay nada para extraer. Preguntar a Claudio antes de proponer branding. |
| `con-website` | Se puede hacer un pasaje rápido al website para inferir colores/fonts/tono. |
| `con-brief-inicial` | Hay notas del discovery. Leerlas y sintetizar. |
| `con-propuesta-enviada` | Ya hay propuesta. Útil para seguimientos, no para branding nuevo. |
| `cerrado-ganado` | Marcar `cerrado-ganado` y agregar el valor del cliente a `Project context` de la DB `Inspiración` para seguir arrastrando refs. La página del prospecto se queda donde está (no hay `📊 Proyectos` raíz). |
| `cerrado-perdido` / `archivado` | No consultar salvo referencia histórica. |

## Estructura esperada de cada prospecto (subpáginas arbitrarias, rellenar lo que haya)

La página raíz del prospecto contiene metadatos en el body (industria, budget, notas de discovery, tags). Las subpáginas cubren el research con granularidad variable — la skill las recorre recursivamente.

**Subpáginas recomendadas** (de `_Template Prospecto`):

```
<Cliente>
├── Current Site — <dominio>        ← análisis del sitio actual del prospecto
├── Competitor — <Nombre 1>         ← una subpágina por competidor
├── Competitor — <Nombre 2>
├── Inspiration — <Nombre>          ← opcional: refs del rubro que inspiran (no competidores)
├── Redesign Proposal & Demo        ← propuesta concreta (links, decks, mockups)
└── 🔍 Research adicional            ← cualquier cosa no categorizada
```

No es un schema rígido. Si una subpágina aparece con otro nombre o hay subpáginas extra bajo `🔍 Research adicional`, la skill las lee igual y las clasifica por el prefijo del título (`Competitor —`, `Inspiration —`, `Current Site —`) o por keywords en el body.

**Campos del body de la página raíz** (rellenar lo que haya):

- 🌐 Website del prospecto (URL)
- 🏢 Industria
- 📝 Notas del discovery
- 💰 Budget percibido
- 📎 Propuesta enviada (link)
- Branding detectado (colores, fonts, tono — si hubo extracción manual)

## Flujo según el tag

### Caso 1: `solo-nombre`

```
1. Avisar a Claudio: "Solo tengo el nombre de <Cliente>, no hay website ni notas."
2. Preguntar: "¿Tenés URL del website? ¿Industria? ¿Referente de estilo que te gustaría?"
3. Con la respuesta, promover el prospecto a `con-website` o `con-brief-inicial`
   (Claudio actualiza el tag en Notion).
4. Re-correr el flujo desde el caso correcto.
```

### Caso 2: `con-website`

```
1. Si existe la subpágina `Current Site — <dominio>`, leerla (ya hay research).
   Si no, abrir la URL directa y extraer.
2. Extraer candidatos de branding del website:
   - Colores dominantes (buscar el CSS o analizar screenshots si hay)
   - Tipografía del titular y del cuerpo
   - Tono visual (corporativo / playful / editorial / minimal)
   - Logo si se puede descargar
3. Si hay subpáginas `Competitor — <Nombre>`, leerlas también para armar
   el paisaje competitivo del rubro (relevante para la propuesta).
4. Emitir "Branding inferido" (formato abajo) con disclaimer:
   "Inferido del website público. Confirmar con el cliente antes de comprometer
   colores exactos en la propuesta."
5. Sugerir a Claudio que guarde los hallazgos en `Current Site — <dominio>`
   para no re-extraer la próxima vez.
```

### Caso 3: `con-brief-inicial`

```
1. Leer las notas del discovery guardadas en el body de la página raíz del prospecto.
2. Cruzar con `Current Site — <dominio>` + subpáginas `Competitor — <Nombre>`
   + `Inspiration — <Nombre>` si existen.
3. Emitir brief enriquecido: branding visual + paisaje competitivo +
   preferencias explícitas del cliente.
4. Nota: si cliente mencionó preferencias (ej: "no quiero nada azul"), esas
   sobrescriben lo inferido visualmente.
```

### Caso 4: `con-propuesta-enviada`

```
No es un caso típico para esta skill (la propuesta ya se escribió).
Usar sólo si hay que armar follow-up o iteración — en cuyo caso
linkear la propuesta previa para mantener consistencia.
```

## Output esperado (formato uniforme)

```markdown
## Branding del prospecto — [Cliente]

**Nivel de confianza**: [alto / medio / bajo]
**Fuente**: [notas de discovery / inferido del website / ambos]
**Tag actual**: [solo-nombre / con-website / con-brief-inicial / con-propuesta-enviada]

### Identidad detectada
- **Colores dominantes**: `#HEX1`, `#HEX2`, `#HEX3`
- **Tipografías visibles**: [titular: ...] / [cuerpo: ...]
- **Tono**: [formal / cercano / técnico / playful / ...]
- **Logo**: [URL si se descargó, o "pendiente"]

### Preferencias explícitas del cliente
(solo si hay brief)
- [preferencia 1]
- [preferencia 2]

### Gaps
- [qué falta para poder avanzar con confianza — ej: "confirmar paleta oficial", "pedir brand book si tienen"]

### Recomendación
- [cómo proceder: avanzar con lo inferido / pedir confirmación / pedir brandbook al cliente]
```

## Reglas

- **Nunca afirmar** que los colores inferidos son oficiales. Siempre llevan disclaimer.
- **Preguntar antes que inventar.** Si falta información crítica (ej: industria para elegir tono), preguntar a Claudio.
- **Actualizar el tag** cuando se enriquezca la información. Claudio lo refleja en Notion para que la próxima consulta sea más rica.
- **Priorizar preferencias explícitas** del cliente por encima de inferencias visuales.
- **Si el prospecto cierra** (ganado/perdido), actualizar el tag de la página raíz (`cerrado-ganado` / `cerrado-perdido` / `archivado`). En caso de `cerrado-ganado`, agregar el nombre del cliente al schema de `Project context` de la DB `Inspiración` para que refs futuras se puedan tagguear contra él.
- **Sin schema fijo**: si una subpágina no matchea los prefijos esperados (`Current Site —`, `Competitor —`, `Inspiration —`), leerla igual y clasificarla por contenido. No filtrar a mano.

## Ver también

- `consultora-branding-lookup` — para la consultora con la que se firma (identidad corporativa, estable).
- `presentation-inspiration-lookup` — para formato de propuestas/decks.
- `design-inspiration-lookup` — para refs visuales (websites, animaciones, snippets).

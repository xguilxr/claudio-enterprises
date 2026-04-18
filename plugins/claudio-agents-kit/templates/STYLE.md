# STYLE.md — [NOMBRE_PROYECTO]

> Guía de estilo del proyecto. Define el look & feel default de lo que definamos y construyamos. Frontend-expert y design-researcher la consultan antes de generar UI.

> **Jerarquía de decisión visual** (de mayor a menor prioridad):
> 1. **Brandbook del cliente** (si existe) → dentro de la página del prospecto en `🎨 Branding de Consultoras → Prospectos → <Cliente>` (subpágina o link al oficial del cliente).
> 2. **Consultora socia** (si la propuesta se firma con una consultora) → skill `consultora-branding-lookup`.
> 3. **Este STYLE.md** → defaults del proyecto.
> 4. **Defaults del sistema** (abajo) → de Claudio-Enterprises.

Si algún nivel de arriba define una variable, **override** la de abajo. No inventes; no mezcles sin razón.

---

## Tipografía

| Rol | Familia | Weight | Tamaño (mobile / desktop) | Line-height |
|---|---|---|---|---|
| Display (h1) | `[TBD]` ej: Geist / Cal Sans | 600-700 | 32 / 56 px | 1.1 |
| Heading (h2) | `[TBD]` | 600 | 24 / 36 px | 1.2 |
| Subheading (h3) | `[TBD]` | 500 | 20 / 24 px | 1.3 |
| Body | `[TBD]` ej: Inter / Geist | 400 | 16 / 16 px | 1.6 |
| Small / caption | `[TBD]` | 400 | 13 / 14 px | 1.5 |
| Monospace | `[TBD]` ej: JetBrains Mono / Geist Mono | 400 | 14 / 14 px | 1.5 |

**Defaults de Claudio-Enterprises**: `Geist` (titulares + cuerpo) + `Geist Mono` (código). Cargar via `@fontsource` o el equivalente de Vercel.

---

## Paleta

### Tokens

```css
--color-bg: #0B0B0E;           /* fondo principal (modo oscuro default) */
--color-surface: #14141A;      /* cards, panels */
--color-surface-alt: #1C1C26;  /* hover, nested */

--color-text: #F5F5F7;         /* texto principal */
--color-text-muted: #A1A1AA;   /* secundario */
--color-text-subtle: #71717A;  /* terciario, placeholders */

--color-border: #27272A;       /* divisores, inputs */
--color-border-subtle: #1F1F24;

--color-primary: [TBD];        /* CTA principal, links */
--color-primary-hover: [TBD];
--color-accent: [TBD];         /* highlight, estados */

--color-success: #10B981;
--color-warn:    #F59E0B;
--color-error:   #EF4444;
```

> **Si el cliente o consultora tiene brandbook → reemplazá primario/accent ANTES de desarrollar.** Los neutros suelen ser portables.

### Reglas

- Contraste mínimo WCAG AA (4.5:1 para texto normal, 3:1 para texto grande).
- Modo oscuro es default; el modo claro se agrega solo si el cliente lo pide.
- Nunca más de 2 colores "brand" compitiendo en la misma pantalla.

---

## Spacing

Escala 4pt (todo es múltiplo de 4):

```
4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 128
```

- **Padding container (mobile)**: 16px
- **Padding container (desktop)**: 24-32px
- **Max width contenido**: 1200px (`max-w-6xl` Tailwind) para SaaS, 720px (`max-w-3xl`) para editorial.
- **Gap entre secciones**: 64-96px desktop, 48-64px mobile.

---

## Radius y elevación

```css
--radius-sm: 4px;    /* inputs, tags */
--radius-md: 8px;    /* botones, cards chicas */
--radius-lg: 12px;   /* cards grandes, modals */
--radius-xl: 20px;   /* hero blocks */
--radius-full: 9999px; /* avatars, pills */

--shadow-sm: 0 1px 2px rgba(0,0,0,.2);
--shadow-md: 0 4px 12px rgba(0,0,0,.25);
--shadow-lg: 0 12px 32px rgba(0,0,0,.3);
```

Preferir **bordes sutiles** sobre shadows pesadas en modo oscuro.

---

## Motion

Principios:
- **Duración**: 150ms (micro) / 250ms (transiciones UI) / 400ms (page transitions). Más de 500ms = lento.
- **Easing default**: `cubic-bezier(0.16, 1, 0.3, 1)` (ease-out-expo) para entradas; `cubic-bezier(0.7, 0, 0.84, 0)` (ease-in-quad) para salidas.
- **Respetá `prefers-reduced-motion`** siempre. Animación decorativa se desactiva, transiciones funcionales permanecen pero más cortas.
- **Nunca** animes `width`/`height` si podés animar `transform: scale()`.

Librerías preferidas por caso:
- Micro-interacciones + transiciones de estado → **Framer Motion** (React) o CSS puro.
- Scroll-triggered storytelling → **GSAP** + ScrollTrigger.
- Ilustraciones animadas → **Lottie**.

Ver la DB `💡 Inspiración` en Notion con filtro `Asset Type = Animation` (y opcionalmente `Library / Stack` por tecnología) para referencias específicas.

---

## Iconografía

- Set default: **Lucide Icons** (open source, consistente, coverage amplio).
- Stroke width: 1.5-2 px.
- Tamaños estándar: 16 / 20 / 24 px.
- Nunca mezclar sets (no Lucide + Heroicons en el mismo proyecto).

---

## Componentes — defaults

### Botones
- Primario: fondo `--color-primary`, texto contrastante, radius `--radius-md`, padding `12px 20px`.
- Secundario: border `1px solid --color-border`, bg transparente, mismo radius.
- Ghost: sin border ni fondo, solo hover.
- Estados: `:hover` (shade), `:active` (scale 0.98), `:disabled` (opacity 0.5 + cursor).
- Altura mínima: 40px (touch-friendly).

### Inputs
- Border `1px solid --color-border`, radius `--radius-sm`, padding `10px 14px`.
- Focus: outline con `--color-primary`, sin shadow fea del browser.
- Label arriba, helper text abajo (never placeholder-only).

### Cards
- Bg `--color-surface`, border `1px solid --color-border-subtle`, radius `--radius-lg`, padding `24px`.
- Hover (si es clickeable): elevación sutil o border más brillante, no scale.

### Forms
- Un campo por fila en mobile; dos columnas solo si ambos son cortos (fecha + hora).
- Botón primario alineado a la derecha en desktop, full-width en mobile.
- Validación: inline debajo del campo, color `--color-error`, icon + texto.

---

## Voice & tone (microcopy)

- **Idioma default**: español rioplatense / neutro según cliente.
- **Tono**: directo, humano, sin jerga técnica innecesaria. "Guardar" en vez de "Submit".
- **Errores**: específicos y accionables. ❌ "Error al guardar" → ✅ "No pudimos guardar. Revisá tu conexión y probá de nuevo."
- **Empty states**: siempre explican qué falta y cómo llenarlo. Nunca solo "No hay datos".
- **Confirmaciones destructivas**: nombre exacto del objeto + verbo consecuencia. "Esto va a eliminar **<proyecto X>** permanentemente."

---

## Accesibilidad (non-negotiable)

- Contraste AA mínimo en todo el texto.
- Todos los interactivos con `aria-label` si el texto visible no alcanza.
- Focus rings visibles (nunca `outline: none` sin reemplazo).
- Navegación completa con teclado (Tab, Enter, Esc).
- Forms con `<label>` asociado (nunca placeholder como label).
- Alt text descriptivo en imágenes de contenido (vacío `alt=""` solo en decorativas).

---

## Do / Don't

### ✅ Do
- Probar en mobile primero (viewport 375px).
- Usar tokens, no HEX hardcodeados en componentes.
- Documentar cada decisión visual en la bitácora del proyecto.

### ❌ Don't
- Gradientes estridentes salvo que el brandbook los pida.
- Modales para tareas que pueden ser inline edits.
- Animaciones > 500ms (excepto Lottie hero).
- Mezclar más de 2 tipografías por proyecto (titular + cuerpo es el máximo normal).

---

## Bitácora de overrides

Cuando el brandbook del cliente / consultora override alguno de estos defaults, anotalo acá para no perder el hilo:

- [fecha] — [override aplicado] — [razón]

---
name: consultora-branding-lookup
description: Consulta los assets de branding de la consultora con la que Claudio esté presentando una propuesta (logo, paleta, tipografías, plantilla de slides, plantilla de propuesta). Invocar SIEMPRE al inicio de un proyecto tipo `proposal` antes de escribir cualquier contenido, y en cualquier proyecto que genere material presentable ante cliente (deck, cotización, SOW).
---

# Consultora Branding Lookup

Claudio presenta propuestas bajo distintas identidades: a veces solo como `Claudio-Enterprises`, a veces junto a una consultora socia (cada una con su propio branding), a veces en modalidad joint donde se mezclan ambos.

Esta skill define **dónde viven los assets** de cada consultora y **cómo traerlos** antes de escribir una línea.

## Source of truth

El brandbook de cada consultora vive en Notion, según la arquitectura documentada en `templates/notion-architecture.md`:

```
📓 Claudio-Enterprises
  └── 🎨 Branding de Consultoras
        └── Consultoras socias
              ├── Claudio-Enterprises    ← tu propia identidad
              ├── <Consultora A>
              └── <Consultora B>
```

Cada subpágina contiene (estructura uniforme):

1. **📎 Logos** (SVG + PNG light/dark + isotipo)
2. **🎨 Paleta** (primario, secundario, neutros, semánticos — todos con HEX + uso)
3. **🔤 Tipografías** (titulares + cuerpo + monospace — familia, weight, tamaño recomendado)
4. **📄 Especificaciones de documentos**:
   - Plantilla Word (.docx adjunto)
   - Plantilla PowerPoint (.pptx adjunto)
   - Plantillas Google Docs / Slides (links)
   - Márgenes / grillas / layout base
5. **✍️ Firma y footer** (texto exacto, mail de contacto, disclaimer legal)
6. **🎯 Idioma y tono** (formal/cercano/técnico, ES/EN, ejemplos de copy)
7. **📝 Notas** (historia de cambios, do/don't)

> Si alguna consultora todavía no tiene esta página → Claudio la arma antes de avanzar. No se improvisa branding.

## Cómo consultar (MCP Notion)

```
1. Navegar a: 🎨 Branding de Consultoras → Consultoras socias → <nombre indicado en CLAUDE.md>
2. Leer los 7 bloques de la estructura (logos, paleta, tipografías, specs docs, firma, tono, notas)
3. Copiar/linkear los archivos adjuntos (Word/PPT) a la carpeta de entregables del proyecto
4. Emitir el "Branding brief" (formato abajo) al contexto antes de escribir contenido
```

**Verificar tags** de la página raíz de la consultora:
- `estado`: si está `pausada` o `archivada`, avisar a Claudio antes de usarla.
- `modalidad`: `socia-frecuente` / `socia-ocasional` / `solo-referencia`.

## Output esperado

Un bloque "Branding brief" que se adjunta al contexto antes de escribir la propuesta:

```markdown
## Branding brief — [Consultora]

- **Logo**: [URL SVG] / [URL PNG]
- **Paleta**:
  - Primario: #XXXXXX (fondo / CTA)
  - Secundario: #XXXXXX (acento)
  - Neutros: #XXXXXX, #XXXXXX
- **Tipografías**:
  - Titulares: [Font family] [weight]
  - Cuerpo: [Font family] [weight]
- **Plantilla propuesta**: [URL]
- **Plantilla slides**: [URL]
- **Firma / footer**:
  [texto exacto que va al pie]
- **Idioma y tono**: [formal / cercano / técnico]
```

## Modalidades

### Solo Claudio-Enterprises
Usa la plantilla propia. Consultá `Claudio-Enterprises` en el vault.

### Consultora única
Brandbook de esa consultora domina. El nombre "Claudio" puede aparecer como autor técnico pero el cliente final ve la marca de la consultora.

### Joint
Ambos logos en header. Paleta: la de la consultora principal. Firma: dos bloques (Claudio + contacto de la consultora).

## Reglas

- **Nunca inventar colores, logos o tipografías.** Si el asset no está en Notion, se aborta y se pide a Claudio que suba el brandbook.
- **Consultar ANTES de escribir, no después.** Re-estilar una propuesta ya escrita es el anti-patrón que esta skill evita.
- **Mantener el brandbook versionado.** Si Claudio cambia la paleta de una consultora, se anota la fecha en Notion.
- **Nunca mezclar brandbooks** en un mismo documento salvo modalidad explícitamente "joint".

## Ver también

- `proposal-writing` — estructura del contenido de la propuesta, agnóstica al branding.
- `presentation-inspiration-lookup` — referencias de FORMATO de slides (distinto a branding corporativo).
- `design-inspiration-lookup` — refs visuales para sitios y productos (no presentaciones).

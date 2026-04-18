---
name: consultora-branding-lookup
description: Consulta los assets de branding de la consultora con la que Claudio esté presentando una propuesta (logo, paleta, tipografías, plantilla de slides, plantilla de propuesta). Invocar SIEMPRE al inicio de un proyecto tipo `proposal` antes de escribir cualquier contenido, y en cualquier proyecto que genere material presentable ante cliente (deck, cotización, SOW).
---

# Consultora Branding Lookup

Claudio presenta propuestas bajo distintas identidades: a veces solo como `Claudio-Enterprises`, a veces junto a una consultora socia (cada una con su propio branding), a veces en modalidad joint donde se mezclan ambos.

Esta skill define **dónde viven los assets** de cada consultora y **cómo traerlos** antes de escribir una línea.

## Source of truth

El brandbook de cada consultora vive en Notion, bajo una página madre:

```
📓 Notion → "Consultoras Socias" → <nombre-consultora>
```

Cada subpágina contiene:

1. **Logo** (SVG + PNG, light/dark)
2. **Paleta oficial** (primarios + secundarios, con HEX + uso)
3. **Tipografías** (titular + cuerpo, con peso y tamaño recomendado por pieza)
4. **Plantilla de propuesta** (archivo maestro, Markdown o Google Doc)
5. **Plantilla de slides** (Keynote / Google Slides / PPTX)
6. **Reglas de firma y footer** (quién firma, qué URL va, disclaimers legales)
7. **Idioma y tono** (formal / cercano / técnico, según cliente target)

> Si alguna consultora todavía no tiene esta página → Claudio la arma antes de avanzar. No se improvisa branding.

## Cómo consultar (MCP Notion)

```
1. Buscar: query "Consultoras Socias"
2. Navegar a la subpágina de la consultora indicada en el CLAUDE.md del proyecto
3. Descargar (o leer embebido) los assets listados arriba
4. Copiar links directos de los archivos al brief del proyecto
   (para que client-reporter los pueda referenciar)
```

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

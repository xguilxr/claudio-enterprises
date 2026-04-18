# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Portfolio website** (creativo o profesional)

## Cliente

- **Nombre**: [persona o estudio]
- **Profesión/industria**: [arquitecto / fotógrafo / consultor / ...]
- **Personalidad**: [corporativa / editorial / playful / minimal / ...]
- **Competencia visual**: [links a sitios de pares/referentes]

## Brief del proyecto

**Para qué sirve el sitio:**
[atraer clientes / mostrar obra / vender servicios / newsletter / branding personal]

**Secciones previstas:**
- [ ] Home / hero
- [ ] About / bio
- [ ] Obra / proyectos / casos
- [ ] Servicios
- [ ] Contacto
- [ ] Blog (opcional)
- [ ] [otros]

**Llamadas a la acción principales:**
- [qué quieren que haga el visitante: contactar / agendar / suscribirse]

**Dominio:** [URL si ya existe, sino "por definir"]
**Idiomas:** [ES / EN / bilingüe]

## Stack de este proyecto

**Framework principal:**
- [ ] Astro                   — si es sitio estático con blog (recomendado para contenido)
- [ ] Next.js                 — si necesita SSR o ISR
- [ ] React + Vite            — si es 100% client-side, más simple
- [ ] HTML + CSS puro         — si Claudio quiere pleno control y es liviano

**Styling:**
- Tailwind CSS + tokens custom del design-researcher
- Tipografías via fontsource o Google Fonts

**Animaciones:**
- [ ] CSS puro con `@media (prefers-reduced-motion)`
- [ ] Framer Motion           — si hay interacciones complejas
- [ ] GSAP                    — si hay timelines / scroll complejo
- [ ] Lottie                  — si hay animaciones ilustradas

**CMS (para blog/obra):**
- [ ] Markdown local (Astro / Next)
- [ ] Notion como CMS (vía API)
- [ ] Ninguno (contenido hardcoded)

**Deploy:**
- Cloudflare Pages (recomendado)
- GitHub Actions para CI

## Agentes activos en este proyecto

### Discovery
- [x] `discovery-agent`         — especialmente sobre tono y objetivos del sitio

### Core
- [x] `orquestador`
- [x] `documentador`            — README mínimo y guía de contenido
- [x] `limpiador`
- [ ] `optimizador`             — activar en performance final (Lighthouse)

### Expertos
- [x] `design-researcher`       — CRÍTICO, arranca acá siempre
- [x] `frontend-expert`
- [x] `devops-expert`           — para Cloudflare Pages
- [ ] `backend-expert`          — NO salvo que haya form handler custom
- [ ] `db-architect`            — NO salvo blog con DB
- [ ] `data-expert`             — NO
- [ ] `qa-expert`               — NO (tests de portfolio son overkill)
- [ ] `security-auditor`        — NO
- [ ] `product-analyst`         — NO (no necesita Epics formales, ya hay lista de secciones)
- [x] `client-reporter`         — para deliverable final al cliente

## Artefactos esperados

1. **Moodboard** (output de `design-researcher` — el más importante acá)
2. **Propuesta visual** — 2-3 direcciones distintas ANTES de codear
3. **Sitio implementado**
4. **Lighthouse score** (>90 en performance y accessibility)
5. **Manual de actualización de contenido** (para el cliente)
6. **Deploy a producción** con custom domain

## Flujo de trabajo

```
1. discovery-agent — foco en: tono, objetivos, competencia, CTA
2. design-researcher — consulta vault Notion, propone moodboard
3. Claudio aprueba dirección visual
4. frontend-expert genera 2-3 wireframes/mockups rápidos (HTML o figma)
5. Claudio elige uno
6. frontend-expert implementa completo
7. Lighthouse audit + ajustes
8. devops-expert deploy a Cloudflare con custom domain
9. client-reporter prepara manual de actualización
10. Handoff al cliente
```

## Checklist pre-deploy

- [ ] Lighthouse performance > 90
- [ ] Lighthouse accessibility > 95
- [ ] Meta tags SEO completos (title, description, og:image)
- [ ] Favicon + apple-touch-icon
- [ ] `robots.txt` y `sitemap.xml`
- [ ] Form de contacto funciona end-to-end
- [ ] Custom domain configurado con HTTPS
- [ ] Probado en mobile iOS y Android
- [ ] Probado en Chrome, Safari, Firefox
- [ ] Imágenes optimizadas (webp, lazy loading)
- [ ] `prefers-reduced-motion` respetado

## Bitácora de decisiones visuales

- [fecha] — paleta final: [HEX codes]
- [fecha] — tipografía titular: [nombre]
- [fecha] — tipografía cuerpo: [nombre]
- [fecha] — [otras decisiones]

## Estado actual

- **Fase**: [Discovery / Moodboard / Diseño / Dev / QA / Deploy / Entregado]
- **URL staging**: [link]
- **URL producción**: [link]

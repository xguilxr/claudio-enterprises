# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Platform as a Service** (full-stack)

## Cliente

- **Nombre**: [Cliente / Empresa]
- **Industria**: [comercio / salud / industria / servicios]
- **Contacto principal**: [nombre, email]
- **Canal de comunicación**: [email / Slack / WhatsApp]
- **Zona horaria / locale**: [ej. America/Argentina/Buenos_Aires]

## Brief del proyecto

**Problema que resuelve:**
[1-2 líneas en lenguaje de negocio]

**Usuario final (no el cliente que paga):**
[quién va a usar el sistema día a día]

**Métrica de éxito:**
[número concreto, ej: "reducir tiempo de consulta de 15min a 1min"]

**Plazo objetivo:** [fecha]
**Modelo de negocio:** [proyecto cerrado / retainer / mantenimiento]

## Stack de este proyecto

- Backend: FastAPI + PostgreSQL + SQLAlchemy async
- Data: Pandas para ETLs, si hay
- Frontend: React + Vite + Tailwind + TanStack Query
- Deploy: Vercel (frontend, default actual) + Fly.io / Railway (backend). Cloudflare Pages como alternativa si el proyecto lo requiere.
- Monitoreo: Sentry vía conector

## Agentes activos en este proyecto

### Discovery (arrancar acá siempre)
- [x] `discovery-agent`         — hacer antes de cualquier cosa
- [x] `product-analyst`         — después de discovery, descompone en Epics/US/TC

### Core (siempre)
- [x] `orquestador`
- [x] `documentador`
- [x] `limpiador`
- [x] `optimizador`

### Expertos técnicos
- [x] `backend-expert`
- [x] `frontend-expert`
- [x] `db-architect`
- [x] `qa-expert`
- [x] `devops-expert`
- [x] `security-auditor`          — activar sí o sí (hay auth + datos de usuarios)
- [ ] `data-expert`              — activar SI hay ETLs o análisis complejos
- [x] `design-researcher`        — activar para que el frontend tenga dirección visual
- [x] `client-reporter`          — activar para updates semanales al cliente

## Artefactos esperados

En este tipo de proyecto siempre generamos:

1. **Brief de discovery** (output de `discovery-agent`)
2. **Product plan con Epics/US/TC** (output de `product-analyst`, usar skill `epic-user-story-format`)
3. **Moodboard visual** (output de `design-researcher` consultando Notion)
4. **Schema de DB** (diseñado por `db-architect`)
5. **API docs OpenAPI** (auto-generado por FastAPI + curado por `documentador`)
6. **README con setup local** (mantenido por `documentador`)
7. **CHANGELOG.md** (actualizado por `documentador` en cada feature)
8. **Updates semanales al cliente** (generados por `client-reporter`)

## Convenciones específicas del proyecto

- [ej: Timezone del cliente: America/Argentina/Buenos_Aires]
- [ej: Moneda mostrada: ARS con formato local]
- [ej: Idioma de la UI: español]
- [agregar las que apliquen]

## Repositorio

- **URL**: [github.com/...]
- **Branches**: main (prod), develop (staging), feature/* (trabajo)
- **CI/CD**: `.github/workflows/`
- **Pre-commit**: ruff + black + ruff-format (ver skill `git-flow`)

## Recursos del cliente

- **Notion del proyecto**: [URL]
- **Notion vault de inspiración** (global): [URL]
- **Credenciales**: gestor de passwords (no acá)
- **Docs técnicos del cliente**: [URL o ubicación]
- **Acceso a ambientes**: [staging URL / prod URL]

## Flujo de trabajo estándar

```
1. Claudio escribe brief inicial a orquestador
2. orquestador llama a discovery-agent (hasta cerrar ambigüedades)
3. product-analyst genera Epics/US/TC
4. Claudio aprueba el plan
5. Por cada US:
   a. db-architect diseña schema si aplica
   b. design-researcher trae refs si es UI nueva
   c. backend-expert + frontend-expert implementan
   d. qa-expert escribe tests
   e. limpiador refactoriza
   f. optimizador revisa performance
   g. documentador actualiza docs y changelog
6. security-auditor antes de cada deploy a prod
7. client-reporter genera update semanal los viernes
```

## Bitácora de decisiones importantes

<!-- Se va llenando. Cada decisión arquitectónica no obvia deja una línea -->

- [fecha] — [decisión] — [razón]

## Estado actual

- **Fase**: [Discovery / Product planning / Desarrollo / QA / Deploy / Mantenimiento]
- **Epic actual**: [link o ID]
- **Próximo hito**: [qué y cuándo]
- **Bloqueos**: [ninguno / lista]

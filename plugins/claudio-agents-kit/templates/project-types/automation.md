# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Automatización Python** (script, scheduled job, integración)

## Cliente / Contexto

- **Para quién es**: [cliente externo / uso interno / yo mismo]
- **Cadencia de ejecución**: [manual / diario / horario / on-demand / webhook]
- **Criticidad**: [nice-to-have / importante / mission-critical]

## Brief

**Qué automatiza:**
[1 línea describiendo el proceso manual que reemplaza]

**Ahorro esperado:**
[horas/semana que se ahorran o errores que se evitan]

**Inputs:**
- [de dónde salen los datos / triggers]

**Outputs:**
- [dónde terminan los datos / notificaciones]

**Qué pasa si falla:**
[fallback manual / alerta a Claudio / retry automático]

## Stack de este proyecto

- **Lenguaje**: Python 3.11+
- **Gestión de deps**: `uv` o `pip` con `pyproject.toml`
- **Scheduling**:
  - [ ] Cron en servidor propio
  - [ ] GitHub Actions (cron en YAML)
  - [ ] Cloudflare Workers Cron Triggers
  - [ ] AWS Lambda + EventBridge
  - [ ] Manual
- **Secrets**: `.env` local + secrets del proveedor de scheduling
- **Logging**: `logging` stdlib a stdout (el scheduler captura)
- **Alertas**: email a Claudio si falla + Sentry si la criticidad lo justifica

## Agentes activos en este proyecto

### Discovery
- [x] `discovery-agent`           — mini, 3-5 preguntas sobre fallos aceptables

### Core
- [x] `orquestador`
- [x] `documentador`              — README claro con cómo correr local y cómo se deployó
- [x] `limpiador`
- [x] `optimizador`               — si procesa datos, importa perf

### Expertos
- [x] `data-expert`               — si toca DataFrames, CSVs, DBs
- [x] `backend-expert`            — si llama APIs externas o expone webhook
- [x] `devops-expert`             — para el deploy del cron/scheduler
- [x] `qa-expert`                 — tests mínimos del happy path + 2 errores
- [ ] `frontend-expert`           — NO
- [ ] `db-architect`              — activar SI escribe a DB con schema nuevo
- [ ] `design-researcher`         — NO
- [x] `client-reporter`           — si es para cliente externo (manual de uso)
- [ ] `security-auditor`          — activar si maneja PII o credenciales de terceros
- [ ] `product-analyst`           — NO (Epic/US es overkill)

## Estructura típica del proyecto

```
proyecto/
├── src/
│   ├── __init__.py
│   ├── main.py              # entry point, parseo de args
│   ├── extract.py           # de dónde vienen los datos
│   ├── transform.py         # qué les hacemos
│   ├── load.py              # dónde terminan
│   ├── notify.py            # alertas / emails
│   └── config.py
├── tests/
│   └── test_happy_path.py
├── .env.example
├── pyproject.toml
├── README.md
└── .github/workflows/
    └── schedule.yml          # si se corre via GitHub Actions
```

## Artefactos esperados

1. **Script funcional** que corre end-to-end con un comando
2. **README** con:
   - Qué hace
   - Cómo correr local (`python -m src.main --date 2026-04-18`)
   - Variables de entorno requeridas
   - Cómo está desplegado (cron, GitHub Actions, etc.)
3. **Tests mínimos**: happy path + 1-2 errores
4. **Logs estructurados** (cada paso loguea qué hizo)
5. **Alertas configuradas** (email a Claudio si falla)
6. **Manual de uso** si es para cliente externo

## Flujo de trabajo

```
1. discovery-agent — foco en: trigger, fallos aceptables, datos que toca
2. orquestador planea los módulos (extract/transform/load/notify)
3. data-expert o backend-expert implementan el core
4. devops-expert configura el scheduling
5. qa-expert agrega tests mínimos
6. documentador escribe README
7. Deploy y test end-to-end en staging
8. Handoff o dejar corriendo
```

## Checklist pre-deploy

- [ ] Corre en local sin errores con datos de prueba
- [ ] Corre con dataset real (al menos 1 vez)
- [ ] Logs son claros (un humano puede debuggear desde los logs)
- [ ] Maneja al menos el top-3 de fallos esperados (red, permisos, data vacía)
- [ ] Envía alerta cuando falla
- [ ] No commitea secrets
- [ ] `.env.example` documentado
- [ ] README tiene comando exacto de ejecución
- [ ] Scheduler configurado
- [ ] Primera ejecución automática verificada

## Bitácora

- [fecha] — [decisiones no obvias, ej: "decidimos reintentar 3 veces con backoff exponencial"]

## Estado actual

- **Fase**: [Dev / Staging / Producción]
- **Última ejecución**: [fecha + status]
- **Próxima ejecución**: [fecha]
- **URL del scheduler**: [link al workflow / cron]

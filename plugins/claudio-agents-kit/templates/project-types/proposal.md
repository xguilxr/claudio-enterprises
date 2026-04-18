# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Propuesta comercial / cotización**

## Cliente

- **Nombre**: [Cliente / Empresa]
- **Contacto**: [nombre, email, rol]
- **Cómo llegó**: [referido por X / inbound / outbound / cliente recurrente]
- **Industria**: [...]
- **Tamaño aproximado**: [micro / pequeña / mediana]

## Contexto

**Qué pidieron textualmente:**
> "[copiar/pegar lo que dijo el cliente, en sus palabras, sin traducir]"

**Qué interpreto que necesitan realmente:**
[1-2 líneas con tu lectura del verdadero problema, puede diferir de lo que pidieron]

**Urgencia percibida:**
[alta / media / baja — y por qué]

**Budget approx:**
[qué imagino que pueden pagar, basado en tamaño de empresa y dolor]

## Agentes activos en este proyecto

### Discovery (mini, para entender antes de cotizar)
- [x] `discovery-agent`         — acotado, 3-4 preguntas clave no más

### Core
- [x] `orquestador`
- [ ] `documentador`             — NO, no hay código
- [ ] `limpiador`                — NO
- [ ] `optimizador`              — NO

### Expertos
- [x] `client-reporter`          — el que escribe la propuesta
- [ ] resto — NO activar en esta fase

## Artefactos esperados

1. **Discovery notes** (mini brief, 1 página)
2. **Propuesta** (usando skill `proposal-writing`)
   - Versión inicial
   - Versión revisada (si hay ida y vuelta)
3. **Seguimientos** (follow-up a los 3, 7 y 14 días si no responde)
4. **Registro de cierre** — ganado / perdido / postergado, con razón

## Flujo de trabajo

```
1. Claudio pega el pedido del cliente al orquestador
2. discovery-agent hace 3-4 preguntas a Claudio para entender contexto
   (alcance, sistemas existentes, budget, timeline)
3. orquestador evalúa si hay suficiente info:
   - Si NO → Claudio agenda llamada con cliente para completar
   - Si SÍ → client-reporter escribe propuesta v1
4. Claudio revisa, ajusta, aprueba
5. Claudio envía al cliente (Claude NO envía directo)
6. Schedule follow-ups automáticos
7. Si gana → convertir el CLAUDE.md en uno de tipo platform/automation/etc.
```

## Referencias internas

- **Propuestas anteriores** (carpeta en Notion): [URL]
- **Rangos de precio** (para calibrar): [URL o notas]
- **Casos de éxito** (para meter en la propuesta): [URL]

## Checklist antes de enviar

- [ ] Nombre del cliente bien escrito en todo el documento
- [ ] Fecha y validez presentes
- [ ] "Qué NO incluye" está
- [ ] 2 opciones de precio (cerrado vs retainer) cuando aplique
- [ ] Forma de pago clara
- [ ] Fecha de inicio estimada
- [ ] Requisitos del cliente listados (accesos, punto de contacto)
- [ ] Nombre del archivo final: `propuesta-[cliente]-[YYYY-MM-DD].pdf`

## Estado actual

- **Etapa**: [Discovery / Redacción / Enviada / Follow-up / Cerrada]
- **Fecha envío**: [si ya se mandó]
- **Fecha validez**: [vence]
- **Próxima acción**: [llamada / follow-up / esperar]

## Bitácora

- [fecha] — [acción tomada]

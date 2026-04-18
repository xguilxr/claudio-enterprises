# CLAUDE.md — Proyecto: [NOMBRE_PROYECTO]
> Tipo de proyecto: **Propuesta comercial / cotización**

## Consultora socia

- **Consultora con la que presento**: [Claudio-Enterprises solo / <nombre de consultora> / joint]
- **Branding a aplicar**: ver skill `consultora-branding-lookup` (busca logo, paleta, tipografías, plantilla de presentación de la consultora elegida)
- **Qué va en la firma / footer**: [solo Claudio / consultora / ambos]

> Este campo es el primero que se define. El output visual (propuesta, slides) depende de esto.

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
1. Claudio define: ¿con qué consultora presento esta propuesta?
   → orquestador invoca skill `consultora-branding-lookup` para traer
     logo, paleta, tipografías y plantilla de la consultora elegida.
2. Claudio pega el pedido del cliente al orquestador.
3. discovery-agent hace 3-4 preguntas a Claudio para entender contexto
   (alcance, sistemas existentes, budget, timeline).
4. orquestador evalúa si hay suficiente info:
   - Si NO → Claudio agenda llamada con cliente para completar.
   - Si SÍ → antes de escribir, consultar skill
     `presentation-inspiration-lookup` para traer 2-3 refs de slides/propuestas
     que Claudio haya marcado como "me gusta ese formato".
5. client-reporter escribe propuesta v1 aplicando branding + inspiración.
6. Claudio revisa, ajusta, aprueba.
7. Claudio envía al cliente (Claude NO envía directo).
8. Schedule follow-ups automáticos.
9. Si gana → convertir el CLAUDE.md en uno de tipo platform/automation/etc.
```

## Referencias internas

- **Propuestas anteriores** (carpeta en Notion): [URL]
- **Rangos de precio** (para calibrar): [URL o notas]
- **Casos de éxito** (para meter en la propuesta): [URL]

## Checklist antes de enviar

- [ ] Branding de la consultora aplicado correctamente (logo, colores, tipografías)
- [ ] Firma / footer según lo definido en "Consultora socia"
- [ ] Nombre del cliente bien escrito en todo el documento
- [ ] Fecha y validez presentes
- [ ] "Qué NO incluye" está
- [ ] 2 opciones de precio (cerrado vs retainer) cuando aplique
- [ ] Forma de pago clara
- [ ] Fecha de inicio estimada
- [ ] Requisitos del cliente listados (accesos, punto de contacto)
- [ ] Nombre del archivo final: `propuesta-[consultora]-[cliente]-[YYYY-MM-DD].pdf`

## Estado actual

- **Etapa**: [Discovery / Redacción / Enviada / Follow-up / Cerrada]
- **Fecha envío**: [si ya se mandó]
- **Fecha validez**: [vence]
- **Próxima acción**: [llamada / follow-up / esperar]

## Bitácora

- [fecha] — [acción tomada]

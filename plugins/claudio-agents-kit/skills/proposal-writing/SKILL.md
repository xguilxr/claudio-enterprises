---
name: proposal-writing
description: Estructura para propuestas comerciales y cotizaciones de proyectos para PyMES. Invocar cuando Claudio necesita generar una propuesta, cotización, SOW (Statement of Work) o follow-up comercial. Segundo tipo de proyecto más frecuente.
---

# Propuestas comerciales — Estructura Claudio-Enterprises

## Prerrequisitos (antes de escribir una línea)

1. **Branding de la consultora** → invocar skill `consultora-branding-lookup`
   y traer logo, paleta, tipografías, plantilla. Sin esto no se arranca.
2. **Inspiración de formato** → invocar skill `presentation-inspiration-lookup`
   para traer 2-3 refs del tipo de pieza (propuesta larga / cotización corta / deck).

Con esos dos blocks en el contexto, se procede a escribir usando una de las estructuras de abajo.

## Los 4 tipos de documento comercial

1. **Propuesta inicial** (larga, después del discovery)
2. **Cotización rápida** (1 página, para cambios de scope)
3. **SOW** (Statement of Work, para proyectos grandes donde se firma)
4. **Follow-up** (recordatorio de que mandaste algo y esperás decisión)

## Propuesta inicial — Estructura

```markdown
# Propuesta — [Cliente] — [Proyecto]

**Fecha:** [DD/MM/YYYY]
**Versión:** 1.0
**Validez:** 30 días

---

## 1. Contexto

[1-2 párrafos: qué entendimos que necesitan, en sus palabras. Esto demuestra que escuchaste.]

## 2. Problema que resolvemos

[Lista corta, en lenguaje de negocio no técnico:]
- Hoy, [situación actual dolorosa]
- Esto cuesta [tiempo / dinero / oportunidad]
- Si no se resuelve, [consecuencia futura]

## 3. Solución propuesta

[En lenguaje de negocio. El cliente NO quiere leer sobre stack.]

[Breve descripción de qué vamos a entregar en términos de beneficio:]
- Una herramienta que permite [acción concreta]
- Integrado con [sistemas existentes del cliente]
- Accesible desde [web / mobile / ambos]

[Si aplica: screenshot de inspiración similar, o mockup básico]

## 4. Qué NO incluye

[Crítico. Alinea expectativas. Evita discusiones después.]

- NO incluye migración de datos históricos (se cotiza aparte si se requiere)
- NO incluye capacitación presencial
- NO incluye soporte 24/7 (el soporte es en horario comercial vía email)

## 5. Fases y entregables

| Fase | Duración | Entregables |
|---|---|---|
| Discovery y diseño | 1 semana | Documento de requerimientos, mockups |
| Desarrollo MVP | 3 semanas | Sistema funcional en ambiente de pruebas |
| Ajustes y QA | 1 semana | Sistema en producción |
| Transición y docs | 3 días | Manual de usuario, capacitación virtual |

**Duración total estimada:** [X semanas]
**Inicio:** [fecha estimada]

## 6. Inversión

**Opción A — Proyecto cerrado**
- Total: **$[monto] ARS/USD**
- 40% al firmar, 40% al entregar MVP, 20% al cierre
- Incluye [N] rondas de ajustes durante QA

**Opción B — Retainer mensual (recomendado si hay evolución continua)**
- $[monto]/mes
- [N] horas de desarrollo al mes
- Horas no usadas se acumulan hasta 2 meses

## 7. Qué necesitamos de tu lado

- Acceso a [sistemas]
- Un punto de contacto para decisiones
- Disponibilidad de [N] horas/semana para validar entregables

## 8. Siguientes pasos

1. Revisar esta propuesta (esperamos feedback hasta [fecha])
2. Llamada de 30 min para ajustar detalles
3. Firma y depósito inicial
4. Kick-off

---

Cualquier duda, respondeme este correo.

Saludos,
Claudio
[firma]
```

## Cotización rápida — Estructura

Para cambios de scope o pedidos puntuales:

```markdown
# Cotización — [Descripción corta del pedido]

Cliente: [nombre]
Fecha: [DD/MM/YYYY]
Válida hasta: [fecha + 15 días]

## Qué incluye
- [bullet 1]
- [bullet 2]
- [bullet 3]

## Inversión
$[monto] [ARS/USD]
Plazo: [N días hábiles desde aprobación]

## Forma de pago
[50/50 / full al entregar / otro]

Responder con "aprobado" para arrancar.
```

## SOW — Cuándo usarlo

Solo si:
- Proyecto > $5000 USD equivalente
- Cliente es corporación o requiere documento formal
- Hay propiedad intelectual que negociar

Agrega a la propuesta inicial secciones de:
- Propiedad intelectual
- Confidencialidad
- Resolución de disputas
- Force majeure

No lo improvises. Para SOW formal, pedir revisión legal.

## Follow-up — Estructura

3 días después de mandar propuesta sin respuesta:

```
Hola [nombre],

Te paso este mensaje rápido para confirmar si recibiste la propuesta que mandé el [fecha] sobre [proyecto].

Si tenés dudas o querés revisar algún punto, quedo a disposición para una llamada de 15 min.

Saludos,
Claudio
```

7 días después:
```
Hola [nombre],

Sigo disponible para avanzar con [proyecto]. La propuesta actual vence el [fecha de validez].

Si no es el momento indicado, avisame y la archivo. Si necesitás más info para decidir, decime qué y te lo preparo.

Saludos,
Claudio
```

14 días después — cierre educado:
```
Hola [nombre],

Entiendo que los tiempos no coincidieron esta vez. Quedo atento para más adelante.

Saludos,
Claudio
```

## Reglas de negocio

1. **Nunca cotizar en vivo por WhatsApp o call.** Siempre "te mando la propuesta por mail y lo revisás".
2. **Siempre validez con fecha de vencimiento.** Evita que vuelvan en 6 meses pidiendo los mismos precios.
3. **Siempre qué NO incluye.** Más importante que qué sí.
4. **Siempre 2 opciones cuando aplique** (proyecto cerrado vs retainer). Da poder de elección al cliente.
5. **Nunca mandar sin revisar.** Claudio lee 100% antes de enviar.
6. **Números redondeados con propósito.** $3200 se ve pensado, $3247 se ve improvisado.

## Anti-patterns

- Propuestas sin contexto del cliente (copy-paste de otras)
- Descripciones técnicas que el cliente no entiende
- Sin fecha de validez
- Sin qué NO incluye
- Pagos "a convenir" (abre negociación eterna)
- Sin plazo de entrega concreto

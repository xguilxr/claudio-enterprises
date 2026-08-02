---
name: andamiaje-entorno
description: Monta el entorno de trabajo de un repositorio — instrucciones, comandos de verificación y reglas por área — hasta que el asistente sepa dónde está y pueda comprobar lo que hace. Úsala al empezar en un repo, o cuando Claude se pierda en él.
---

# Andamiaje entorno

**Marco:** MCA
**Requisitos que ayuda a cumplir:** CTX-01..05, FLU-01..03
**Confirmación humana requerida en:** Escribir sobre configuración existente

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/mca/prompts/MCA-P01-andamiaje-entorno.md`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mca/prompts/MCA-P01-andamiaje-entorno.md`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mca/prompts/MCA-P01-andamiaje-entorno.md` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

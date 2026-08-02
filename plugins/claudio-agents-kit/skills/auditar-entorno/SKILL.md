---
name: auditar-entorno
description: Mide cuánto contexto se carga en cada turno y determina el nivel del entorno de trabajo. Úsala cuando las respuestas se sientan lentas, o antes de conectar sistemas externos.
---

# Auditar entorno

**Marco:** MCA
**Requisitos que ayuda a cumplir:** Todos los de MCA
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/mca/prompts/MCA-P02-auditoria-entorno.md`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mca/prompts/MCA-P02-auditoria-entorno.md`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mca/prompts/MCA-P02-auditoria-entorno.md` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

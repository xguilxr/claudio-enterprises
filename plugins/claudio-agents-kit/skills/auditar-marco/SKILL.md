---
name: auditar-marco
description: Verifica que un marco cumple las reglas de la familia — estructura, identificadores únicos, niveles, trazabilidad y activación. Úsala antes de publicar un marco nuevo o al revisar la coherencia entre varios.
---

# Auditar marco

**Marco:** MFB
**Requisitos que ayuda a cumplir:** Todos los de MFB
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/mfb/prompts/MFB-P02-auditar-marco.md`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mfb/prompts/MFB-P02-auditar-marco.md`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mfb/prompts/MFB-P02-auditar-marco.md` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

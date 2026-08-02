---
name: auditoria-conformidad
description: Audita una base de código contra el marco de calidad y devuelve el nivel real más un plan por tandas. Úsala cuando necesites saber en qué estado está un producto de verdad, no por impresión.
---

# Auditoria conformidad

**Marco:** MCS
**Requisitos que ayuda a cumplir:** GOB-03
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/mcs/prompts/MCS-P01-auditoria.md`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mcs/prompts/MCS-P01-auditoria.md`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mcs/prompts/MCS-P01-auditoria.md` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

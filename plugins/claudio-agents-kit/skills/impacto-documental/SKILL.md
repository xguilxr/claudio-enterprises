---
name: impacto-documental
description: Detecta qué documentos quedan desactualizados por un cambio de código. Úsala antes de cerrar un cambio que toque comportamiento, contratos o esquemas.
---

# Impacto documental

**Marco:** MCS
**Requisitos que ayuda a cumplir:** DOC-06
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/mcs/MCS-CORE.md §5.16`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mcs/MCS-CORE.md §5.16`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mcs/MCS-CORE.md §5.16` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

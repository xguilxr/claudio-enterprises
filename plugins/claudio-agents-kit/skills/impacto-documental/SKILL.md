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

El procedimiento vive en `marcos/mcs/MCS-CORE.md §5.16`, que **viaja con este plugin**. Un hecho reside en
un solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mcs/MCS-CORE.md`. Si esa variable no resuelve, buscá
   `marcos/mcs/MCS-CORE.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mcs/MCS-CORE.md §5.16` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

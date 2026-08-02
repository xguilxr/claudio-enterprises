---
name: inmersion-sectorial
description: Estudia un rubro que no conocés contra reloj y devuelve un dossier más un kit de reunión. Úsala antes de la primera reunión con un cliente de un sector nuevo.
---

# Inmersion sectorial

**Marco:** MCC
**Requisitos que ayuda a cumplir:** INV-01..09
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento vive en `marcos/mcc/MCC-G02-inmersion-sectorial.md`, que **viaja con este plugin**. Un hecho reside en
un solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mcc/MCC-G02-inmersion-sectorial.md`. Si esa variable no resuelve, buscá
   `marcos/mcc/MCC-G02-inmersion-sectorial.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mcc/MCC-G02-inmersion-sectorial.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

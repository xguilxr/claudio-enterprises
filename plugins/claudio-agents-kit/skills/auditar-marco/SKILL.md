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

El procedimiento vive en `marcos/mfb/MFB-P02-auditar-marco.md`, que **viaja con este plugin**. Un hecho reside en un
solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mfb/MFB-P02-auditar-marco.md`. Si esa variable no resuelve, buscá
   `marcos/mfb/MFB-P02-auditar-marco.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mfb/MFB-P02-auditar-marco.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

---
name: destilar-skill
description: Convierte un patrón que se repite en el trabajo diario en una skill, puntuándolo primero para saber si merece existir y dónde debe vivir. Úsala cuando expliques lo mismo por tercera vez, o al revisar el registro de patrones.
---

# Destilar skill

**Marco:** MCA
**Requisitos que ayuda a cumplir:** APR-01..07
**Confirmación humana requerida en:** Publicar la skill

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento vive en `marcos/mca/MCA-G01-entorno-agentico.md §4`, que **viaja con este plugin**. Un hecho reside en
un solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mca/MCA-G01-entorno-agentico.md`. Si esa variable no resuelve, buscá
   `marcos/mca/MCA-G01-entorno-agentico.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mca/MCA-G01-entorno-agentico.md §4` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

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

El procedimiento vive en `marcos/mca/MCA-P01-andamiaje-entorno.md`, que **viaja con este plugin**. Un hecho reside en un
solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mca/MCA-P01-andamiaje-entorno.md`. Si esa variable no resuelve, buscá
   `marcos/mca/MCA-P01-andamiaje-entorno.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mca/MCA-P01-andamiaje-entorno.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

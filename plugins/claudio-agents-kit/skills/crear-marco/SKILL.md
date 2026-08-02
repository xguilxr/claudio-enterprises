---
name: crear-marco
description: Construye un marco de trabajo nuevo — decide si de verdad hace falta uno, redacta la guía antes que la normativa y extrae los requisitos. Úsala cuando aparezca una disciplina que quieras codificar en reglas verificables. No la uses si es un tema dentro de un marco que ya existe.
---

# Crear marco

**Marco:** MFB
**Requisitos que ayuda a cumplir:** EST-01..05, NOM-01..07
**Confirmación humana requerida en:** Publicar el marco

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento vive en `marcos/mfb/MFB-P01-crear-marco.md`, que **viaja con este plugin**. Un hecho reside en un
solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mfb/MFB-P01-crear-marco.md`. Si esa variable no resuelve, buscá
   `marcos/mfb/MFB-P01-crear-marco.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mfb/MFB-P01-crear-marco.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

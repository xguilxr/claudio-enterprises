---
name: encuadrar-encargo
description: Convierte una petición vaga de cliente en un encargo con tipo, pregunta central, qué queda fuera y cómo se sabrá que salió bien. Úsala en la primera conversación, antes de prometer nada.
---

# Encuadrar encargo

**Marco:** MCC
**Requisitos que ayuda a cumplir:** CTR-01..06
**Confirmación humana requerida en:** Comprometer alcance o precio

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento vive en `marcos/mcc/MCC-P01-conduccion-encargo.md`, que **viaja con este plugin**. Un hecho reside en
un solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mcc/MCC-P01-conduccion-encargo.md`. Si esa variable no resuelve, buscá
   `marcos/mcc/MCC-P01-conduccion-encargo.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mcc/MCC-P01-conduccion-encargo.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

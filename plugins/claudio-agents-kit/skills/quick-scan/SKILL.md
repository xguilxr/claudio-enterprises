---
name: quick-scan
description: Reconocimiento de un repositorio en 20 minutos — qué tiene, qué le falta, banderas rojas y arreglos de menos de cuatro horas. Úsala al entrar a un repo que no conocés. No sirve para declarar nivel de conformidad.
---

# Quick scan

**Marco:** MCS
**Requisitos que ayuda a cumplir:** —
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento vive en `marcos/mcs/MCS-P03-quick-scan.md`, que **viaja con este plugin**. Un hecho reside en
un solo documento (TRZ-02); esta skill lo enruta, no lo copia.

1. Localizalo: `${CLAUDE_PLUGIN_ROOT}/marcos/mcs/MCS-P03-quick-scan.md`. Si esa variable no resuelve, buscá
   `marcos/mcs/MCS-P03-quick-scan.md` a partir del directorio de esta skill, subiendo hasta la raíz del plugin.
   **Si no lo encontrás, pará y decilo. No lo reconstruyas de memoria: un
   procedimiento recordado produce resultados con apariencia de rigor.**
2. Ejecutalo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrá el resultado donde el documento indique.

## Puertas de calidad

- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `marcos/mcs/MCS-P03-quick-scan.md` — procedimiento completo
- `marcos/ORQUESTADOR.md` — qué más cargar y cuándo

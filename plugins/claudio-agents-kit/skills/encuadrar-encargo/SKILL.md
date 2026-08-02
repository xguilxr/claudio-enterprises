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

El procedimiento completo vive en `docs/mcc/prompts/MCC-P01-conduccion-encargo.md`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/mcc/prompts/MCC-P01-conduccion-encargo.md`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/mcc/prompts/MCC-P01-conduccion-encargo.md` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

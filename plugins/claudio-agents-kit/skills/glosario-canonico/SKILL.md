---
name: glosario-canonico
description: Crea y mantiene el glosario de términos del dominio, con término preferente, definición y palabras que no deben usarse. Úsala cuando el mismo concepto aparezca con dos nombres, o al arrancar un dominio nuevo.
---

# Glosario canonico

**Marco:** MCS
**Requisitos que ayuda a cumplir:** LEN-01, DAT-01
**Confirmación humana requerida en:** ninguna

## Cuándo aplica

Ver el campo `description`. Si la situación no encaja, no la fuerces: el catálogo tiene
otras y el marco no exige adopción íntegra.

## Procedimiento

El procedimiento completo vive en `docs/conocimiento/glosario.yaml`. Un hecho reside en un solo documento (TRZ-02);
esta skill lo enruta, no lo copia.

1. Leer `docs/conocimiento/glosario.yaml`.
2. Ejecutarlo sobre el caso concreto, respetando sus etapas y sus puntos de control.
3. Registrar el resultado donde el documento indique.

## Puertas de calidad

- [ ] El documento de referencia se leyó, no se recordó
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] Las acciones que exigen confirmación humana se confirmaron

## Referencias

- `docs/conocimiento/glosario.yaml` — procedimiento completo
- `docs/ORQUESTADOR.md` — qué más cargar y cuándo

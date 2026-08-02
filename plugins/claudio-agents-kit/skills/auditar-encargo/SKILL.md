---
name: auditar-encargo
description: Evalúa un encargo de cliente ya cerrado contra el marco de consultoría y devuelve el nivel alcanzado más un plan. Úsala al cerrar un proyecto de cliente, o cuando quieras saber qué tan bien se condujo el encargo. No hace falta adjuntar nada.
---

# Auditar encargo

**Marco:** MCC · **Confirmación humana requerida en:** ninguna

Es la parte MCC de la auditoría. Para los tres marcos en orden, usá `auditar-proyecto`.

---

## Etapa 0 — La condición que decide si esto corre

> **`MCC-CORE` §6: «La evaluación se hace por encargo, al cierre. Un encargo abierto no se
> evalúa.»**

Antes que nada, establecé si el encargo está cerrado.

| Situación | Qué hacés |
|---|---|
| Encargo cerrado | Auditás. Es el caso normal |
| Fases o contratos cerrados dentro de uno mayor | Auditás **cada fase cerrada** por separado. La unidad es el encargo, no el proyecto |
| Todo en curso | **NO auditás.** Declarás NO EVALUABLE citando §6, y ofrecés `encuadrar-encargo` o `MCC-P01` para conducirlo de acá en adelante |
| Nunca hubo encargo: producto propio | MCC **no aplica**. Se declara en `conformidad.yaml` con justificación y se termina |

Declarar NO EVALUABLE **no es un hallazgo negativo**. Un encargo abierto evaluado a medias
produce no conformidades sobre trabajo que todavía no tenía por qué estar hecho.

---

## Etapa 1 — Localizá los documentos

Viajan con este plugin. Probá en este orden:

1. `${CLAUDE_PLUGIN_ROOT}/marcos/mcc/MCC-CORE.md`
2. Si esa variable no resuelve: buscá `marcos/mcc/MCC-CORE.md` a partir del directorio de
   esta skill, subiendo hasta la raíz del plugin.

> **Si no lo encontrás, pará y decilo.** No reconstruyas los 92 requisitos de memoria: un
> procedimiento recordado produce resultados con apariencia de rigor.

Complementarios, según lo que salga: `marcos/mcc/MCC-G01-proceso-consultivo.md` ·
`MCC-G02-inmersion-sectorial.md` · `MCC-G03-economia-del-encargo.md`.

---

## Etapa 2 — Reuní el material

**MCC no audita el repositorio: audita el encargo.** Esa evidencia casi nunca está en git.

Pedila explícitamente antes de empezar: qué se contrató y con quién · qué quedó fuera de
alcance, por escrito · la propuesta y su costeo · qué se entregó y cuándo · qué se
transfirió al cerrar.

Lo que no aparezca, se evalúa NO CONFORME por ausencia de evidencia, no se supone. Un
acuerdo que solo existe en la memoria de las partes es exactamente lo que los requisitos de
CTR y PRO existen para prevenir.

---

## Etapa 3 — Evaluá

Nivel objetivo desde `conformidad.yaml` de la raíz. Si no está, no lo elijas vos: pedilo.

Recorré los nueve dominios: CTR contratación · INV inmersión · ANA análisis · PRO propuesta
· ECO economía · ESF esfuerzo · PLA planificación · ENT entrega · CLI relación con el
cliente.

Estados: CONFORME · PARCIAL · NO CONFORME · NO APLICABLE.

Un dominio completo **puede** declararse NO APLICABLE cuando el tipo de encargo lo excluye
conforme a `MCC-CORE` §1.3. La exclusión se justifica por escrito, siempre.

---

## Etapa 4 — Registrá

En el repositorio auditado: `docs/conformidad/AAAA-MM-DD-mcc.md`, y `conformidad.yaml` con
el `alcanzado` de MCC.

Si el resultado fue NO EVALUABLE, registralo igual con la razón. **La ausencia de
evaluación es un dato**, y dentro de seis meses nadie va a recordar si fue por encargo
abierto o porque se olvidó.

## Puertas de calidad

- [ ] Se estableció si el encargo está cerrado **antes** de evaluar nada
- [ ] El procedimiento se leyó de `marcos/`. Si no se pudo leer, se paró y se dijo
- [ ] El nivel objetivo salió de `conformidad.yaml`, no de un criterio propio
- [ ] Lo que no tiene evidencia se marcó NO CONFORME, no se supuso
- [ ] Toda exclusión de dominio quedó justificada por escrito
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)

## Referencias

- `marcos/mcc/MCC-CORE.md` — 92 requisitos, 9 dominios, y §6 con la regla de cierre
- `marcos/AUDITORIA.md` — por qué MCC va antes que MCS

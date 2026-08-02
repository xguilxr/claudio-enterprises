---
name: auditar-proyecto
description: Audita este proyecto contra los marcos de calidad y devuelve un solo plan de mejora. Úsala cuando te pidan auditar, revisar o evaluar el proyecto, cuando entres a uno heredado, o cuando no sepas por dónde empezar a mejorarlo. No hace falta adjuntar nada.
---

# Auditar proyecto

**Marco:** — · **Confirmación humana requerida en:** ninguna

Ejecuta la auditoría completa sobre el repositorio abierto. **No pidas que te adjunten
documentos: viajan con este plugin.**

---

## Etapa 0 — Localizá los documentos

Están en `marcos/`, dentro del directorio de este plugin. Probá en este orden:

1. `${CLAUDE_PLUGIN_ROOT}/marcos/AUDITORIA.md`
2. Si esa variable no resuelve: buscá `marcos/AUDITORIA.md` a partir del directorio que
   contiene esta skill, subiendo hasta la raíz del plugin.

> **Si no lo encontrás, PARÁ y decilo.** No reconstruyas el procedimiento de memoria ni
> sigas con lo que recuerdes de los marcos. Una auditoría inventada trae número, tabla y
> apariencia de rigor sobre requisitos que nadie leyó: es peor que no auditar.

Los que vas a necesitar:

| Para | Documento |
|---|---|
| El orden y el registro | `marcos/AUDITORIA.md` |
| Entorno agéntico | `marcos/mca/MCA-P02-auditoria-entorno.md` · `marcos/mca/MCA-CORE.md` · `marcos/mca/MCA-OP01-mapa-de-capacidades.md` |
| Consultoría | `marcos/mcc/MCC-CORE.md` §6 |
| Software | `marcos/mcs/MCS-P01-auditoria.md` · `marcos/mcs/MCS-CORE.md` |

---

## Etapa 1 — Leé `conformidad.yaml` de la raíz

De ahí salen los niveles objetivo, su justificación, y —si las hay— las banderas rojas.

**Si no existe:** no inventes los objetivos. Decilo, mostrá la tabla de perfiles de
`AUDITORIA.md` §2, y ofrecé crear el archivo. Sin nivel objetivo, toda auditoría devuelve
«no conforme» a casi todo y no informa ninguna decisión.

---

## Etapa 2 — Banderas rojas, antes que nada

Si `conformidad.yaml` declara una bandera roja con estado `SIN VERIFICAR`, **comprobala
primero**. Si falla: parás, lo reportás, y no auditás nada más.

`AUDITORIA.md` §1.3: una bandera roja conocida se resuelve antes de auditar.

---

## Etapa 3 — Los marcos, en orden: MCA → MCC → MCS

El orden no es negociable y su justificación está en `AUDITORIA.md` §1.

**MCA.** Ejecutá `MCA-P02` completo contra `MCA-CORE`.

> **Corte duro:** sin presupuesto de contexto permanente declarado, MCA es **N0** y parás
> ahí. No sigas a MCC ni a MCS. Ofrecé ejecutar `marcos/mca/MCA-P01-andamiaje-entorno.md`
> para montar el entorno a N2 y volver. Arrastrar un entorno ciego a los otros dos marcos
> cuesta más que la tarde que lleva arreglarlo.

**MCC.** Solo si `conformidad.yaml` no lo declara `no_aplica`.

> **`MCC-CORE` §6: la evaluación se hace por encargo, al cierre. Un encargo abierto no se
> evalúa.** Si el encargo sigue en curso, declaralo NO EVALUABLE citando esa regla y seguí.
> No es un hallazgo negativo.

**MCS.** Ejecutá `MCS-P01` con el nivel objetivo del `conformidad.yaml`, nunca con uno que
elijas vos. Auditar en N4 lo que necesitaba N2 produce decenas de no conformidades reales e
irrelevantes.

---

## Etapa 4 — Registrá

En el repositorio auditado, nunca en el del marco:

```
docs/conformidad/
├── AAAA-MM-DD-mca.md
├── AAAA-MM-DD-mcc.md
├── AAAA-MM-DD-mcs.md
└── plan.md              ← consolidado, el único que se consulta a diario
```

Y actualizá `conformidad.yaml`: `alcanzado` por marco, `evaluado` con la fecha,
`proxima_evaluacion` a 90 días.

---

## Etapa 5 — Un solo plan

**Tres informes no los lee nadie.** Las acciones de los tres marcos se ordenan juntas por
impacto sobre esfuerzo, porque el esfuerzo sale del mismo sitio.

Orden de subida cuando hay que elegir (`AUDITORIA.md` §2.1):

1. Cualquier gravedad crítica, en el marco que sea
2. MCA hasta N2, si no está
3. El marco cuya no conformidad produjo el problema que motivó la auditoría
4. El resto, por impacto sobre esfuerzo

---

## Modos parciales

| Pedido | Qué corrés |
|---|---|
| «solo el entorno» | Etapas 0–2, después solo MCA |
| «qué hay acá» | `marcos/mcs/MCS-P03-quick-scan.md`, 30 min, y parás |
| «seguimiento» | Solo lo que estaba NO CONFORME, más regresiones |

## Puertas de calidad

- [ ] **Los documentos se leyeron de `marcos/`.** Si no se pudieron leer, se paró y se dijo
- [ ] Los niveles objetivo salieron de `conformidad.yaml`, no de un criterio propio
- [ ] Las banderas rojas se comprobaron antes que los requisitos
- [ ] Todo CONFORME lleva evidencia citada: ruta de archivo, o comando ejecutado y su salida
- [ ] Un control que existe y no se ejecuta se marcó PARCIAL, nunca CONFORME
- [ ] Lo no verificado quedó marcado como tal (TRZ-09)
- [ ] El entregable es **un plan**, no tres informes

---
id: AUDITORIA
titulo: Auditoría de un proyecto contra la familia de marcos
marco: —
capa: operativa
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente
depende_de: [INDICE, ORQUESTADOR, MCA-CORE, MCC-CORE, MCS-CORE]
---

# Auditoría de un proyecto

Cómo se audita un proyecto contra los tres marcos de contenido, en qué orden, y hasta
dónde subirlo.

**No es un marco.** Es la secuencia que los compone, igual que `ORQUESTADOR.md` compone su
carga. Los requisitos viven en cada normativa; aquí vive el orden.

---

# 1. El orden: MCA → MCC → MCS

| # | Marco | Audita | Prompt | Duración |
|---|---|---|---|---|
| 1 | **MCA** | Cómo se trabaja sobre el repositorio | `MCA-P02` | 20–40 min |
| 2 | **MCC** | Qué se acordó con el cliente y por qué | `MCC-CORE` §6 | 1–2 h |
| 3 | **MCS** | Qué se construyó | `MCS-P03` y después `MCS-P01` | 30 min / 2–4 h |

## 1.1 Por qué MCA va primero

Tres razones, en orden de peso:

**Abarata todo lo que sigue.** Las auditorías de MCC y MCS se ejecutan sobre el mismo
repositorio y con el mismo asistente. Si el entorno está en N0 —sin comandos de
verificación declarados, sin saber qué no tocar— cada auditoría posterior gasta la mitad
del tiempo en reconocimiento que ya debería estar escrito.

**Es la más barata y la única sin riesgo.** MCA-N2 son once requisitos y una tarde. MCC y
MCS empiezan en 92 y 204.

**Sus hallazgos cambian los otros dos.** Si MCA-P02 revela que el comando de pruebas
declarado no corre, ya sabés que la cobertura que MCS reporte no significa nada.

## 1.2 Por qué MCC va antes que MCS

Auditar el producto contra los requisitos equivocados es trabajo perdido con apariencia de
rigor.

MCC establece qué se acordó: la pregunta central del encargo, qué queda fuera de alcance,
el nivel MCS propuesto y con qué criterio. **MCS-CORE §4.3 exige que el nivel se justifique
por consecuencia del fallo, sensibilidad de los datos y exigencia de los clientes** — y esos
tres hechos son salida de MCC, no de MCS.

Un producto auditado en N4 que solo necesitaba N2 arroja decenas de no conformidades reales
e irrelevantes. Eso no es una auditoría estricta: es una auditoría mal encuadrada.

## 1.3 Cuándo el orden no aplica

| Situación | Orden |
|---|---|
| No hubo encargo: producto propio | MCA → MCS. MCC no aplica, se declara |
| Hay una bandera roja conocida —credenciales expuestas, fuga entre clientes— | Se resuelve **antes** de auditar nada |
| El proyecto se retira en menos de tres meses | No se audita. Se documenta el retiro |
| Solo se necesita saber qué hay | `MCS-P03` suelto, 30 minutos, y nada más |

---

# 2. Hasta qué nivel subir cada marco

**El nivel se elige por consecuencia del fallo, nunca por aspiración.** Sobredimensionar
consume la capacidad que el proyecto necesita para existir.

| Perfil del proyecto | MCA | MCC | MCS |
|---|---|---|---|
| Experimento propio, vida < 3 meses | N1 | — | N1 |
| Automatización interna en uso | N2 | — | N1 |
| Producto comercial de un cliente | N2 | N1 | N2 |
| Varios clientes con compromisos escritos | N3 | N2 | N3 |
| Datos regulados o certificación exigida | N3 | N2 | N4 |
| Repositorio de conocimiento o notas | N2 | — | N1 parcial |

**MCA-N2 aparece en casi todas las filas.** No es rigor: es que once requisitos que no
añaden ningún riesgo y hacen que el asistente verifique su trabajo se pagan solos en
cualquier proyecto que se toque más de una vez.

## 2.1 La regla de la nivelación

Un proyecto **no sube de nivel en los tres marcos a la vez**. Sube en el que hoy le duele.

Orden de subida cuando hay que elegir:

1. Cualquier gravedad **crítica**, en el marco que sea
2. MCA hasta N2, si no está
3. El marco cuya no conformidad esté produciendo el problema que motivó la auditoría
4. El resto, por relación entre impacto y esfuerzo

Subir MCS de N2 a N3 mientras MCA sigue en N0 es la combinación más cara: se añaden
requisitos de proceso a un entorno donde nadie puede comprobar si se cumplen.

---

# 3. Modos de ejecución

| Modo | Qué hace | Cuándo |
|---|---|---|
| **Completa** | Los tres marcos en orden, con plan consolidado | Proyecto nuevo en cartera, o revisión anual |
| **Por marco** | Solo uno | Cambió algo de ese ámbito, o seguimiento |
| **De seguimiento** | Solo lo que estaba NO CONFORME, más regresiones | Trimestral sobre lo ya auditado |
| **Reconocimiento** | `MCS-P03` y la Etapa 1 de `MCA-P02` | 30 minutos, antes de decidir si vale la pena |

En modo completo, el resultado es **un solo plan**, no tres. Las acciones de los tres
marcos se ordenan juntas por impacto sobre esfuerzo, porque el esfuerzo sale del mismo
sitio.

---

# 4. Registro

Cada auditoría se registra en el repositorio auditado, no en este:

```
docs/conformidad/
├── AAAA-MM-DD-mca.md
├── AAAA-MM-DD-mcc.md
├── AAAA-MM-DD-mcs.md
└── plan.md              ← consolidado, el único que se consulta a diario
```

Y la declaración en la raíz, con un nivel por marco:

```yaml
# conformidad.yaml
proyecto: ""
responsable: ""
evaluado: 2026-08-02
marcos:
  MCA: { objetivo: N2, alcanzado: N1 }
  MCC: { objetivo: N1, alcanzado: N1 }
  MCS: { objetivo: N2, alcanzado: N1 }
proxima_evaluacion: 2026-11-02
```

**La serie temporal de nivel alcanzado por marco es más útil que cualquier informe
aislado.** Un informe dice dónde estás; la serie dice si el sistema mejora o si cada
auditoría encuentra lo mismo.

---

# 5. Antipatrones

1. **Auditar los tres marcos a la vez y entregar tres informes.** Nadie los lee. El
   entregable es un plan.
2. **Empezar por MCS porque es el que tiene más requisitos.** Cantidad no es prioridad.
3. **Auditar sin haber fijado el nivel objetivo.** Sin objetivo, toda auditoría devuelve
   «no conforme» a casi todo y no informa ninguna decisión.
4. **Subir de nivel en respuesta a la auditoría en vez de al riesgo.** La auditoría mide;
   no decide el objetivo.
5. **Repetir la auditoría con un prompt distinto cada vez.** El valor está en la
   comparación, y comparar exige el mismo instrumento.
6. **Registrar el informe y no el plan.** El informe se archiva; el plan se trabaja.

# Traza de ejecución

Cierra **MCA AUT-05** y alimenta **MCS IA-13**. Toda ejecución del rol deja traza con
entrada, herramientas invocadas, salida y coste. Sin excepción de estado: una ejecución
`blocked` deja traza igual que una `done`, y suele ser la más útil de las tres.

## Por qué existe

El informe de cierre le dice al que planifica **qué pasó**. La traza le dice a quien audita
**qué se tocó y cuánto costó**. Son públicos distintos y documentos distintos: mezclarlos
produce un informe que nadie lee y una auditoría que no se puede hacer.

Sin traza, la pregunta «¿esta rama la escribió una persona o una sesión sin supervisión, y
con qué permisos?» no tiene respuesta a los tres meses.

## Dónde vive

```
.claude/trazas/AAAA-MM-DD-<id-corto>.yaml
```

En el repositorio **auditado**, no en este. Se versiona: una traza fuera del control de
versiones es una traza que se pierde en el primer árbol de trabajo que se descarta.

## Esquema

```yaml
id: <corto, único en el día>
rol: task-executor
version_rol: 1.1.0
version_catalogo: 1.0.0

# ── ENTRADA ────────────────────────────────────────────────
entrada:
  contrato_huella: sha256:<...>     # el contrato tal como llegó, no como se interpretó
  goal: <copiado literal>
  lanzado_por: <persona o proceso>
  arbol_de_trabajo: <ruta o rama>

inicio: 2026-08-02T14:03:11Z
fin:    2026-08-02T14:21:40Z

# ── HERRAMIENTAS INVOCADAS ─────────────────────────────────
herramientas:
  - nombre: escritura_de_archivos
    invocaciones: 12
  - nombre: ejecucion_local
    invocaciones: 6
denegadas:                          # lo que se intentó y el catálogo frenó
  - nombre: red_de_lectura
    intentos: 1
    motivo: no_autorizada_por_contrato
autorizaciones_usadas: []           # irreversibles que el contrato habilitó y se usaron

# ── LÍMITES ────────────────────────────────────────────────
limites:
  iteraciones:   { techo: 40,     consumido: 18 }
  tokens_salida: { techo: 120000, consumido: 41200 }
  minutos:       { techo: 30,     consumido: 18 }

# ── SALIDA ─────────────────────────────────────────────────
salida:
  status: done | partial | blocked
  motivo: <presente solo si partial o blocked>
  archivos_tocados:
    - { ruta: src/api/routers/users.py, lineas: "+34 −2" }
  commits:
    - <hash corto> <mensaje>
  verificacion_ejecutada:
    - { comando: "pytest tests/test_users.py -q", resultado: paso }

# ── COSTE ──────────────────────────────────────────────────
coste:
  tokens_entrada: 186400
  tokens_salida: 41200
  # En tokens, nunca en moneda. La tarifa cambia y viviría caducada dentro de la
  # traza; la conversión se hace fuera, contra la tarifa vigente de la fecha.
```

## Reglas

1. **Se escribe al cerrar, pase lo que pase.** Un rol que termina sin traza es un fallo de
   la ejecución, no un detalle de forma.
2. **La huella del contrato es del contrato recibido**, no del interpretado. Es lo que
   permite demostrar después que se ejecutó lo que se pidió.
3. **`denegadas` no se omite cuando está vacía.** Una lista vacía es información: dice que
   el catálogo no tuvo que frenar nada.
4. **Ninguna credencial entra en la traza**, ni siquiera enmascarada. Si un valor podría ser
   un secreto, se escribe la referencia, nunca el valor.
5. **El coste va en tokens.** Ver el comentario del esquema.
6. **No se edita una traza.** Si estaba mal, se escribe otra que la corrija y se conservan
   las dos. Editarla es exactamente lo que la traza existe para impedir.

## Lo que la traza permite responder

| Pregunta | Campo |
|---|---|
| ¿Se ejecutó el contrato que se aprobó? | `entrada.contrato_huella` |
| ¿Tocó algo fuera de lo pedido? | `salida.archivos_tocados` |
| ¿El catálogo frenó algo? | `denegadas` |
| ¿Se acercó a un límite? | `limites` |
| ¿Dijo «hecho» sin verificar? | `salida.verificacion_ejecutada` contra `status` |
| ¿Cuánto cuesta este tipo de tarea? | `coste`, en serie sobre muchas trazas |

La última es la que más rinde con el tiempo: **una traza dice qué pasó una vez; la serie
dice si los contratos están bien desglosados.** Contratos que consumen el 90 % del techo de
iteraciones no son contratos difíciles, son contratos mal partidos.

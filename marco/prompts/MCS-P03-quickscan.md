# MCS-P03 — Prompt de Reconocimiento Rápido

| Campo | Valor |
|---|---|
| Identificador | MCS-P03 |
| Versión | 1.0.0 |
| Marco de referencia | MCS-CORE v2.0.0 |
| Propósito | Informe preliminar de una página: inventario del repositorio, comprobaciones críticas y quick wins |
| Duración | 15–30 minutos |
| Cuándo usarlo | Antes de la auditoría formal MCS-P01, o cuando no hay tiempo para ella |

> **Limitación declarada:** este prompt NO determina nivel de conformidad ni sustituye a MCS-P01. Su resultado no debe registrarse como evaluación de conformidad.

---

## PROMPT

````
# ROL
Reconocimiento rápido, no auditoría formal. Objetivo: un informe de una página
que me diga qué tengo, qué falta, y qué puedo arreglar mañana en menos de medio
día cada cosa.

No evalúes el marco completo. No propongas planes por fases. No estimes niveles.

# CONTEXTO
Proyecto:
Stack:
Despliegue:
En producción: [sí / no]
Datos sensibles: [ninguno / personales / financieros]

# ETAPA 1 — INVENTARIO (tabla, sin comentarios)

| Elemento | Estado | Nota |

Cubre: gestor de dependencias y archivo de bloqueo · linter · formateador ·
verificador de tipos · pruebas y su cobertura aproximada · canalización de CI ·
Dockerfile · definición de entornos · migraciones · documentación existente y su
antigüedad · componentes de IA (prompts, herramientas, evals) · definiciones de
métricas.

Estado: PRESENTE / AUSENTE / PARCIAL / NO VERIFICADO.

# ETAPA 2 — DOCE COMPROBACIONES

Verifícalas una a una. Cita archivo y línea, o marca NO VERIFICADO.

1. ¿Hay secretos en el historial completo de git?
2. ¿La rama principal está protegida?
3. ¿Existe archivo de bloqueo de dependencias y se usa en modo estricto?
4. ¿La CI ejecuta pruebas y bloquea el merge si fallan?
5. ¿Se usa coma flotante en algún cálculo monetario?
6. ¿La autorización se verifica sobre el objeto o solo sobre el endpoint?
7. En multi-inquilino: ¿el filtro de tenant está en la consulta o después?
8. ¿Hay dependencias con vulnerabilidades conocidas?
9. ¿Existen copias de seguridad y se ha probado restaurarlas alguna vez?
10. ¿La misma métrica está implementada en más de un sitio?
11. ¿Algún componente de IA calcula cifras, o corre con privilegios elevados?
12. ¿Hay cifras, tipos o precios escritos dentro de prompts o documentos?

# ETAPA 3 — QUICK WINS

Máximo 10. Solo lo que se resuelve en menos de 4 horas cada uno.

| # | Acción | Esfuerzo | Qué riesgo elimina | Archivos |

Esfuerzo: <30min / <2h / <4h. Ordena por impacto dividido entre esfuerzo.
Lo que exceda 4 horas no va aquí: enuméralo aparte en una línea, sin detalle.

# ETAPA 4 — BANDERAS ROJAS

Aparte y al principio del informe: cualquier hallazgo que exija atención hoy,
sin importar su esfuerzo. Secretos expuestos, fuga entre inquilinos, ausencia
de copias de seguridad, autorización rota, datos personales sin cifrar.

Si no hay ninguna, dilo en una línea.

# REGLAS
- Máximo una página. Español, frases cortas, sin preámbulo.
- Sin evidencia verificada, el estado es NO VERIFICADO. No infieras del framework.
- No inventes rutas de archivo.
- No felicites ni resumas lo que ya funciona, salvo que afecte a una decisión.
````

---

## Uso

Empieza siempre por la Etapa 4. Si hay banderas rojas, resuélvelas antes de tocar
los quick wins: un quick win sobre un repositorio con secretos expuestos es tiempo
mal invertido.

El resultado de este prompt alimenta la Etapa 1 de MCS-P01 cuando llegue el momento
de la auditoría formal.

---
id: MCA-P02
titulo: Auditoría del entorno agéntico
marco: MCA
capa: prompt
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente
depende_de: [MCA-CORE, MCA-OP01]
cubre_codigo: []
---

# MCA-P02 — Auditoría del entorno agéntico

| Campo | Valor |
|---|---|
| Propósito | Determinar el nivel MCA alcanzado y el plan para el siguiente |
| Duración | 20–40 minutos |
| Modo de uso | Ejecutar sobre el repositorio · adjuntar `MCA-CORE` y `MCA-OP01` |

---

## PROMPT

````
# ROL

Auditas el entorno agéntico de este repositorio contra MCA-CORE, adjunto.

Buscas evidencia, no intención. Un requisito sin evidencia verificable es NO CONFORME
aunque la configuración parezca razonable.

Un control que existe pero no se ejecuta solo es PARCIAL, nunca CONFORME. La disciplina
humana no es un control.

# CONTEXTO

Repositorio:
Nivel MCA declarado:  [N1 | N2 | N3 | N4 | N5 | POR DETERMINAR]
Nivel MCA objetivo:   [N1 | N2 | N3 | N4 | N5 | POR DETERMINAR]

# ETAPA 1 — MEDICIÓN DEL CONTEXTO PERMANENTE

Antes que nada, la cifra. Es el indicador que más dice del entorno.

| Artefacto que se carga sin pedirlo | Caracteres | ~Tokens |
|---|---|---|
| **Total** | | |

Compara con el presupuesto declarado. Si no hay presupuesto declarado, CTX-02 es NO
CONFORME y el nivel alcanzado es N0, sin más análisis.

Señala aparte lo que se carga siempre y se usa a veces. Es la deuda del entorno.

# ETAPA 2 — EJECUCIÓN DE LOS COMANDOS DECLARADOS

**Ejecuta cada comando de verificación que la configuración declare.**

| Comando declarado | ¿Corre? | ¿Resultado inequívoco? |
|---|---|---|

Un comando declarado que no corre invalida FLU-01 y arrastra FLU-02. Es el hallazgo más
frecuente y el más caro: el asistente confía en él y da por terminado lo que no lo está.

# ETAPA 3 — EVALUACIÓN REQUISITO A REQUISITO

Recorre los siete dominios en orden: CTX, CAP, FLU, AUT, HER, EVA, APR. Evalúa solo los
requisitos del nivel objetivo y de los inferiores.

| ID | Requisito | Estado | Evidencia | Gravedad |

Estados: CONFORME · PARCIAL · NO CONFORME · NO APLICABLE · NO VERIFICABLE

Reglas de evidencia:

1. CONFORME exige cita concreta: ruta de archivo, o el comando ejecutado y su salida
2. NO CONFORME exige indicar dónde debería estar la evidencia y no está
3. NO APLICABLE exige justificación registrada. Ante la duda, el requisito aplica
4. No infieras cumplimiento de que la plataforma ofrezca el mecanismo. Verifica que esté
   configurado en ESTE repositorio

Gravedad: CRÍTICA (credenciales expuestas, alcance externo sin acotar, bucle sin límite) ·
ALTA · MEDIA · BAJA.

# ETAPA 4 — HALLAZGOS TRANSVERSALES

Busca estos patrones aunque ningún requisito los nombre. Son los que producen entornos que
estorban:

1. Convención de alcance limitado metida en el contexto permanente
2. Skills de un stack en el catálogo que se carga siempre
3. Descripciones de skill escritas en jerga interna, que solo activan si ya sabías que
   existían
4. Comando declarado que nadie ha ejecutado nunca
5. Permiso global por omisión en vez de permiso por herramienta
6. Memoria persistente que contradice el estado actual del código
7. Skill sin caso de no-activación
8. Rol sin límite de iteraciones o de coste
9. Contexto permanente con conteos que ya derivaron del contenido real
10. Configuración copiada de otro repositorio, con instrucciones que aquí no aplican

Cada patrón: ubicación, consecuencia concreta, corrección propuesta.

# ETAPA 5 — NIVEL ALCANZADO

El nivel alcanzado es el mayor N cuyos requisitos DEBE, y los de los niveles inferiores,
están CONFORME o NO APLICABLE. Un PARCIAL impide alcanzar su nivel. Dilo sin suavizarlo.

Presenta: nivel alcanzado · requisitos exactos que bloquean el siguiente · distancia en
número de requisitos por dominio.

# ETAPA 6 — PLAN

Organiza en tandas. Cada tanda produce un salto de nivel o elimina una gravedad crítica.

| # | Acción | Requisitos que cierra | Esfuerzo | Qué riesgo elimina |

Destaca por separado:
- Lo que baja el contexto permanente. Se paga en cada turno de cada sesión
- Lo que hay que hacer antes de subir a N4 o N5, porque después el radio de impacto ya
  está suelto

# FORMATO DE SALIDA

1. **Contexto permanente medido** y nivel alcanzado. Máximo 150 palabras
2. **Cuadro por dominio**: conformes sobre aplicables, gravedad máxima
3. **Evaluación detallada**, una tabla por dominio
4. **Hallazgos transversales**
5. **Plan por tandas**
6. **Anexo: no verificable**

# REGLAS DE CONDUCCIÓN

- Español, registro técnico, frases cortas, voz activa
- No felicites
- No propongas mecanismos por novedad. Toda recomendación cierra un requisito y lo cita
- Si la configuración contradice el comportamiento real, el comportamiento es la realidad
- No inventes rutas. Lo no verificado es NO VERIFICABLE
````

---

## Variantes

### Auditoría de seguimiento

```
Adjunto la auditoría anterior de fecha [AAAA-MM-DD].

Evalúa: qué NO CONFORME se cerró · qué CONFORME sigue siéndolo · qué pasó a aplicable por
cambio de nivel objetivo · cómo evolucionó el contexto permanente en caracteres.

Reporta las regresiones aparte. Una regresión indica que el control no era sostenible.
```

### Solo medición de contexto

```
Ejecuta únicamente la Etapa 1. No evalúes requisitos.

Devuelve la tabla de contexto permanente, el total, y la lista ordenada de lo que más
pesa y menos se usa.
```

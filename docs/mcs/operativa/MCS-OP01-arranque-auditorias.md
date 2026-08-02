---
id: MCS-OP01
titulo: Arranque de auditorías
marco: MCS
capa: operativa
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCS-CORE, MCS-P01, MCS-P03]
---

# MCS-OP01 — Procedimiento de arranque de auditorías

| Campo | Valor |
|---|---|
| Identificador | MCS-OP01 |
| Versión | 1.0.0 |
| Marco de referencia | MCS-CORE v2.0.0 |
| Objetivo | Dejar corriendo las auditorías de la cartera de proyectos y planificar la llegada al nivel N1 |
| Esfuerzo de arranque | 1 a 2 días para la puesta en marcha, más 2 a 4 horas por proyecto auditado |

---

## Paso 0 — Repositorio de gobierno (2 horas, una sola vez)

Crea un repositorio separado de los productos. Es donde vive el marco y todos los informes.

```
mcs-gobierno/
├── marco/
│   ├── MCS-CORE-normativo.md
│   ├── MCS-P01-prompt-auditoria.md
│   ├── MCS-P02-prompt-consultoria.md
│   ├── MCS-OP01-arranque-auditorias.md
│   └── guias/
│       ├── G01-ciclo-de-vida.md
│       ├── G02-diseno.md
│       ├── G03-ia-agentes.md
│       └── G04-disciplinas-transversales.md
├── cartera/
│   └── cartera.md              # inventario y estado de todos los proyectos
├── auditorias/
│   ├── <proyecto>/
│   │   ├── 2026-08-informe.md
│   │   └── 2026-08-plan.md
└── plantillas/
    ├── mcs.yaml
    └── adr-template.md
```

**Por qué separado:** el marco evoluciona con su propio versionado y aplica a varios productos. Meterlo dentro de un producto lo ata a su ciclo de vida.

---

## Paso 1 — Inventario de la cartera (1 hora)

Lista tus proyectos en `cartera/cartera.md`:

| Proyecto | Estado | Usuarios | Datos que trata | Ingresos | Nivel propuesto | Prioridad |
|---|---|---|---|---|---|---|
| | producción / desarrollo / mantenimiento | | públicos / personales / financieros | | N1–N5 | |

**Criterio de prioridad de auditoría**, en este orden:

1. Está en producción **y** trata datos personales o financieros
2. Genera ingresos
3. Tiene clientes con expectativas contractuales
4. Es el que más vas a seguir desarrollando

Un proyecto en desarrollo sin usuarios se audita al final: cambiar su arquitectura aún es barato, así que el informe caduca rápido.

---

## Paso 2 — Nivel objetivo por proyecto (30 min por proyecto)

Usa la variante **"Evaluación previa a la decisión de nivel"** del prompt MCS-P01. No audites todavía: solo determina a dónde vas.

Regla práctica para tu contexto:

| Situación del proyecto | Nivel objetivo |
|---|---|
| En validación, sin usuarios de pago | **N1** |
| En producción con clientes PYME | **N2** |
| Clientes con contrato y compromiso de disponibilidad | **N3** |
| Cliente empresarial que envía cuestionario de seguridad | **N4** |

> **Empieza todo en N1.** Aunque el objetivo final sea N3, el primer plan es siempre alcanzar N1 completo. No hay atajo: N2 exige N1 íntegro.

---

## Paso 3 — Auditoría piloto (3 horas)

Audita **un solo proyecto** primero. El piloto ajusta el proceso antes de gastarlo en toda la cartera.

**Elige el proyecto de prioridad 1, no el más fácil.** Un piloto sobre un proyecto sencillo produce un informe optimista que no enseña nada.

Procedimiento:

1. Abre Claude Code o Cowork sobre el repositorio del proyecto
2. Adjunta `MCS-CORE-normativo.md`
3. Pega el prompt MCS-P01 con el bloque de contexto completo
4. Deja que ejecute las seis etapas sin interrumpir
5. Guarda el resultado en `auditorias/<proyecto>/AAAA-MM-informe.md`

**Verificación del informe antes de aceptarlo.** El error más común es un informe complaciente. Comprueba:

- [ ] ¿Todo CONFORME lleva cita de archivo y línea?
- [ ] ¿Hay controles marcados CONFORME que en realidad dependen de que alguien se acuerde? Deben ser PARCIAL
- [ ] ¿La sección NO VERIFICABLE está vacía? Si lo está, sospecha: siempre hay algo que no se pudo comprobar
- [ ] ¿El nivel alcanzado es sorprendentemente alto? Revisa los requisitos de CFG, DAT y SEG uno por uno

Si el informe no pasa esta verificación, devuélvelo:

```
Revisa tu informe. Los siguientes requisitos están marcados CONFORME sin cita
de archivo y línea: [lista]. Reevalúalos. Recuerda: sin evidencia verificable,
el estado es NO CONFORME o NO VERIFICABLE.
```

---

## Paso 4 — Auditoría del resto de la cartera (2 horas por proyecto)

Repite el Paso 3 con el prompt ya ajustado. Una sesión por proyecto, sin mezclar.

Al terminar, consolida en `cartera/cartera.md`:

| Proyecto | Nivel objetivo | Nivel alcanzado | Críticas abiertas | Requisitos que faltan para N1 | Esfuerzo estimado |
|---|---|---|---|---|---|

Esta tabla es tu instrumento de gestión. Es lo que revisas cada trimestre.

---

## Paso 5 — Plan de llegada a N1

N1 son 64 requisitos. No se abordan en lista plana: se agrupan en cinco tandas que se pueden ejecutar y cerrar.

### Tanda 1 — Higiene del repositorio (3–5 días)

Cierra: GOB-01, GOB-02, CFG-01 a CFG-06, SEG-02, DEV-04, INT-01 a INT-03, SUM-01, SUM-02

- Declaración `mcs.yaml` en la raíz
- Estructura de directorios y separación de dominio
- Gestor de dependencias con archivo de bloqueo
- Análisis de estilo, formato y tipos en modo estricto
- Hooks previos al commit
- Rama principal protegida, con integración obligatoria por solicitud de cambio
- Canalización con estilo, tipos, pruebas, análisis de seguridad, dependencias vulnerables y detección de secretos
- **Barrido del historial completo en busca de secretos.** Si aparece alguno, rótalo antes de continuar
- Imagen de contenedor con usuario sin privilegios, construida solo en la canalización

**Por qué primero:** es la tanda que hace que todas las demás sean verificables. Sin canalización, los requisitos posteriores dependen de la memoria.

### Tanda 2 — Verificación (4–6 días)

Cierra: REQ-01 a REQ-03, ARQ-03, ARQ-04, DEV-01 a DEV-03

- Definición de terminado escrita
- Separación de la lógica de dominio del framework
- Pruebas separadas por nivel, con la lógica de dominio verificable sin base de datos
- Los doce factores: configuración en el entorno, procesos sin estado, registros a la salida estándar
- Criterios de aceptación verificables y escenarios de calidad con números
- Inventario de datos personales

### Tanda 3 — Coherencia conceptual (4–6 días)

Cierra: LEN-01 a LEN-03, DAT-01 a DAT-06, DAT-09 a DAT-12

- Glosario canónico con los 30 conceptos centrales, en ambos idiomas
- Guía de estilo: tratamiento personal, anglicismos, formato de números
- Unidad canónica por magnitud; sufijo de unidad en los identificadores
- Eliminación de coma flotante en rutas monetarias
- Auditoría de las tres búsquedas: constantes de conversión, familias de sustantivos, condiciones repetidas
- Conceptos derivados unificados en el dominio
- Capa métrica única con ficha por indicador
- Marca de frescura y periodo en todo número presentado

**Advertencia:** esta tanda toca código existente y es la que más tiempo consume por descubrimiento. Presupuesta el doble de lo que estimes.

### Tanda 4 — Seguridad y operación (4–6 días)

Cierra: SEG-01, SEG-03 a SEG-05, INF-01 a INF-03, DES-01 a DES-03, OPS-01 a OPS-03

- Controles de ASVS nivel 1 aplicables, como lista marcada
- Cabeceras de seguridad y cifrado de transporte
- Autorización a nivel de objeto en todos los puntos de acceso
- Política de divulgación responsable
- Entornos separados con paridad de servicios de datos
- Copias de seguridad automáticas
- Despliegue automatizado con verificación de salud y reversión documentada
- Registros estructurados, captura de errores, runbook inicial

### Tanda 5 — Arquitectura, documentación y dominio (3–5 días)

Cierra: ARQ-01, ARQ-02, DIS-01 a DIS-04, DOC-01 a DOC-03, IA-01 a IA-05, CON-01 a CON-05

- Diagramas de contexto y contenedores
- ADR retroactivos de las decisiones ya tomadas
- Tokens de diseño y eliminación de valores literales
- Inventario de estados por pantalla
- Metadatos en todos los documentos; generación de lo generable
- Si hay componentes de IA: identidad propagada, registro de auditoría, límites de coste, ninguna cifra calculada por el modelo
- Si el producto opera sobre una materia especializada: alcance, jurisdicciones y frontera de competencia declaradas

**Total estimado para N1 desde cero: 18 a 28 días de una persona**, por proyecto. Menos si el proyecto ya cumple parte.

---

## Paso 6 — Ejecución con puerta de cierre

Reglas para que el plan no se disuelva:

1. **Una tanda a la vez, y por proyecto.** No abras la Tanda 2 de un proyecto con la Tanda 1 a medias.
2. **Cada tanda se cierra actualizando `mcs.yaml`** con los requisitos que pasan a CONFORME. Si no está en el archivo, no está cerrado.
3. **Todo requisito cerrado debe tener un control automático que lo sostenga.** Un requisito cerrado a mano se reabrirá solo.
4. **Las críticas se atienden fuera de las tandas, de inmediato.** Un secreto en el historial o una fuga entre inquilinos no espera a la Tanda 4.
5. **Reserva el 20% de tu capacidad.** Un plan que consume el 100% del tiempo se abandona en la segunda semana.

---

## Paso 7 — Cadencia permanente

| Frecuencia | Acción |
|---|---|
| Por cambio | Las puertas de la canalización actúan solas |
| Mensual | Revisar críticas abiertas y regresiones en la cartera |
| Trimestral | Auditoría de seguimiento con la variante correspondiente de MCS-P01. Actualizar `cartera.md` |
| Semestral | Revisar el nivel objetivo de cada proyecto: ¿cambió su perfil de riesgo? |
| Anual | Revisar el propio marco: qué requisitos nunca aportaron valor y cuáles faltaron |

La serie temporal de nivel alcanzado por proyecto vale más que cualquier informe aislado. Es lo que muestra si el sistema está funcionando o si solo estás generando documentos.

---

## Secuencia mínima para empezar hoy

```
1. Crea mcs-gobierno/ y copia los seis documentos del marco       30 min
2. Lista tus proyectos en cartera.md                              30 min
3. Elige el proyecto de mayor riesgo en producción                10 min
4. Ejecuta MCS-P01 sobre él, variante completa                     3 h
5. Verifica el informe con la lista del Paso 3                    30 min
6. Extrae las críticas y atiéndelas esta semana                     —
7. Programa la Tanda 1 para la semana siguiente                    15 min
```

Al final del primer día tienes: un nivel real medido, una lista de críticas, y un plan de cinco tandas. Es suficiente para empezar; el resto de la cartera puede esperar a la semana siguiente.

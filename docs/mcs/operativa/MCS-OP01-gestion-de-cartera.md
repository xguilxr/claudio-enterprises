---
id: MCS-OP01
titulo: Gestión de la cartera de proyectos
marco: MCS
capa: operativa
version: 2.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [AUDITORIA, MCS-CORE, MCS-P01, MCS-P03]
---

# MCS-OP01 — Gestión de la cartera de proyectos

Cómo se gobierna un conjunto de proyectos: qué hay, cuál se audita primero, cómo se
consolida el estado y con qué cadencia se revisa.

**No dice cómo se audita un proyecto.** Eso vive en `AUDITORIA.md`.

## Alcance tras el fallo del 2026-08-02

Este documento y `AUDITORIA.md` se pisaban: los dos decían dónde se registran los informes
por proyecto. Un hecho vive en un solo documento (MFB TRZ-02). El fallo del propietario:
**gana `AUDITORIA.md`; MCS-OP01 se queda con la cartera.**

| Asunto | Dónde vive ahora |
|---|---|
| Orden de auditoría entre marcos | `AUDITORIA.md` §1 |
| Nivel objetivo por perfil de proyecto | `AUDITORIA.md` §2 |
| Regla de nivelación | `AUDITORIA.md` §2.1 |
| Modos de ejecución | `AUDITORIA.md` §3 |
| Dónde se registran informes y plan | `AUDITORIA.md` §4 — **en el repositorio auditado** |
| Inventario de la cartera y prioridad | Aquí, §2 y §3 |
| Consolidación entre proyectos | Aquí, §4 |
| Cadencia de gobierno | Aquí, §5 |
| Descomposición de MCS N1 en tandas | Aquí, Anexo A |

Lo que se retiró en v2.0.0, y por qué:

- **`auditorias/<proyecto>/` en el repo de gobierno.** Los informes van al repositorio
  auditado (`AUDITORIA.md` §4). Tenerlos en dos sitios garantiza que uno quede viejo.
- **`marco/` con copias de los documentos.** El marco vive en este repositorio y se
  referencia por identificador (TRZ-03). Copiarlo creaba una segunda versión que envejece.
- **La tabla de nivel objetivo del antiguo Paso 2.** Decidía lo mismo que `AUDITORIA.md` §2
  y solo para MCS. La de `AUDITORIA.md` decide para los tres marcos.
- **El antiguo Paso 3, auditoría piloto.** Es procedimiento de auditoría, no de cartera.

---

# 1. Repositorio de gobierno

Un repositorio separado de los productos, **solo para la cartera**:

```
gobierno/
└── cartera/
    └── cartera.md          # inventario y estado de todos los proyectos
```

Eso es todo. Si te encontrás añadiéndole informes o copias del marco, volviste al problema
que este fallo resolvió.

**Por qué separado de los productos:** la cartera abarca a todos y no pertenece a ninguno.
Meterla dentro de un producto la ata a su ciclo de vida y la vuelve invisible desde el resto.

---

# 2. Inventario

| Proyecto | Estado | Usuarios | Datos que trata | Ingresos | Perfil | Objetivo MCA · MCC · MCS |
|---|---|---|---|---|---|---|
| | producción / desarrollo / mantenimiento | | públicos / personales / financieros | | ver `AUDITORIA.md` §2 | |

**El perfil se toma de la tabla de `AUDITORIA.md` §2**, no se inventa aquí. Y el objetivo es
uno por marco: un proyecto puede necesitar MCA N3 y MCS N2 a la vez.

Todo proyecto entra al inventario, incluidos los que no se van a auditar. Un proyecto que no
figura es un proyecto sobre el que nadie decidió nada.

---

# 3. Prioridad de auditoría

En este orden:

1. Está en producción **y** trata datos personales o financieros
2. Genera ingresos
3. Tiene clientes con expectativas contractuales
4. Es el que más vas a seguir desarrollando

Un proyecto en desarrollo sin usuarios se audita al final: cambiar su arquitectura todavía
es barato, así que el informe caduca rápido.

**Excepción que se salta la lista:** una bandera roja conocida —credenciales expuestas, fuga
entre clientes— se resuelve antes de auditar nada, en el proyecto que sea
(`AUDITORIA.md` §1.3).

---

# 4. Consolidación

Al cerrar cada auditoría, se lleva el resultado a `cartera.md`:

| Proyecto | Objetivo MCA·MCC·MCS | Alcanzado MCA·MCC·MCS | Críticas abiertas | Esfuerzo a objetivo | Última auditoría |
|---|---|---|---|---|---|

Esta tabla es el instrumento de gestión y lo único que se revisa a diario. El informe de cada
proyecto se consulta cuando hace falta el detalle; esta tabla, siempre.

**Se consolida el estado, nunca los informes.** Copiar aquí lo que ya está en el repositorio
auditado reabre el problema que el fallo cerró.

---

# 5. Cadencia

| Frecuencia | Acción |
|---|---|
| Por cambio | Las puertas de la canalización actúan solas |
| Mensual | Revisar críticas abiertas y regresiones en la cartera |
| Trimestral | Auditoría de seguimiento donde toque, y actualizar `cartera.md` |
| Semestral | Revisar el objetivo de cada proyecto: ¿cambió su perfil de riesgo? |
| Anual | Revisar los propios marcos: qué requisitos nunca aportaron y cuáles faltaron |

**La serie temporal de nivel alcanzado por proyecto vale más que cualquier informe aislado.**
Un informe dice dónde estás; la serie dice si el sistema mejora o si cada auditoría encuentra
lo mismo.

---

# Anexo A — Descomposición de MCS N1 en tandas

MCS N1 son 64 requisitos. En lista plana no se ejecutan; agrupados en cinco tandas, sí.

> **Esto alimenta el plan, no lo sustituye.** En una auditoría completa el resultado es **un
> solo plan** con las acciones de los tres marcos ordenadas juntas (`AUDITORIA.md` §3). Estas
> tandas son cómo se descompone la parte MCS de ese plan.

### Tanda 1 — Higiene del repositorio (3–5 días)

Cierra: GOB-01, GOB-02, CFG-01 a CFG-06, SEG-02, DEV-04, INT-01 a INT-03, SUM-01, SUM-02

- Declaración `mcs.yaml` en la raíz
- Estructura de directorios y separación de dominio
- Gestor de dependencias con archivo de bloqueo
- Análisis de estilo, formato y tipos en modo estricto
- Hooks previos al commit
- Rama principal protegida, con integración obligatoria por solicitud de cambio
- Canalización con estilo, tipos, pruebas, análisis de seguridad, dependencias vulnerables y
  detección de secretos
- **Barrido del historial completo en busca de secretos.** Si aparece alguno, rótalo antes de
  continuar
- Imagen de contenedor con usuario sin privilegios, construida solo en la canalización

**Por qué primero:** es la tanda que hace verificables a todas las demás. Sin canalización,
los requisitos posteriores dependen de la memoria.

### Tanda 2 — Verificación (4–6 días)

Cierra: REQ-01 a REQ-03, ARQ-03, ARQ-04, DEV-01 a DEV-03

- Definición de terminado escrita
- Separación de la lógica de dominio del framework
- Pruebas separadas por nivel, con la lógica de dominio verificable sin base de datos
- Los doce factores: configuración en el entorno, procesos sin estado, registros a la salida
  estándar
- Criterios de aceptación verificables y escenarios de calidad con números
- Inventario de datos personales

### Tanda 3 — Coherencia conceptual (4–6 días)

Cierra: LEN-01 a LEN-03, DAT-01 a DAT-06, DAT-09 a DAT-12

- Glosario canónico con los conceptos centrales, en ambos idiomas
- Guía de estilo: tratamiento personal, anglicismos, formato de números
- Unidad canónica por magnitud; sufijo de unidad en los identificadores
- Eliminación de coma flotante en rutas monetarias
- Auditoría de las tres búsquedas: constantes de conversión, familias de sustantivos,
  condiciones repetidas
- Conceptos derivados unificados en el dominio
- Capa métrica única con ficha por indicador
- Marca de frescura y periodo en todo número presentado

**Advertencia:** toca código existente y es la que más tiempo consume por descubrimiento.
Presupuestá el doble de lo que estimes.

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
- Si hay componentes de IA: identidad propagada, registro de auditoría, límites de coste,
  ninguna cifra calculada por el modelo
- Si el producto opera sobre una materia especializada: alcance, jurisdicciones y frontera de
  competencia declaradas

**Total estimado para MCS N1 desde cero: 18 a 28 días de una persona**, por proyecto. Menos
si el proyecto ya cumple parte.

---

# Anexo B — Reglas de ejecución

Para que el plan no se disuelva:

1. **Una tanda a la vez, y por proyecto.** No abras la Tanda 2 de un proyecto con la Tanda 1
   a medias.
2. **Cada tanda se cierra actualizando la declaración de conformidad** con los requisitos que
   pasan a CONFORME. Si no está en el archivo, no está cerrado.
3. **Todo requisito cerrado necesita un control automático que lo sostenga.** Un requisito
   cerrado a mano se reabre solo.
4. **Las críticas se atienden fuera de las tandas, de inmediato.** Un secreto en el historial
   o una fuga entre inquilinos no espera a la Tanda 4.
5. **Reservá el 20 % de tu capacidad.** Un plan que consume el 100 % del tiempo se abandona en
   la segunda semana.

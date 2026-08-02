---
id: MCS-OP03
titulo: Evidencia, control de cambios y certificación
marco: MCS
capa: operativa
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCS-CORE, MCS-OP01, MCS-P01]
---

# MCS-OP03 — Evidencia, control de cambios y certificación

Procedimiento para los niveles **N4 (auditable)** y **N5 (corporativo)**. Cubre los
42 requisitos de esos niveles, que son mayoritariamente de evidencia, aprobación
y conservación.

No aplicar por debajo de N3. Ver MCS-CORE §4.3.

---

## 1. El obstáculo estructural: N4 y N5 exigen una segunda persona

Requisitos que **no se pueden cumplir en solitario**, por definición:

| Requisito | Exige |
|---|---|
| GOB-06 | Segregación entre desarrollo, aprobación y despliegue |
| CFG-19 | Aprobación de cambios por persona distinta del autor |
| DEV-08 | Revisión por persona distinta del autor |
| ARQ-08 | Revisión arquitectónica por tercero |
| DES-09 | Aprobación registrada de despliegues |
| SEG-12 | Prueba de intrusión por tercero independiente |
| DIS-11 | Auditoría de accesibilidad por tercero |
| CON-17 | Evaluación de competencia por tercero cualificado |
| GOB-05 | Procedimiento de aprobación de cambios al marco |

**No hay atajo técnico.** Las tres salidas reales:

| Salida | Cuándo sirve | Coste |
|---|---|---|
| **Revisor externo contratado** | Revisión de PR y aprobación de despliegues por un desarrollador senior con acceso al repositorio | Horas mensuales |
| **Auditor independiente** | Pruebas de intrusión, accesibilidad, competencia de dominio | Encargo por evento |
| **No conformidad documentada** | Se registra la exclusión con riesgo aceptado y fecha de revisión (GOB-02) | Impide declarar N4 |

La tercera es honesta y frecuente. Lo que no es admisible es declarar N4 sin
cumplir estos requisitos: convierte la declaración en ficción y destruye el valor
de todo el registro de conformidad.

---

## 2. Registro de evidencia

### 2.1 Qué se conserva

| Evidencia | Origen | Requisitos que sostiene |
|---|---|---|
| Resultado de cada ejecución de la canalización | CI | INT-08, DEV-09 |
| Inventario de componentes por entrega | Construcción | SUM-03, SUM-08 |
| Firma y procedencia del artefacto | Construcción | SUM-05, SUM-06 |
| Inventario de línea base por entrega | Despliegue | CFG-17 |
| Aprobación de cambio, con autor y aprobador | Solicitud de cambio | CFG-19, DES-09 |
| Registro de acceso a producción | Plataforma | INF-11 |
| Registro de auditoría de acciones sensibles | Aplicación | SEG-07, IA-02 |
| Informe de evaluación de conformidad | MCS-P01 | GOB-03, GOB-07 |
| Análisis posterior a incidente | Operación | OPS-09 |
| Revisión de accesos | Trimestral | SEG-13 |
| Informe de prueba de intrusión | Tercero | SEG-12 |
| Validación experta del corpus | Persona experta | CON-13, CON-15 |

### 2.2 Cómo se conserva

- **Inmutable y fechada.** Un registro editable no es evidencia.
- **Vinculada a una línea base**, identificada por el resumen criptográfico del
  artefacto (CFG-16, CFG-17).
- **Recuperable en minutos.** Una evidencia que tarda una semana en localizarse
  no sirve en una auditoría.
- **Periodo de conservación declarado.** Por defecto tres años (GOB-07); más si
  lo exige un contrato o una norma aplicable (CFG-23).

### 2.3 Estructura

```
evidencia/
├── <AAAA>/
│   ├── conformidad/        informes de MCS-P01, uno por evaluación
│   ├── entregas/           por entrega: línea base, SBOM, procedencia, aprobación
│   ├── incidentes/         análisis posteriores y acciones cerradas
│   ├── accesos/            revisiones trimestrales
│   ├── terceros/           intrusión, accesibilidad, competencia de dominio
│   └── dominio/            validaciones expertas del corpus
└── retencion.md            periodo por clase, y su fundamento
```

---

## 3. Control formal de cambios

### 3.1 Qué lo requiere (CFG-22)

Solo estos cuatro. Extenderlo a todo cambio paraliza el desarrollo sin reducir
riesgo:

1. Interfaces públicas de programación
2. Esquemas de datos con migración no reversible
3. Controles de seguridad y modelo de autorización
4. Definiciones de indicador que afecten a decisiones o a compromisos

### 3.2 Registro mínimo por cambio

```yaml
cambio: CC-2026-014
tipo: esquema-datos
descripcion: >
solicitante:
aprobador:                    # distinto del solicitante (CFG-19)
fecha_aprobacion:
requisitos_afectados: [DAT-19, CFG-11]
analisis_impacto:             # documentos y consumidores afectados (DOC-06)
plan_reversion:
ventana: 
resultado:                    # aplicado | revertido | parcial
evidencia: evidencia/2026/entregas/CC-2026-014/
```

### 3.3 Cambio de emergencia (DES-10)

Se ejecuta sin aprobación previa, y **se regulariza en 48 horas** con registro
retroactivo, justificación y análisis posterior. Un cambio de emergencia que no
se regulariza es una no conformidad, no una excepción.

---

## 4. Ciclo anual

| Cuándo | Actividad | Salida |
|---|---|---|
| Enero | Planificación: nivel objetivo por producto, calendario de terceros, presupuesto | Plan anual |
| Trimestral | Evaluación de conformidad con MCS-P01, variante de seguimiento | Informe + `mcs.yaml` actualizado |
| Trimestral | Revisión de accesos y de privilegio mínimo | Registro (SEG-13) |
| Semestral | Revisión del corpus de dominio por persona experta | Registro (CON-15) |
| Anual | Auditoría interna: verificación de que la línea base declarada coincide con producción | Informe (CFG-21) |
| Anual | Revisión arquitectónica contra escenarios de calidad | Informe (ARQ-07) |
| Anual | Ejercicio de continuidad: restauración completa desde cero | Registro cronometrado (INF-10) |
| Según norma | Prueba de intrusión por tercero | Informe (SEG-12) |
| Continuo | Vigilancia de cambios normativos aplicables | Actualización del corpus (CON-16) |

**Regla de honestidad:** una actividad no ejecutada se registra como no ejecutada.
Un calendario con casillas marcadas sin evidencia detrás es peor que no tenerlo.

---

## 5. Mapeo a certificaciones

Al llegar a N4 tienes hecha la mayor parte de la evidencia que piden los marcos
de certificación. Lo que falta suele ser gobernanza documental, no práctica
técnica.

| Certificación | Qué cubre ya tu N4 | Qué falta |
|---|---|---|
| **SOC 2 Tipo II** | Control de cambios, accesos, registro de auditoría, respuesta a incidentes, copias verificadas | Políticas escritas, gestión de proveedores, formación, periodo de observación de 6–12 meses |
| **ISO/IEC 27001** | Controles técnicos del anexo A en su mayor parte | Sistema de gestión: análisis de riesgos, declaración de aplicabilidad, dirección, auditoría interna |
| **ISO/IEC 42001** | Inventario de IA, evaluación de riesgo, trazas, validación experta (CON, IA) | Política de IA, roles, evaluación de impacto, mejora continua |

**Orden recomendado:** N4 completo primero, certificación después. Intentar
certificar sin la práctica técnica produce un sistema de gestión que documenta
controles que nadie ejecuta, y eso se detecta en la primera auditoría de
seguimiento.

---

## 6. Puerta de cierre de N4

- [ ] Segunda persona resuelta: revisor identificado, o exclusiones registradas
- [ ] Estructura de evidencia operativa, con periodo de conservación declarado
- [ ] Control formal de cambios activo para los cuatro tipos del §3.1
- [ ] Calendario anual publicado y con responsable
- [ ] Auditoría interna de configuración ejecutada al menos una vez
- [ ] Terceros contratados para intrusión, accesibilidad y competencia de dominio
- [ ] `mcs.yaml` refleja el nivel alcanzado real, no el aspirado

## 7. Puerta de cierre de N5

- [ ] Segregación efectiva de funciones (GOB-06), no simulada
- [ ] Comité o procedimiento formal de control de cambios (CFG-22)
- [ ] Infraestructura reconstruible íntegramente desde el repositorio (INF-12)
- [ ] Ejercicios de fallo controlado en calendario (OPS-13)
- [ ] Sistema de gestión de seguridad conforme a ISO/IEC 27001 (SEG-14)
- [ ] Sistema de gestión de IA conforme a ISO/IEC 42001, si aplica (IA-18)
- [ ] Evidencia conservada según obligaciones contractuales (CFG-23)
- [ ] Auditoría interna anual y externa según certificación

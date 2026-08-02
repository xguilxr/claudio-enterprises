---
id: ORQUESTADOR
titulo: Orquestador entre marcos
marco: —
capa: operativa
version: 1.1.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
depende_de: [INDICE, MFB-CORE, MCS-CORE, MCC-CORE]
---

# Orquestador entre marcos

## El problema que resuelve

Un cuerpo normativo de 348 requisitos aplicado a todo momenta la operación
diaria y termina abandonado. El riesgo real de este proyecto no es que los
marcos sean insuficientes: es que estorben.

> **Regla fundamental: por defecto no se carga nada. El estándar entra cuando la
> tarea lo pide, y sale cuando termina.**

Un marco que hay que recordar cargar es un marco que se olvida. Un marco que se
carga siempre es un marco que se ignora. La solución es la activación por
disparador.

---

## 1. Los cuatro niveles de carga

| Nivel | Qué está cargado | Coste de contexto | Cuándo |
|---|---|---|---|
| **L0 — Inerte** | Nada | Cero | Conversación normal, exploración, dudas sueltas |
| **L1 — Convenciones** | `INSTRUCCIONES-PROYECTO.md` | ~2 páginas | Siempre, en este proyecto |
| **L2 — Trabajo** | La guía o el prompt de la tarea concreta | 1 documento | Al ejecutar una tarea del marco |
| **L3 — Conformidad** | El normativo completo del marco | Documento grande | Solo en auditoría |

**L1 es lo único permanente.** Contiene convenciones de redacción y reglas de
encaje, no requisitos. Cabe en dos páginas y no interfiere.

**L3 nunca se carga fuera de una auditoría.** El normativo existe para
verificar, no para trabajar.

---

## 2. Tabla de ruteo

Qué cargar según lo que estás haciendo. Nada más.

| Si la tarea es… | Carga | Nivel |
|---|---|---|
| Preguntar, explorar, decidir a grandes rasgos | Nada | L0 |
| Empezar un proyecto nuevo | MCS-OP01 §5 tanda 1 | L2 |
| Revisar un repo por encima | MCS-P03 | L2 |
| Auditar formalmente un producto | MCS-P01 + MCS-CORE | L3 |
| Tomar una decisión de arquitectura | MCS-G01 fase 2 | L2 |
| Diseñar interfaz o componentes | MCS-G02 | L2 |
| Decidir si algo necesita agente o workflow | MCS-G04 track E | L2 |
| Construir una funcionalidad de IA | MCS-G03 capas A0, AC, A6, A7 | L2 |
| Definir un indicador o dashboard | MCS-G04 track M | L2 |
| Nombrar conceptos, escribir textos de UI | MCS-G04 track L + glosario | L2 |
| Conducir un encargo de cliente | MCC-P01 | L2 |
| Entrar a un rubro que no conozco | MCC-P02 | L2 |
| Preparar una propuesta con costos | MCC-G03 + MCC-P03 | L2 |
| Estimar esfuerzo de un alcance | MCC-G03 §2 | L2 |
| Planificar por fases un encargo aprobado | MCC-G01 §5 | L2 |
| Auditar la conducción de un encargo | MCC-CORE | L3 |
| Crear un marco nuevo | MFB-P01 + MFB-CORE | L3 |
| Revisar la coherencia entre marcos | MFB-P02 | L3 |

---

## 3. Disparadores automáticos

El objetivo es que la tabla anterior no haya que consultarla. El mecanismo son
las **skills**: se activan por su descripción, cargan solo lo que necesitan y
liberan el contexto al terminar. Eso es divulgación progresiva.

**Regla de diseño de la descripción de una skill:** debe contener las palabras
que usaría quien la necesita sin conocer el marco.

```
✗ "Aplica los requisitos DAT-09 a DAT-16 del marco MCS"
✓ "Define un indicador o KPI: fórmula, exclusiones, zona horaria y prueba de
   reconciliación. Úsala al crear un dashboard, un informe o una métrica de
   negocio, o cuando dos números no cuadran entre sí."
```

La primera solo se activa si ya sabes que existe. La segunda se activa cuando la
necesitas.

---

## 4. Precedencia entre marcos

Cuando dos marcos aplican a la vez:

1. **MFB gobierna la forma, nunca el fondo.** Dice cómo debe estar escrito un
   marco, no qué debe exigir. MFB nunca contradice el contenido de otro marco.
2. **Entre marcos de contenido, prevalece el más específico** al dominio de la
   tarea. Si MCS y un futuro marco de datos regulan lo mismo, esa regla vive en
   uno solo y el otro la referencia. Ver regla de interconexión 2 en
   `INSTRUCCIONES-PROYECTO.md`.
3. **Ante conflicto real entre normativas, se detiene el trabajo y se corrige el
   marco.** Un conflicto entre normativas es un defecto, no una ambigüedad a
   resolver caso por caso.
4. **El glosario canónico prevalece sobre cualquier marco** en materia de
   terminología. Es el único eje compartido.
5. **MCC gobierna el encargo; MCS gobierna el producto.** Cuando ambos
   aplican, MCC determina qué se acuerda y MCS qué se construye. El nivel de
   conformidad del producto se propone en MCC-ANA-08 y se declara en
   MCC-ENT-07, pero su contenido lo define MCS-CORE.

---

## 5. Composición de niveles

Un producto declara un nivel **por marco**, y pueden ser distintos:

```yaml
conformidad:
  MCS: { objetivo: N2, alcanzado: N1 }
  MFB: { objetivo: N1, alcanzado: N1 }
  MCC: { objetivo: N1, alcanzado: N1 }
```

Un producto puede ser N3 en calidad de software y N1 en otro marco. Es normal y
es correcto: los marcos responden a riesgos distintos.

**Lo que no es admisible** es declarar un nivel alto en un marco y no cumplir el
nivel N1 de otro que sí aplica. Ver MFB-CORE §NIV.

---

## 6. Antipatrones de orquestación

1. **Cargar el normativo para trabajar.** El normativo verifica; las guías
   explican. Trabajar con el normativo abierto produce parálisis.
2. **Aplicar un marco a una tarea que no lo necesita.** Escribir un script de
   diez líneas no requiere ADR ni escenarios de calidad.
3. **Declarar un nivel superior al que se sostiene.** Un N4 declarado y no
   cumplido es peor que un N1 honesto: convierte la declaración en ficción.
4. **Consultar la tabla de ruteo a mano indefinidamente.** Si llevas un mes
   consultándola, faltan skills.
5. **Crear un marco para un tema que es un dominio.** Ver la rúbrica de MFB-G01.

---

## 7. Prueba de que el sistema funciona

El sistema está bien orquestado cuando puedes responder que sí a estas tres:

- [ ] ¿Puedo trabajar un día entero sin abrir ningún documento del marco?
- [ ] Cuando necesito un estándar, ¿aparece sin que yo lo busque?
- [ ] ¿Puedo auditar un producto sin haber recordado nada de memoria?

Si la primera falla, el marco estorba. Si la segunda falla, faltan skills. Si la
tercera falla, el normativo no es autosuficiente.

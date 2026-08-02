---
id: MFB-G01
titulo: Diseño de marcos
marco: MFB
capa: guia
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
depende_de: [MFB-CORE, CONVENCIONES, glosario]
---

# Diseño de marcos

Guía de aplicación de MFB-CORE. Explica el razonamiento; no impone requisitos.

---

# 1. Qué es y qué no es un marco

Un marco codifica una disciplina en forma verificable. No es un manual, ni una
recopilación de buenas prácticas, ni una opinión estructurada con formato de
norma.

| Un marco sí es | Un marco no es |
|---|---|
| Requisitos comprobables con niveles | Lista de consejos |
| Anclado en estándares externos, o declarado como opinión | Autoridad inventada |
| Aplicable parcialmente | Todo o nada |
| Verificable por un tercero | Dependiente del juicio del autor |

**La prueba decisiva:** ¿puede otra persona auditar un producto contra este
marco y llegar al mismo resultado que yo? Si no, no es un marco.

---

# 2. Las cuatro capas y por qué importan

| Capa | Función | Pregunta que responde |
|---|---|---|
| Normativa | Exige | ¿Qué es obligatorio? |
| Guía | Explica | ¿Por qué y cómo? |
| Prompt | Aplica | ¿Cómo lo ejecuto en un caso real? |
| Operativa | Secuencia | ¿En qué orden y cuándo? |

La separación no es burocracia. Tiene dos consecuencias prácticas concretas:

1. **Las guías se reescriben sin romper auditorías.** Puedes mejorar la
   explicación, cambiar ejemplos y actualizar herramientas sin tocar la versión
   mayor de nada.
2. **El normativo cambia poco y su historial significa algo.** Un incremento
   mayor indica que cambió una exigencia real, no que alguien pulió una frase.

El error que destruye esta propiedad es introducir requisitos en una guía. En
cuanto ocurre, la guía queda congelada de facto y el sistema pierde su
capacidad de evolucionar.

---

# 3. La rúbrica de encaje

**La decisión más importante y la que más se equivoca.** Ante un tema nuevo, la
tentación es crear un marco. Casi siempre es un dominio.

Puntuar de 0 a 2 cada dimensión:

| # | Dimensión | 0 | 1 | 2 |
|---|---|---|---|---|
| 1 | Audiencia | La misma persona | Solapa parcialmente | Personas distintas |
| 2 | Ciclo de vida | Cambia por las mismas razones | Parcialmente | Cambia por razones propias |
| 3 | Aplicabilidad | Nunca se necesita por separado | A veces | Se necesita con frecuencia sin el otro |
| 4 | Cuerpo normativo externo | El mismo | Solapa | Normas y estándares propios |
| 5 | Volumen previsto | Menos de 8 requisitos | 8 a 15 | Más de 15 |

| Puntuación | Decisión |
|---|---|
| 0–3 | Sección dentro de una guía existente |
| 4–6 | **Nuevo dominio dentro de una normativa existente** |
| 7–10 | Nueva familia de marco, con su propio prefijo |

## Por qué la asimetría importa

Ampliar un dominio a marco es reversible: se extraen sus requisitos, se les
cambia el prefijo y se referencian desde donde estaban. Cuesta una tarde.

Fusionar dos marcos que nunca debieron separarse es caro: hay identificadores
publicados, auditorías realizadas contra ellos, skills que los invocan y
declaraciones de conformidad que los citan.

**Ante la duda, dominio.**

## Ejemplos trabajados

**Caso: "Gestión de datos y analítica"** aplicado a MCS.
Audiencia 0 (el mismo desarrollador) · Ciclo de vida 1 · Aplicabilidad 1 ·
Normativa externa 2 (ISO 25012 es propia) · Volumen 2.
**Total 6 → dominio.** Es lo que se hizo: DAT dentro de MCS-CORE.

**Caso: "Consultoría"**.
Audiencia 2 (el cliente, no el desarrollador) · Ciclo de vida 2 · Aplicabilidad 2
(se hace consultoría sin construir software) · Normativa externa 1 · Volumen 1–2.
**Total 8–9 → familia nueva.** Justifica el prefijo MCC.

**Caso: "Accesibilidad"**.
Audiencia 0 · Ciclo de vida 1 · Aplicabilidad 0 · Normativa externa 2 (WCAG) ·
Volumen 1.
**Total 4 → dominio, o sección de guía.** Se resolvió como parte de DIS.

---

# 4. Procedimiento de construcción

No saltar pasos. El orden importa: la guía antes que la normativa.

### Paso 1 — Comprobar solapamiento
Buscar el tema en los marcos existentes, aunque esté con otro nombre. Reportar
lo encontrado antes de proponer nada.

### Paso 2 — Aplicar la rúbrica
Declarar la puntuación y la decisión de encaje. Registrarla.

### Paso 3 — Identificar los estándares externos
Qué normas internacionales rigen la materia. Si no existe ninguna, **decirlo**:
un marco sin referencia externa es una opinión estructurada, y debe presentarse
como tal. No inventar autoridad (TRZ-09).

### Paso 4 — Redactar la guía primero
Conceptos, decisiones, ejemplos, antipatrones, puertas de calidad.

Se escribe la guía antes que la normativa porque **los requisitos se descubren
al explicar, no al legislar**. Empezar por la normativa produce requisitos
plausibles pero no verificados contra ningún razonamiento.

### Paso 5 — Extraer los requisitos
Recorrer la guía y extraer cada afirmación que sea comprobable. Cada una se
convierte en requisito numerado.

Las tres pruebas de un requisito:
- **¿Es verificable?** Si no, es consejo y se queda en la guía (NIV-04)
- **¿Es una sola exigencia?** Si contiene "y" uniendo obligaciones separables, son dos (NIV-05)
- **¿Describe resultado o herramienta?** Debe describir resultado (NIV-06)

### Paso 6 — Asignar niveles

| Nivel | Criterio |
|---|---|
| N1 | Su ausencia produce daño real y cuesta poco implementarlo |
| N2 | Necesario para operar comercialmente |
| N3 | Necesario con compromisos contractuales o varios clientes |
| N4 | Necesario para presentar evidencia a un tercero |
| N5 | Necesario solo para certificación o gobernanza formal |

**Regla de calibración:** si un requisito de N1 exige más de un día de trabajo, o
pertenece a N2, o está mal formulado y contiene varios (ACT-06).

Sesgo deliberado hacia N1 y N2: es donde reside el valor. N4 y N5 son en su
mayoría requisitos de evidencia, aprobación y conservación.

### Paso 7 — Declarar los disparadores de activación
En qué situaciones aplica el marco y en cuáles no. Sin esto, el marco se aplica
a todo o a nada (ACT-02).

### Paso 8 — Actualizar el entorno
Índice maestro, glosario, registro de códigos de dominio, orquestador, anexo de
distribución de requisitos.

### Paso 9 — Proponer prompts y skills
Qué procedimientos del marco merecen ejecutarse sin leerlo entero.

### Paso 10 — Auditar contra MFB
Ejecutar MFB-P02. Un marco que no cumple MFB-N1 no se publica.

---

# 5. Anatomía de un documento normativo

Secciones en este orden:

```
0. Control del documento      identificación, historial, convenciones
1. Objeto y campo de aplicación
2. Referencias normativas      los estándares externos, con su alcance
3. Términos y definiciones     solo los propios; el resto va al glosario
4. Modelo de niveles           qué significa cada N en esta materia
5. Requisitos                  agrupados por dominio
6. Evaluación de conformidad   estados y regla de determinación
Anexo A  Distribución de requisitos por nivel
Anexo B  Plantilla de declaración de conformidad
```

**Sobre la sección 3:** define solo los términos propios de la materia que no
existan ya en el glosario canónico. Duplicar una definición es garantizar
divergencia (TRZ-04).

---

# 6. Antipatrones

1. **Marco por tema.** Cada asunto nuevo genera un prefijo. Resultado: ocho
   marcos que se contradicen y ninguno completo.
2. **Requisitos en la guía.** Congela la guía y rompe la propiedad que hacía útil
   la separación de capas.
3. **Requisitos no verificables.** "El código DEBE ser mantenible" no es
   auditable. "La lógica de dominio DEBE ser verificable sin base de datos" sí.
4. **Requisitos que nombran herramientas.** El marco caduca con la herramienta.
5. **Autoridad inventada.** Citar una norma ISO que no dice lo que se afirma es
   el peor fallo posible: destruye la credibilidad de todo el cuerpo.
6. **Todo en N1.** Un N1 de 200 requisitos no lo cumple nadie, y el marco se
   abandona en la primera semana.
7. **Marco que exige adopción íntegra.** Si no aporta valor aplicado
   parcialmente, no se adoptará nunca (ACT-05).
8. **Glosario propio por marco.** El eje común deja de ser común y los marcos se
   separan silenciosamente.
9. **Normativa escrita antes que la guía.** Produce requisitos plausibles sin
   razonamiento detrás. Se detecta porque nadie sabe explicar por qué existen.
10. **Marco sin disparadores.** Nadie sabe cuándo aplicarlo, así que se aplica
    siempre o nunca.

---

# 7. Puertas de calidad

## Antes de publicar un marco
- [ ] Rúbrica de encaje aplicada y registrada
- [ ] Estándares externos identificados, o ausencia declarada
- [ ] Guía escrita antes que la normativa
- [ ] Todo requisito pasa las tres pruebas: verificable, único, orientado a resultado
- [ ] Niveles asignados con sesgo hacia N1 y N2
- [ ] Códigos de dominio verificados como únicos en el anexo B de MFB-CORE
- [ ] Disparadores de activación declarados
- [ ] Índice maestro, glosario y orquestador actualizados
- [ ] MFB-P02 ejecutado, nivel N1 alcanzado

## Antes de crear el siguiente marco
- [ ] El marco anterior alcanzó MFB-N2
- [ ] No hay duplicación de reglas entre marcos
- [ ] El glosario canónico absorbió los términos nuevos

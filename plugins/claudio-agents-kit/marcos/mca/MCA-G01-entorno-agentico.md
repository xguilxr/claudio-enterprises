---
id: MCA-G01
titulo: El entorno agéntico de un proyecto
marco: MCA
capa: guia
version: 1.0.0
estado: vigente
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCA-CORE, CONVENCIONES, glosario]
cubre_codigo: []
---

# El entorno agéntico de un proyecto

Guía de aplicación de MCA-CORE. Explica el razonamiento; no impone requisitos.

---

# 1. El problema

Abrís un repositorio y le pedís a Claude que arregle un fallo. Claude lee archivos al azar
durante veinte minutos, propone un cambio que rompe una convención que nadie escribió, dice
que terminó, y no terminó.

El mismo repositorio, equipado: Claude lee el archivo de instrucciones, corre el comando de
pruebas declarado, ve el fallo, lo arregla, vuelve a correr, y te enseña la salida.

La diferencia no es el modelo. Es que alguien dedicó una tarde a decirle dónde está.

**Este marco gobierna esa tarde, y las que siguen.** No gobierna el producto: gobierna el
entorno donde se construye.

## 1.1 Qué NO gobierna

MCS §5.15 (dominio IA) gobierna la inteligencia artificial que **tu producto expone a sus
usuarios**: herramientas bajo la identidad del usuario, evaluaciones, trazas, prohibición de
que un modelo calcule cifras.

MCA gobierna la inteligencia artificial que **construye tu producto**.

Distinto objeto, distintos modos de fallo. MCS-IA falla exponiendo datos de un cliente. MCA
falla desperdiciando tu contexto o dejándote un bucle suelto sobre tu repositorio.

Confundirlos lleva a aplicar requisitos de certificación a tu carpeta `.claude/`, que es
justo lo que MFB ACT-05 previene.

---

# 2. Los cinco niveles

Ordenados por **radio de impacto y supervisión**. Cada salto añade una clase distinta de
fallo, no más cantidad del mismo.

| N | Nombre | Qué gana el asistente | Qué puede romper |
|---|---|---|---|
| **N1** | Orientado | Sabe dónde está y qué no tocar | Nada nuevo. Solo deja de perder el tiempo |
| **N2** | Verificable | Comprueba su propio trabajo antes de decir que terminó | Nada nuevo. Deja de mentir sin querer |
| **N3** | Capacitado | Tiene los procedimientos del proyecto bajo demanda | Aplicar un procedimiento donde no toca |
| **N4** | Conectado | Actúa sobre sistemas fuera del repositorio | Escribir en Notion, mandar un correo, tocar una base |
| **N5** | Autónomo | Corre bucles sin vos en el turno | Todo lo anterior, repetido, sin que mires |

## 2.1 Por qué el orden es este

**N1 y N2 antes que todo** porque son los únicos niveles que no añaden riesgo. Un proyecto
en N2 con un asistente que verifica lo que hace vale más que uno en N4 que no.

**N2 antes que N3** porque una capacidad que no se puede comprobar es una capacidad que no
sabés si funciona. Saltárselo es lo que produce el «listo» sobre trabajo que no está.

**N4 antes que N5, y esto es lo importante.** Un bucle sin supervisión que solo toca el
repositorio se deshace con `git reset`. Un bucle sin supervisión que toca correo,
documentación compartida y producción, no. El orden te obliga a aprender a acotar el
alcance externo **mientras todavía mirás cada turno**, antes de dejar de mirar.

Quien monta servidores externos y bucles autónomos a la vez descubre el radio de impacto
cuando ya se disparó.

## 2.2 Niveles no aplicables

Los niveles son acumulativos, pero un proyecto que nunca alcanzará sistemas externos declara
N4 como no aplicable con justificación registrada, igual que hace MCS. Un proyecto puede ser
N5 sin N4: bucles autónomos que solo tocan su propio repositorio.

## 2.3 Cómo se sube de nivel

N1 y N2 se montan a mano, una vez, en una tarde. **N3 en adelante no se monta: se
destila.** Ver §4.

---

# 3. Dónde va cada cosa

La decisión que más se equivoca es meter en las instrucciones permanentes algo que debería
cargarse bajo demanda. Cuesta contexto en cada turno de cada sesión, para siempre.

| Naturaleza | Dónde va | Cuándo se carga |
|---|---|---|
| Qué es este proyecto, cómo se verifica, qué no tocar | Instrucciones permanentes | Siempre |
| Convención que solo aplica a cierto tipo de archivo | Instrucción de alcance temático | Solo si la tarea toca esos archivos |
| Procedimiento repetible de varios pasos | Skill | Cuando su descripción coincide |
| Detalle extenso de un procedimiento | Archivo de referencia de la skill | Solo si el procedimiento lo pide |
| Algo que debe ocurrir siempre en un punto del ciclo | Automatización del ciclo | Sin intervención |
| Secuencia determinista de varios pasos | Flujo de trabajo | Al invocarlo |
| Bucle que decide su propio orden | Rol | Al delegarle |

**La regla de oro:** si algo se carga siempre y se usa a veces, está en el sitio equivocado.

## 3.1 La prueba del presupuesto

Sumá los caracteres de todo lo que se carga en cada sesión sin que nadie lo pida. Si supera
lo que declaraste, no hace falta discutir: algo tiene que bajar a carga bajo demanda.

Es la única forma de que ACT-01 —*ningún marco debe requerir carga permanente*— sea
verificable en vez de una aspiración.

---

# 4. Destilación — cómo el entorno se construye solo

Escribir skills a mano no escala y no se sostiene: se escriben tres el primer día y
ninguna más. La alternativa es observar el trabajo real y dejar que las skills emerjan
de él.

## 4.1 Las señales

Un procedimiento pide existir cuando aparece alguna de estas:

| Señal | Qué indica |
|---|---|
| Explicás lo mismo en tres sesiones distintas | Falta una skill, o falta en las instrucciones permanentes |
| La misma secuencia de comandos se repite | Falta un flujo de trabajo |
| Corregís lo mismo por tercera vez | Falta una convención declarada, no una capacidad |
| Siempre hay que leer el mismo archivo antes de cierto cambio | Falta una instrucción de alcance temático |
| Un fallo vuelve después de arreglarlo | Falta un caso de evaluación, no un procedimiento |

La última fila importa: **no todo patrón repetido es una skill**. Confundirlos produce
un catálogo lleno de cosas que deberían ser una línea de convención.

## 4.2 La rúbrica de destilación

CON-10 exige criterio declarado. Puntuar de 0 a 2:

| Dimensión | 0 | 1 | 2 |
|---|---|---|---|
| **Repetición** | Ocurrió una vez | 2 o 3 veces | 4 o más en 30 días |
| **Coste de repetirlo** | Trivial | Minutos | Rehacer trabajo, o un error real |
| **Estabilidad** | Cambia cada vez | Varía en los detalles | El procedimiento es el mismo |
| **Especificidad** | Sirve en cualquier proyecto | Sirve para este stack | Solo para este proyecto |
| **Verificabilidad** | No se puede comprobar | Parcial | Hay un comando que lo comprueba |

| Puntuación | Decisión |
|---|---|
| 0–3 | Ruido. Se anota y se olvida |
| 4–5 | Se sigue observando. No se promueve |
| 6–7 | **Candidata.** Se redacta y se propone |
| 8–10 | **Candidata prioritaria.** El coste de no tenerla ya se pagó |

## 4.3 La especificidad enruta sola

Es la dimensión más útil y la que nadie mira:

| Especificidad | Dónde vive la skill |
|---|---|
| 2 — solo este proyecto | En el proyecto |
| 1 — sirve para el stack | Plantilla de proyecto, se instala donde ese stack se use |
| 0 — sirve siempre | Catálogo global |

Sin esta dimensión, todo termina en el catálogo global, que es como el catálogo global se
convierte en 3 500 tokens que se cargan siempre.

## 4.4 La promoción tiene puerta

Una candidata **no se convierte en skill sola**. Exige dos cosas:

1. **Evaluación**: un caso que demuestre que activa cuando debe, y otro que demuestre que
   **no** activa cuando no debe. El segundo es el que casi nadie escribe y el que evita que
   el catálogo se dispare solo.
2. **Aprobación humana.** Un entorno que se escribe capacidades a sí mismo en silencio es
   exactamente lo que MCS IA-10 prohíbe para acciones con efecto.

La captura de patrones sí es automática. La promoción, nunca.

## 4.5 Qué se gana

Un proyecto sube de N1 a N3 **observando el trabajo, no sentándose a escribir capacidades**.
Y las que aparecen están justificadas por uso real, no por lo que alguien imaginó que haría
falta.

El efecto secundario es el que más vale: al cabo de unas semanas, el registro de patrones te
dice en qué se te va el tiempo de verdad.

---

# 5. Alineación con la plataforma

Este marco **no nombra mecanismos**. MFB antipatrón 4 explica por qué: *el marco caduca con
la herramienta que nombra*.

La correspondencia entre cada requisito y el mecanismo que hoy lo satisface vive en
`MCA-OP01`, con revisión cada 30 días. Cuando Anthropic publica algo nuevo, se actualiza ese
documento y la normativa no se toca.

Es la misma separación que hace posible que MCS siga siendo válido aunque cambien las
herramientas de análisis estático.

---

# 6. Antipatrones

1. **Instrucciones permanentes que crecen sin techo.** Cada línea añadida parece gratis y
   ninguna lo es. Sin presupuesto declarado, siempre crecen.
2. **Catálogo global de skills específicas de un stack.** Un proyecto que no usa ese
   stack paga su descripción en cada turno.
3. **Descripciones escritas en la jerga del marco.** *«Aplica los requisitos CAP-01 a
   CAP-04»* solo se activa si ya sabías que existía.
4. **Saltarse N2.** Un asistente que no puede comprobar su trabajo dirá que terminó. No
   miente: no tiene cómo saberlo.
5. **Montar servidores externos y bucles autónomos a la vez.** El radio de impacto se
   descubre cuando ya se disparó.
6. **Un rol donde bastaba una skill.** Ver la rúbrica de MCS-G04. Ante la duda,
   skill.
7. **Promover patrones a skills sin evaluación de no-activación.** El catálogo se
   dispara solo y empieza a estorbar.
8. **Memoria persistente que nadie poda.** Crece, se contradice con el código actual, y
   nadie sabe por qué el asistente insiste en algo que ya no es cierto.
9. **Copiar el entorno de otro proyecto entero.** Se hereda contexto permanente que no
   aplica. Se instala por nivel y por necesidad.
10. **Confundir este marco con el dominio IA de MCS.** Uno gobierna tu entorno, el otro tu
    producto. Aplicar requisitos de certificación a tu carpeta de trabajo la abandona.

---

# 7. Puertas de calidad

## Antes de declarar N1
- [ ] Instrucciones permanentes con stack, comandos de verificación y qué no tocar
- [ ] Presupuesto de contexto permanente declarado
- [ ] Sin cifras vivas ni inventarios que deriven en las instrucciones permanentes
- [ ] Credenciales fuera del repositorio
- [ ] Acciones irreversibles identificadas

## Antes de declarar N2
- [ ] Comandos de verificación ejecutables sin intervención, con resultado inequívoco
- [ ] Definición de terminado comprobable por el propio entorno
- [ ] Lo que debe ocurrir siempre está automatizado, no confiado a la instrucción

## Antes de declarar N3
- [ ] Cada skill cubre un solo procedimiento y declara cuándo NO usarla
- [ ] Detalle extenso en archivos de referencia, no en el cuerpo
- [ ] Cada skill tiene caso de activación y caso de no-activación
- [ ] Registro de patrones activo, con rúbrica de promoción declarada

## Antes de declarar N4
- [ ] Cada servidor externo declarado, con ámbito y radio de impacto
- [ ] Permiso explícito por herramienta, nunca global por omisión
- [ ] Captura de patrones automática

## Antes de declarar N5
- [ ] Rúbrica de MCS-G04 aplicada y registrada por cada rol
- [ ] Catálogo de herramientas, límite de iteraciones y límite de coste declarados
- [ ] Evaluación con umbral que condiciona la publicación
- [ ] Traza con entrada, herramientas, salida y coste

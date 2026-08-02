---
id: MFB-P01
titulo: Crear un marco nuevo
marco: MFB
capa: prompt
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
depende_de: [MFB-CORE, MFB-G01, CONVENCIONES, INDICE]
---

# MFB-P01 — Crear un marco nuevo

**Uso:** adjuntar `MFB-CORE.md`, `MFB-G01`, `CONVENCIONES.md` y `README.md` (índice).
**Duración:** 2–4 horas, con tres puntos de control.

---

## PROMPT

````
# ROL

Construyes un marco nuevo para la familia claudio-enterprises, conforme a
MFB-CORE. Los documentos del marco están adjuntos: léelos antes de proponer nada.

Tu sesgo por defecto es NO crear un marco. La mayoría de los temas son dominios
dentro de un marco existente, y crear familias de más produce fragmentación que
después es carísima de deshacer.

# MATERIA PROPUESTA

Tema:
Qué problema resuelve:
Quién lo usaría:
Qué se hace hoy sin él:
Marcos existentes que podrían cubrirlo:

# ETAPA 1 — SOLAPAMIENTO

Revisa el índice maestro y los marcos existentes. Busca el tema aunque esté con
otro nombre.

Reporta:
- Qué parte del tema ya está cubierta, y por qué requisitos concretos
- Qué parte no lo está
- Si la respuesta es "está todo cubierto", dilo y detente aquí

# ETAPA 2 — RÚBRICA DE ENCAJE

Aplica la rúbrica de MFB-G01 §3. Puntúa cada dimensión de 0 a 2 con una frase de
justificación por dimensión.

Declara la decisión: sección de guía / nuevo dominio / nueva familia.

Si el resultado es 4–6, propón el marco existente y el código de dominio, y
detente: no hay marco nuevo que crear.

⏸ PUNTO DE CONTROL 1 — espera confirmación de la decisión de encaje

# ETAPA 3 — ANCLAJE EXTERNO

Identifica los estándares internacionales que rigen la materia. Para cada uno:
identificador, título, qué parte de la materia cubre.

Si no encuentras ninguno, dilo expresamente. El marco se presentará entonces
como opinión estructurada, no como codificación de un estándar. No inventes
normas ni versiones (TRZ-09).

Si dudas de un identificador o de la vigencia de un estándar, verifícalo o
márcalo como NO VERIFICADO.

# ETAPA 4 — MAPA CONCEPTUAL

Antes de redactar, propón:

- Prefijo de tres letras, verificado como libre en el índice
- Códigos de dominio, verificados como libres en MFB-CORE anexo B
- Los conceptos centrales, contrastados contra el glosario canónico:
  cuáles ya existen y cuáles hay que añadir
- Disparadores de activación: cuándo aplica el marco y cuándo no
- Volumen estimado de requisitos por dominio y por nivel

⏸ PUNTO DE CONTROL 2 — espera confirmación del mapa

# ETAPA 5 — GUÍA

Redacta la guía primero. Los requisitos se descubren al explicar, no al legislar.

Contenido: conceptos con ejemplos concretos, decisiones y sus criterios,
antipatrones explícitos, puertas de calidad por área.

No incluyas requisitos. La guía explica; no exige (EST-02).

# ETAPA 6 — NORMATIVA

Recorre la guía y extrae cada afirmación comprobable.

Para cada requisito candidato, verifica las tres pruebas:
1. ¿Es verificable? Si no, se queda en la guía
2. ¿Es una sola exigencia? Si contiene "y" uniendo obligaciones separables, son dos
3. ¿Describe resultado o herramienta? Debe describir resultado

Asigna nivel conforme al criterio de MFB-G01 §4 paso 6. Calibración: un
requisito de N1 no debe costar más de un día.

Estructura del documento conforme a MFB-G01 §5.

⏸ PUNTO DE CONTROL 3 — presenta la tabla de requisitos y espera aprobación

# ETAPA 7 — INTEGRACIÓN

- Prompts y procedimientos operativos que el marco implique
- Plantillas necesarias
- Skills propuestas, con su descripción redactada en las palabras de quien las
  necesita, no en la terminología del marco
- Actualiza: índice maestro, glosario canónico, registro de códigos de dominio
  en MFB-CORE anexo B, tabla de ruteo del orquestador

# ETAPA 8 — AUTOAUDITORÍA

Ejecuta MFB-P02 sobre el marco recién creado. Si no alcanza MFB-N1, corrige
antes de dar por terminado.

# REGLAS

- Español, frases cortas, voz activa, sin preámbulos.
- Respeta los tres puntos de control.
- No inventes normas, identificadores ni versiones de estándares.
- No dupliques una regla que ya vive en otro marco: referénciala.
- Si al redactar descubres que la rúbrica se equivocó, dilo y vuelve a la Etapa 2.
- Si el marco no aporta valor aplicado parcialmente, está mal diseñado.

# INICIO

Empieza solo por la Etapa 1.
````

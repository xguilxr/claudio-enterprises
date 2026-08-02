---
id: MCC-G01
titulo: El proceso consultivo
marco: MCC
capa: guia
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCC-CORE, CONVENCIONES, glosario]
cubre_codigo: []
---

# El proceso consultivo

Guía de aplicación de MCC-CORE. Explica el razonamiento; no impone requisitos.

---

# 1. Las cinco etapas

El encargo recorre cinco etapas. Cada una tiene una salida propia y una puerta
antes de la siguiente.

| Etapa | Pregunta que responde | Salida | Dominios |
|---|---|---|---|
| **E0 · Encuadre** | ¿Qué encargo es este? | Ficha de encargo | CTR, CLI |
| **E1 · Inmersión** | ¿Cómo funciona este negocio? | Dossier y kit de reunión | INV |
| **E2 · Necesidad** | ¿Cuál es el problema real? | Diagnóstico y problema central | ANA |
| **E3 · Propuesta** | ¿Qué caminos hay y cuánto cuestan? | Opciones, arquitectura, costos | PRO, ECO |
| **E4 · Esfuerzo y plan** | ¿Cuánto trabajo y en qué orden? | Estimación y hoja de ruta por tandas | ESF, PLA |
| **E5 · Entrega** | ¿Cómo continúa el cliente sin mí? | Entregables y transferencia | ENT |

E0 no aparece en la lista mental de la mayoría de consultores, y es donde se
pierden los encargos. Un encargo que nunca se encuadró de forma explícita se
desvía sin que nadie lo note, hasta que el cliente y el consultor descubren que
esperaban cosas distintas.

## 1.1 Por qué la inmersión va antes del descubrimiento

La secuencia intuitiva es preguntar al cliente y aprender de él. Es más barata
en apariencia y más cara en realidad.

Un consultor que llega sin conocer el subsegmento gasta la primera reunión en
preguntas que el cliente considera obvias. Obtiene respuestas superficiales,
consume credibilidad y no detecta las anomalías: no puede, porque no sabe qué
es normal en ese rubro.

La inmersión no busca experticia. Busca tres cosas concretas:

1. **Solvencia** — sostener la conversación sin parecer ajeno
2. **Detección de anomalías** — saber cuándo lo que describe el cliente no es
   habitual en su sector
3. **Ubicación del valor** — saber dónde suele estar el dinero que la
   tecnología puede mover en ese rubro

Ver MCC-G02 para el método.

## 1.2 Por qué la necesidad son dos necesidades

El error más frecuente de la etapa E2 es tratar «la necesidad» como una sola
cosa. Son dos, y casi nunca coinciden (ANA-03).

| Necesidad | Quién la tiene | Cómo se detecta |
|---|---|---|
| **Operativa** | El área del cliente | Duele todos los días, y la gente ya inventó parches |
| **Del encargo** | Quien firma | Es lo que quiere poder decir o decidir cuando esto termine |

Ejemplo. Un taller de refacciones pide un catálogo en línea. La necesidad
operativa es que el mostrador tarda ocho minutos en confirmar existencias. La
necesidad del encargo es que el dueño quiere vender a talleres pequeños sin
contratar más vendedores.

Construir el catálogo sin resolver la consulta de existencias satisface la
petición y falla en las dos necesidades. Ese es el modo típico de fracaso:
entregable correcto, problema equivocado.

---

# 2. Encuadre: el contrato de la conversación

La ficha de encargo se cierra antes del descubrimiento (CTR-06). Cinco líneas:

```
Tipo               ARQUITECTURA
Pregunta central   ¿Puede la operación de mostrador sostener 3x volumen sin más personal?
Fuera de alcance   Migración del ERP · nómina · comercio electrónico
Decide             Dueño. Afectados: 4 mostradores, 2 compradores
Éxito              Una decisión de inversión tomada antes del 30 de septiembre
```

El valor de esto no es documental. Es que cuando el trabajo se desvíe —y se
desvía— existe un texto contra el cual señalar la desviación.

## 2.1 Los tres registros que hay que distinguir

Todo el proceso descansa en separar tres cosas que el cliente presenta
mezcladas:

- **Lo que PIDE** — la solución que ya imaginó
- **Lo que NECESITA** — el problema que la produce
- **Lo que PUEDE ABSORBER** — el cambio que su equipo sostendrá sin romperse

Cuando las tres coinciden, el encargo es fácil y raro. Cuando no, decirlo es el
trabajo (ANA-04). Un cliente que elige el camino equivocado con información
completa sigue siendo un cliente bien atendido. Uno al que se le ocultó la
diferencia, no.

---

# 3. Diagnóstico

Cuatro piezas, en orden:

1. **Síntomas** — lo que el cliente observa y le molesta
2. **Causas** — lo que los produce
3. **Problema central** — una sola frase (ANA-02)
4. **Consecuencia de no actuar** — cuantificada si es posible

El cliente casi siempre describe síntomas y los llama causas. «El sistema es
lento» es un síntoma. «Cada consulta de existencias recorre tres sistemas sin
índice común» es una causa.

La regla de la frase única no es estilística. Si el problema central necesita
dos frases, todavía contiene dos problemas, y la propuesta que salga de ahí
tendrá dos centros y ninguno.

## 3.1 La pregunta de la historia previa

La línea más informativa del descubrimiento es la que casi nadie hace:
**qué se intentó antes y por qué no funcionó**.

Un intento fallido previo contiene casi siempre la restricción real del
encargo: un veto de alguien, una integración imposible, un proveedor con
contrato vigente, una capacidad que el equipo no tiene.

Proponer sin conocerlo produce la misma solución que ya fracasó, presentada con
más confianza.

---

# 4. Propuesta

Una sola opción es una imposición disfrazada de recomendación. Por eso PRO-01
exige dos, y exige que difieran en enfoque: la misma idea en tres tamaños no son
tres opciones.

Para cada una: en qué consiste, qué resuelve, qué deja sin resolver, qué debe
ser cierto para que funcione, cómo se revierte.

## 4.1 Arquitectura y stack

La regla que sostiene PRO-04 y PRO-05: **cada elección técnica se justifica
señalando el hallazgo que la motiva**. Si no puedes señalarlo, la elección viene
de costumbre o de moda, y no sobrevive a la primera pregunta incómoda.

| Justificación válida | Justificación inválida |
|---|---|
| «Operación sin red en mostrador → almacenamiento local con sincronía» | «Es lo que más se usa» |
| «Un desarrollador, rotación alta → un solo lenguaje en todo el sistema» | «Escala mejor» |
| «El ERP solo exporta CSV nocturno → integración por archivo, no por API» | «Las APIs son mejores» |

La segunda columna comparte una propiedad: ninguna afirmación menciona al
cliente.

## 4.2 No diseñar por encima del nivel acordado

PRO-09 existe porque el sobrediseño es el error de consultoría más caro y el
más fácil de confundir con rigor. Un cliente que necesita MCS N1 y recibe una
arquitectura de N4 paga tres veces: en construcción, en operación y en el
abandono posterior.

---

# 5. Esfuerzo y plan

Ver MCC-G03 para el método de estimación y costeo.

Sobre el plan: la unidad es la **tanda**, y su prueba es que produce un
resultado observable por sí misma (PLA-03, PLA-04). Una tanda cuyo valor solo
aparece al completar la siguiente está mal diseñada, porque si el encargo se
detiene ahí —y a veces se detiene— el cliente no recibió nada.

Ordenar por relación entre impacto y esfuerzo, respetando dependencias. Señalar
aparte las decisiones estructurales que hay que tomar pronto porque después son
mucho más caras (PLA-06): el modelo de datos, la frontera con los sistemas
existentes, el mecanismo de autenticación.

## 5.1 Medir avance

PLA-07 prohíbe el porcentaje declarado. «Vamos al 70%» no es información: es
una opinión sin unidad. El avance se mide por tandas cerradas con su resultado
observable comprobado.

---

# 6. Entrega y transferencia

El encargo no termina cuando entregas. Termina cuando el cliente puede
continuar sin ti.

ENT-02 es el requisito que más entregables mata, y debe hacerlo. Un documento
que nadie leerá es tiempo del cliente convertido en papel. La prueba es simple:
nombrar la decisión que ese entregable permite tomar. Si no aparece ninguna, no
se produce.

---

# 7. Antipatrones

1. **Encargo sin encuadre.** Si un encargo va mal, casi siempre se rastrea a una
   E0 que nunca se cerró de forma explícita.
2. **Inmersión de rubro, no de subsegmento.** Produce material interesante y
   reuniones mediocres (INV-01).
3. **Descubrimiento sin hipótesis.** Recopila, no diagnostica. Se reconoce
   porque la reunión dura dos horas y no descarta nada.
4. **Solución antes del problema.** El cliente pide adelantar la solución y el
   consultor la da. A partir de ahí, todo el descubrimiento sirve para
   confirmarla.
5. **Opción única.** Presentada como recomendación, funciona como imposición.
6. **Estimación como cifra única.** Un número sin rango es una promesa
   accidental (ESF-02).
7. **Plan optimista.** Erosiona la confianza a mitad de camino, justo cuando
   hace falta pedir una decisión difícil.
8. **Hallazgo suavizado.** Se omite lo incómodo para que el informe agrade. El
   hallazgo reaparece en producción, con testigos (ANA-05).
9. **Sobredimensionar el nivel.** Confundir rigor con exceso. Ver CLI-06.
10. **Entregable de cortesía.** Se produce porque «queda bien», no porque
    cambie una decisión.
11. **Marco entregado al cliente sin recortar.** Un sistema de trabajo que el
    cliente no puede sostener se abandona en dos meses, y su abandono
    desacredita también las partes que servían.
12. **Transferencia implícita.** Se asume que el cliente aprendió por
    proximidad. No aprendió.

---

# 8. Puertas de calidad

## Antes de pasar de E0 a E1
- [ ] Tipo de encargo declarado
- [ ] Pregunta central en una frase
- [ ] Fuera de alcance por escrito
- [ ] Quién decide, identificado por nombre
- [ ] Criterio de éxito comprobable
- [ ] Conflictos de interés declarados

## Antes de pasar de E2 a E3
- [ ] Síntomas y causas separados
- [ ] Problema central en una frase, confirmado por el cliente
- [ ] Necesidad operativa y necesidad del encargo, distinguidas
- [ ] Diferencia entre lo pedido y lo necesario, declarada si existe
- [ ] Nivel MCS propuesto, si hay software

## Antes de entregar la propuesta
- [ ] Dos opciones que difieren en enfoque
- [ ] Cada elección técnica atada a un hallazgo
- [ ] Costos con moneda, fecha y vigencia
- [ ] Exclusiones declaradas
- [ ] Estimaciones como rango, con supuestos que las invalidan
- [ ] Recomendación explícita con su criterio

## Antes de cerrar el encargo
- [ ] Criterio de éxito de E0, evaluado
- [ ] Responsables declarados por cada cosa que queda
- [ ] Indicadores con umbral
- [ ] Nivel MCS alcanzado, si hubo software
- [ ] Estimado contra real, registrado para calibrar

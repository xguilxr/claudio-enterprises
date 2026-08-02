---
id: MCC-G03
titulo: Economía del encargo — costeo y estimación
marco: MCC
capa: guia
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
uso: recurrente
depende_de: [MCC-CORE, MCC-G01, glosario]
cubre_codigo: []
---

# Economía del encargo

Guía de aplicación de los dominios ECO y ESF. Explica el método; no impone
requisitos.

---

# 1. Dos cosas distintas

Costo y esfuerzo se confunden y se calculan juntos. Son problemas diferentes,
con métodos y errores diferentes.

| | Esfuerzo (ESF) | Costo (ECO) |
|---|---|---|
| Mide | Trabajo humano necesario | Dinero que sale, de quien sea |
| Error típico | Optimismo | Omisión |
| Se equivoca por | Lo que no se imaginó | Lo que no se sumó |
| Caduca por | Cambio de alcance | Cambio de precios de terceros |

Un encargo puede tener el esfuerzo bien estimado y el costo mal calculado
porque nadie sumó las licencias. Ocurre a menudo.

---

# 2. Estimación de esfuerzo

## 2.1 Ningún método adivina

Todos los métodos hacen lo mismo: convierten información conocida en un rango.
Ninguno produce certeza, y el que la aparenta está ocultando su supuesto.

| Método | Cuándo sirve | Qué exige |
|---|---|---|
| **Analogía** | Ya hiciste algo parecido | Registro de encargos anteriores |
| **Descomposición** | El alcance está detallado | Lista de piezas de tamaño comparable |
| **Tres puntos** | Alta incertidumbre | Optimista, probable y pesimista por partida |
| **Tamaño funcional** | Contrato formal o licitación | Requisitos estables y método aplicado con rigor |
| **Juicio experto estructurado** | Poca información | Varias personas estimando por separado |

El tamaño funcional tiene norma internacional: ISO/IEC 20926 para el método
IFPUG e ISO/IEC 19761 para COSMIC, ambos dentro del marco conceptual de la
serie ISO/IEC 14143. Es el único de los cinco con respaldo normativo. También
es el más caro de aplicar, y exige requisitos estables que en la etapa de
propuesta rara vez existen.

**Los demás métodos no tienen norma.** Son práctica establecida, no estándar.
Presentarlos como si lo fueran es autoridad inventada.

## 2.2 Descomposición: el método por defecto

Funciona para la mayoría de los encargos:

1. Partir el alcance en piezas que puedas imaginar construyendo
2. Ninguna pieza mayor de cinco días. Si la hay, no la entiendes: pártela
3. Estimar cada pieza en tres puntos
4. Sumar, y añadir las partidas transversales
5. Convertir a calendario con la disponibilidad real
6. Presentar el rango

Las partidas transversales que casi siempre se olvidan: comprender lo
existente, integrar con sistemas ajenos, migrar datos, corregir después de las
pruebas, capacitar, desplegar, esperar decisiones del cliente.

**Comprender lo existente es una partida, no un preámbulo** (ESF-04). En un
sistema heredado sin documentación, puede ser la mayor de todas.

## 2.3 Del esfuerzo al calendario

El error de conversión más común es suponer que una persona rinde cinco días de
trabajo por semana. No ocurre en ningún equipo real.

La disponibilidad efectiva se declara explícitamente (ESF-07). Se mide, no se
supone: la proporción de tiempo que el equipo dedicó a construir en los últimos
encargos. Reuniones, soporte, incidencias, cambios de contexto y ausencias no
son excepciones, son la operación.

Y el esfuerzo no divide el calendario de forma lineal. Dos personas en una tarea
de una persona no la hacen en la mitad de tiempo: añaden coordinación.

## 2.4 Por qué el rango, y por qué se estrecha

ESF-02 prohíbe la cifra única. Una cifra sin rango se convierte en promesa sin
que nadie lo decida.

La incertidumbre depende de la etapa. Al encuadrar un encargo, el mismo alcance
admite interpretaciones que difieren en varios múltiplos. Al terminar el
diseño, difieren en decenas de puntos porcentuales. Este estrechamiento
progresivo se conoce en la literatura de ingeniería de software como cono de
incertidumbre. **Es un concepto de la literatura, no una norma**, y sus valores
concretos dependen de la organización que los mide.

Consecuencia práctica: la estimación se fecha y se ata a una versión del alcance
(ESF-05). Una estimación sin fecha ni versión de alcance no se puede defender,
porque no se sabe qué estaba estimando.

## 2.5 Presión sobre la estimación

Llega siempre, y con la misma forma: «¿no puede ser menos?».

Puede. Pero solo de tres maneras: menos alcance, menos calidad o más riesgo. Las
tres son decisiones del cliente, y las tres se registran (ESF-10).

Bajar el número sin cambiar nada de eso no reduce el trabajo. Solo mueve el
momento en que se descubre.

## 2.6 Calibración

ESF-11 pide registrar el real junto al estimado. Es N3 porque exige varios
encargos para servir de algo.

Su valor aparece al tercer o cuarto encargo: descubres tu sesgo propio y en qué
tipo de partida lo tienes. Casi todo el mundo subestima integración con sistemas
ajenos y sobreestima construcción de interfaz.

---

# 3. Costeo

## 3.1 Las cuatro capas

| Capa | Contiene | Se olvida porque |
|---|---|---|
| **Construcción** | Horas del equipo, una vez | No se olvida |
| **Terceros** | Licencias, servicios gestionados, dominios, certificados | Son cifras pequeñas y muchas |
| **Operación** | Infraestructura, soporte, mantenimiento correctivo | Empieza después de que firmaron |
| **Salida** | Migrar fuera, exportar datos, rescindir contratos | Nadie planea irse al entrar |

ECO-07 exige incluir doce meses de operación. Sin eso, la comparación entre
opciones está sesgada hacia la que es barata de construir y cara de mantener,
que es la trampa habitual.

## 3.2 Cifras vivas

Los precios de terceros son cifras vivas conforme al glosario: caducan. Por eso
ECO-05 obliga a obtenerlos en el momento de la propuesta y a citar la fecha de
consulta.

Un precio de nube copiado de una propuesta de hace ocho meses es una cifra
falsa presentada con formato de dato.

## 3.3 Costos por consumo

El costo de un servicio medido por uso no es un número: es una función del
volumen. Presentarlo como número exige declarar el supuesto de volumen que lo
produce (ECO-06).

Sin ese supuesto, la cifra es indefendible cuando la factura llega distinta, y
el cliente no distinguirá entre un error de cálculo y un engaño.

## 3.4 Reserva

ECO-09 exige una reserva declarada como porcentaje. Declarada, no escondida
dentro de las partidas.

Esconder el colchón inflando cada línea produce dos daños: las partidas dejan de
servir para calibrar, y si el cliente negocia línea por línea, se recorta
justamente el colchón sin que nadie lo sepa.

## 3.5 Modalidad de precio y reparto del riesgo

| Modalidad | Quién asume la incertidumbre | Cuándo es honesto |
|---|---|---|
| Tiempo y materiales | Cliente | Alcance abierto o exploratorio |
| Precio fijo | Proveedor | Alcance cerrado y comprendido |
| Precio fijo por tanda | Repartido | Alcance por etapas, lo habitual |

Precio fijo sobre alcance no comprendido no es un compromiso: es una apuesta
que alguien perderá, y quien la pierda dejará de colaborar en el momento en que
lo descubra.

---

# 4. Antipatrones

1. **Cifra única.** Se convierte en compromiso sin que nadie lo decida.
2. **Estimar solo la construcción.** Se omite entender, integrar, migrar,
   corregir, capacitar y esperar.
3. **Cinco días por semana por persona.** Produce planes con 30% de error antes
   de empezar.
4. **Precio de tercero copiado de una propuesta anterior.** Cifra viva
   caducada.
5. **Costo por consumo sin supuesto de volumen.** Indefendible cuando llega la
   factura.
6. **Colchón escondido.** Impide calibrar y se recorta a ciegas.
7. **Bajar el número sin bajar el alcance.** Mueve el descubrimiento del
   problema, no el problema.
8. **Comparar opciones solo por costo de construcción.** Favorece
   sistemáticamente a la más cara de operar.
9. **Presentar un método sin norma como si la tuviera.** Solo el tamaño
   funcional está normalizado.
10. **No registrar el real.** Garantiza repetir el mismo sesgo indefinidamente.

---

# 5. Puertas de calidad

## Antes de enviar una estimación
- [ ] Método declarado
- [ ] Rango, no cifra
- [ ] Fecha y versión del alcance
- [ ] Supuestos que la invalidan, enumerados
- [ ] Partida de comprender lo existente, incluida
- [ ] Actividades del nivel MCS acordado, incluidas
- [ ] Disponibilidad real declarada en la conversión a calendario
- [ ] Partidas de mayor incertidumbre, señaladas

## Antes de enviar un costeo
- [ ] Moneda, fecha y vigencia
- [ ] Construcción y operación, separadas
- [ ] Doce meses de operación incluidos
- [ ] Licencias y servicios de terceros, con fecha de consulta
- [ ] Supuestos de volumen en los costos por consumo
- [ ] Exclusiones declaradas
- [ ] Reserva declarada como porcentaje
- [ ] Honorarios separados de costos repercutidos

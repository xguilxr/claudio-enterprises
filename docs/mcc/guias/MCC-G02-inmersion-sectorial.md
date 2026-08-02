---
id: MCC-G02
titulo: Inmersión sectorial
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

# Inmersión sectorial

Guía de aplicación del dominio INV. Explica el método; no impone requisitos.

---

# 1. El problema

Los clientes cambian de rubro en cada encargo: restaurantes, administración de
rentas, refacciones automotrices, mesa de servicio. La tecnología se repite; el
negocio no. Y el tiempo disponible para estudiar cada sector es escaso.

La velocidad no viene de leer más rápido. Viene de que **el esqueleto de
preguntas es siempre el mismo, aunque el rubro cambie**. El sector cambia las
respuestas, no las preguntas. Esta guía fija el esqueleto.

---

# 2. Presupuesto de tiempo

Se declara antes de empezar (INV-02). Es un límite, no una aspiración.

| Presupuesto | Alcance | Sirve para |
|---|---|---|
| **T15** · 15 min | Retrato, lenguaje y kit de reunión | Primera llamada exploratoria |
| **T45** · 45 min | Añade operación, panorama tecnológico y dolores | Primera reunión de descubrimiento |
| **T120** · 2 h | Añade cumplimiento, métricas y simulacro | Encargo grande o rubro regulado |

Ante la duda, T45. La mayor parte del valor está en las tres primeras piezas.

Sin límite declarado, la investigación no termina: se abandona a medias y sin
saber qué quedó fuera.

---

# 3. La regla del subsegmento

Nunca trabajar al nivel de «restaurantes» o «bienes raíces». Son categorías
inservibles porque agrupan operaciones incompatibles.

| Rubro | Subsegmentos con operación distinta |
|---|---|
| Restaurantes | Comida rápida con franquicia · casual con mesas · cocina oscura · banquetes |
| Bienes raíces | Corretaje residencial · administración de rentas · desarrollo · industrial |
| Refacciones automotrices | Mostrador · mayoreo a talleres · comercio electrónico · flotillas |
| Mesa de servicio | Interna corporativa · proveedor gestionado · soporte a producto propio |

Un sistema de punto de venta para comida rápida y otro para banquetes no
comparten casi nada: ni el ciclo de venta, ni el inventario, ni el margen, ni
quién opera la pantalla.

Si el subsegmento no está claro, enunciar los tres más probables y la pregunta
que los distingue. Esa pregunta suele ser la primera de la reunión.

---

# 4. El esqueleto

Nueve bloques. El orden importa: los tres primeros bastan para T15.

## 4.1 Retrato del negocio
Cómo entra y sale el dinero.
- Unidad económica: qué se vende, a qué precio típico, con qué margen
- Motor del ingreso: volumen, ticket, recurrencia o comisión. Cuál manda
- Estructura de costo: las tres partidas mayores, en orden
- Qué mata al negocio: el fallo del que no se recupera
- Quién es el cliente del cliente, y cómo decide su compra

Sin esto, el resto es decoración. Una propuesta que no señala qué línea del
estado de resultados mueve no se aprueba, por buena que sea la arquitectura.

## 4.2 Lenguaje
- Glosario operativo: quince a veinticinco términos que el cliente usará
- Sinónimos peligrosos: los que significan cosas distintas en el rubro y en
  tecnología. Los reincidentes: reserva, orden, cuenta, cliente, ticket, cierre
- Errores que delatan: cinco formas de nombrar mal algo que revelan de
  inmediato que no conoces el sector

## 4.3 Kit de reunión
Es la salida principal (INV-05), y se produce siempre, incluso en T15. Ver §5.

## 4.4 Operación
- Procesos núcleo: entre cinco y nueve, en secuencia
- Proceso crítico: aquel cuyo fallo detiene el ingreso ese mismo día
- Día tipo, semana tipo, año tipo: picos, valles, estacionalidad
- Ventanas intocables: cuándo no se puede desplegar nada, y por qué
- Roles reales: quién opera, con qué formación, con qué rotación, con qué
  dispositivo en la mano

La rotación de personal y el dispositivo real de uso determinan más decisiones
de diseño que cualquier requisito funcional. Un sistema para personal que rota
cada tres meses no puede exigir capacitación.

## 4.5 Panorama tecnológico
- Categorías de sistema habituales, con su función
- Incumbentes: lo que ya tiene y no va a cambiar
- Integraciones esperadas, y por qué medio: API, archivo, base de datos, ninguno
- Realidad de los datos: dónde viven hoy, en qué estado, quién los captura
- Restricciones de infraestructura: conectividad, operación sin red, hardware de
  punto de venta, movilidad en campo

## 4.6 Cumplimiento y riesgo
Obligaciones fiscales y documentales, datos sensibles, normativa específica del
rubro, y la consecuencia real del incumplimiento.

Este bloque alimenta la propuesta de nivel MCS del diagnóstico (ANA-08). Un
rubro con datos sensibles o con cierre por incumplimiento no admite N1.

## 4.7 Criterio sectorial
- Dolores recurrentes del subsegmento, ordenados por frecuencia
- Dónde está el valor de la tecnología en este rubro, y qué parece prometedor
  pero no mueve el resultado
- Antipatrones: soluciones que suenan bien en este sector y fracasan
- Señales de alarma en el discurso del cliente

## 4.8 Métricas del rubro
Indicadores que el cliente ya mira, con su fecha y contexto de medición
(INV-09). Una cifra sin condiciones de medición no es un dato.

## 4.9 Actualización posterior
Después de la primera reunión: qué supuesto cayó, qué patrón no aplica a este
cliente, qué términos propios de la casa hay que añadir (INV-11).

Sin este cierre, cada cliente del mismo rubro cuesta la misma inmersión que el
primero. Con él, el segundo cuesta la mitad.

---

# 5. El kit de reunión

Tres piezas. Es lo único que se lleva a la reunión.

**A · Tarjeta de una pantalla.** Media cuartilla: motor del ingreso, proceso
crítico, ocho términos clave, tres dolores probables, dos señales de alarma.
Nada más.

**B · Doce preguntas de alto rendimiento.** Preguntas que solo hace quien conoce
el rubro. Cada una con qué revelaría cada respuesta posible. Ordenadas para que
las cuatro primeras basten si la reunión se acorta.

**C · Mapa de hipótesis.** Tres hipótesis sobre la necesidad real, cada una con
el dato que la confirma o la descarta.

Las hipótesis no se comparten con el cliente. Son la agenda oculta de la
escucha. Entrar sin hipótesis produce una reunión que recopila y no diagnostica.

---

# 6. Rigor de las fuentes

La jerarquía F1–F6 está en MCC-CORE anexo D. Tres consecuencias prácticas:

- Ningún hallazgo se sostiene solo en foros u opinión (INV-08). Sirven para
  formular hipótesis, no para afirmarlas ante el cliente.
- Toda cifra lleva fecha y contexto (INV-09).
- Cuando la fuente vende la solución que recomienda, se señala.

**Sobre inventar.** Una cifra sectorial inventada se detecta en la primera
reunión, porque el cliente vive en ese sector todos los días. El costo no es el
error: es que a partir de ahí revisará todo lo demás que digas. Por eso INV-04
prohíbe afirmar sin fuente identificable, y obliga a escribir «no verificado».

---

# 7. Antipatrones

1. **Investigar el rubro en abstracto.** Tamaño de mercado global, historia del
   sector, tendencias. Material interesante que no cambia ninguna pregunta.
2. **Trabajar al nivel del rubro** en vez del subsegmento.
3. **Confundir el rubro del cliente con el de sus clientes.** Un proveedor de
   software para restaurantes no es un restaurante.
4. **Investigación sin límite de tiempo.** Termina cuando aparece otra urgencia,
   no cuando está completa.
5. **Proponer solución durante la inmersión** (INV-06). Contamina el
   descubrimiento: a partir de ahí solo se escucha lo que confirma la idea.
6. **Dossier sin kit.** Cuarenta páginas que no caben en una reunión de una hora.
7. **No actualizar tras la reunión.** Garantiza repetir la misma inmersión con
   el siguiente cliente del rubro.

---

# 8. Puertas de calidad

## Antes de la primera reunión
- [ ] Subsegmento declarado, no solo el rubro
- [ ] Presupuesto de tiempo declarado y respetado
- [ ] Kit de reunión producido: tarjeta, doce preguntas, tres hipótesis
- [ ] Toda afirmación marcada como hecho, patrón, supuesto o no verificado
- [ ] Ninguna cifra sin fecha ni contexto
- [ ] Ninguna propuesta de solución en el dossier

## Después de la primera reunión
- [ ] Supuestos caídos, marcados
- [ ] Términos propios del cliente, añadidos
- [ ] Dossier archivado e indexado por subsegmento
- [ ] Sin información identificable del cliente en el material reutilizable

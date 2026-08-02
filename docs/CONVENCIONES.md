---
id: CONVENCIONES
titulo: Convenciones de estructura, nomenclatura y redacción
marco: —
capa: normativa-derivada
version: 1.0.0
estado: vigente
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 180d
depende_de: [MFB-CORE]
---

# Convenciones

Desarrollo operativo de los dominios NOM y RED de MFB-CORE. No añade requisitos:
detalla los existentes.

## 1. Nomenclatura de archivos

```
<PREFIJO>-<TIPO><nn>-<descriptor>.md

MCS-G03-ia-agentes.md
MFB-P01-crear-marco.md
MCS-OP01-gestion-de-cartera.md
MCS-CORE.md                     ← el normativo no lleva número
```

| Tipo | Significado | Directorio |
|---|---|---|
| CORE | Documento normativo | raíz del marco |
| G | Guía de aplicación | `guias/` |
| P | Prompt | `prompts/` |
| OP | Procedimiento operativo | `operativa/` |
| T | Plantilla | `plantillas/` |

Descriptor: minúsculas, sin tildes, palabras separadas por guion.

## 2. Estructura de un marco

```
<prefijo>/
├── <PREFIJO>-CORE.md
├── guias/
├── prompts/
├── operativa/
├── plantillas/
├── roles/          ← solo si algún activo supera la rúbrica de autonomía
└── skills/
```

Los directorios vacíos no se crean. Se añaden cuando hay contenido.

## 3. Front-matter obligatorio

```yaml
---
id: MCS-G03
titulo: Inteligencia artificial y agentes
marco: MCS
capa: guia                    # normativa | guia | prompt | operativa | plantilla
version: 0.4.0
estado: vigente               # vigente | obsoleto | reemplazado
reemplazado_por: null
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 90d
uso: recurrente               # recurrente | un solo uso
depende_de: [MCS-CORE, glosario]
cubre_codigo: []              # rutas, si el documento describe código
---
```

Sin `responsable` ni `revisar_cada`, el documento no se acepta (VER-04).

## 4. Redacción

- Español. Registro técnico y sobrio.
- Frases de menos de 25 palabras. Voz activa. Sujeto explícito.
- Evitar el impersonal con "se": oculta quién actúa.
- Un concepto, un término, siempre el del glosario.
- Tablas cuando el contenido es enumerable. Prosa cuando hay razonamiento.
- Ejemplos concretos antes que definiciones abstractas.
- Antipatrones explícitos.
- Sin halagos, sin entusiasmo, sin adjetivos de venta.
- No abrir secciones con recapitulaciones de lo anterior.
- Anglicismos: solo los estándar de la industria, registrados en el glosario.

## 5. Lenguaje normativo

Solo en documentos de capa `normativa`:

| Término | Significado |
|---|---|
| DEBE | Obligatorio. Su incumplimiento es no conformidad |
| NO DEBE | Prohibición absoluta |
| DEBERÍA | Recomendación; omisible con justificación en ADR |
| PUEDE | Permiso; no afecta la conformidad |

## 6. Versionado

| Incremento | Cuándo |
|---|---|
| MAYOR | Se añade, elimina o endurece un requisito, o cambia su nivel |
| MENOR | Se añade guía, ejemplo o anexo sin alterar requisitos |
| PARCHE | Redacción, erratas, enlaces |

Toda modificación de un documento normativo exige entrada en su historial.

## 7. Identificadores de requisito

```
CFG-04
 │   └── secuencial dentro del dominio
 └────── código de dominio, tres letras, único en TODA la familia
```

Inmutables. Un requisito retirado conserva su número marcado como Retirado, y su
número no se reutiliza. Verificar disponibilidad de códigos en MFB-CORE anexo B.

## 8. Referencias cruzadas

Por identificador, nunca por descripción.

```
✓ conforme a CFG-12
✗ conforme a lo establecido sobre versionado de prompts
```

Las descripciones envejecen cuando la guía se reescribe. Los identificadores no.

# marcos/ — copia de publicación

**No edites nada de este directorio.** La fuente es `docs/` del repositorio
`claudio-enterprises`. Esto es una copia que viaja con el plugin.

## Por qué existe

Las skills se instalan en cualquier repositorio; `docs/` solo existe en uno. Sin esta
copia, una skill activada sobre otro proyecto no encuentra su procedimiento y lo
reconstruye de memoria.

Eso produce **auditorías inventadas**, que son peores que no auditar: traen número, tabla y
apariencia de rigor sobre requisitos que nadie leyó.

## Cómo se mantiene

```bash
bash scripts/sincronizar-marcos.sh              # copia docs/ -> marcos/
bash scripts/sincronizar-marcos.sh --verificar  # falla si difieren
```

El manifiesto está dentro del script. Añadir un documento al plugin es añadir una línea
ahí, no copiar el archivo a mano.

**Antes de publicar una versión, corré `--verificar`.** Detecta las tres formas de
despegue: original que desapareció, copia que quedó vieja, y copia huérfana que ya no
está en el manifiesto y envejece sin que nadie la mire.

## Qué no está aquí

Solo viaja lo que las skills necesitan para ejecutarse. Las erratas, la migración, las
convenciones y las plantillas T01–T05 se quedan en `docs/`: se usan al *construir* marcos,
y eso se hace dentro de `claudio-enterprises`.

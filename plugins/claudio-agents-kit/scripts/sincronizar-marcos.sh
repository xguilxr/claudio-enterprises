#!/usr/bin/env bash
# Sincroniza plugins/claudio-agents-kit/marcos/ desde docs/.
#
# POR QUÉ EXISTE: las skills se instalan en cualquier repositorio; `docs/` solo existe
# en este. Sin una copia que viaje con el plugin, una skill activada en otro repositorio
# no encuentra su procedimiento y lo reconstruye de memoria. Eso produce auditorías
# inventadas, que es peor que no auditar.
#
# `docs/` SIGUE SIENDO LA FUENTE (TRZ-02). `marcos/` es una copia de publicación, y este
# script es lo que impide que se despeguen.
#
# Uso:
#   bash scripts/sincronizar-marcos.sh              copia docs/ -> marcos/
#   bash scripts/sincronizar-marcos.sh --verificar  falla si difieren, no copia

set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 1   # raíz del repositorio

DESTINO="plugins/claudio-agents-kit/marcos"

# ── MANIFIESTO ───────────────────────────────────────────────────────────────
# origen -> destino. Solo lo que las skills referencian, más las normativas que
# hacen falta para ejecutar una auditoría sin adjuntar nada a mano.
MANIFIESTO="
docs/AUDITORIA.md|AUDITORIA.md
docs/ORQUESTADOR.md|ORQUESTADOR.md
docs/conocimiento/glosario.yaml|glosario.yaml
docs/mfb/MFB-CORE.md|mfb/MFB-CORE.md
docs/mfb/prompts/MFB-P01-crear-marco.md|mfb/MFB-P01-crear-marco.md
docs/mfb/prompts/MFB-P02-auditar-marco.md|mfb/MFB-P02-auditar-marco.md
docs/mfb/plantillas/MFB-T06-adr.md|mfb/MFB-T06-adr.md
docs/mcs/MCS-CORE.md|mcs/MCS-CORE.md
docs/mcs/prompts/MCS-P01-auditoria.md|mcs/MCS-P01-auditoria.md
docs/mcs/prompts/MCS-P03-quick-scan.md|mcs/MCS-P03-quick-scan.md
docs/mcs/guias/MCS-G04-disciplinas-transversales.md|mcs/MCS-G04-disciplinas-transversales.md
docs/mcc/MCC-CORE.md|mcc/MCC-CORE.md
docs/mcc/prompts/MCC-P01-conduccion-encargo.md|mcc/MCC-P01-conduccion-encargo.md
docs/mcc/guias/MCC-G01-proceso-consultivo.md|mcc/MCC-G01-proceso-consultivo.md
docs/mcc/guias/MCC-G02-inmersion-sectorial.md|mcc/MCC-G02-inmersion-sectorial.md
docs/mcc/guias/MCC-G03-economia-del-encargo.md|mcc/MCC-G03-economia-del-encargo.md
docs/mca/MCA-CORE.md|mca/MCA-CORE.md
docs/mca/guias/MCA-G01-entorno-agentico.md|mca/MCA-G01-entorno-agentico.md
docs/mca/prompts/MCA-P01-andamiaje-entorno.md|mca/MCA-P01-andamiaje-entorno.md
docs/mca/prompts/MCA-P02-auditoria-entorno.md|mca/MCA-P02-auditoria-entorno.md
docs/mca/operativa/MCA-OP01-mapa-de-capacidades.md|mca/MCA-OP01-mapa-de-capacidades.md
"

VERIFICAR=0
[ "${1:-}" = "--verificar" ] && VERIFICAR=1

fallos=0
copiados=0

while IFS='|' read -r origen destino; do
  [ -z "$origen" ] && continue

  if [ ! -f "$origen" ]; then
    echo "  FALTA ORIGEN  $origen"
    fallos=$((fallos+1))
    continue
  fi

  ruta="$DESTINO/$destino"

  if [ "$VERIFICAR" -eq 1 ]; then
    if [ ! -f "$ruta" ]; then
      echo "  SIN COPIA     $destino"
      fallos=$((fallos+1))
    elif ! cmp -s "$origen" "$ruta"; then
      echo "  DESINCRONIZADO $destino"
      fallos=$((fallos+1))
    fi
  else
    mkdir -p "$(dirname "$ruta")"
    cp "$origen" "$ruta"
    copiados=$((copiados+1))
  fi
done <<< "$MANIFIESTO"

# Copia huérfana: está en marcos/ y no en el manifiesto. Envejece sin que nadie la mire.
if [ -d "$DESTINO" ]; then
  esperados=$(echo "$MANIFIESTO" | grep -v '^$' | cut -d'|' -f2 | sort)
  reales=$(cd "$DESTINO" && find . -type f ! -name LEEME.md | sed 's#^\./##' | sort)
  huerfanos=$(comm -13 <(echo "$esperados") <(echo "$reales"))
  if [ -n "$huerfanos" ]; then
    echo "  HUÉRFANO      $(echo "$huerfanos" | tr '\n' ' ')"
    fallos=$((fallos+1))
  fi
fi

echo
if [ "$VERIFICAR" -eq 1 ]; then
  [ "$fallos" -eq 0 ] && { echo "marcos/ sincronizado con docs/"; exit 0; }
  echo "$fallos desincronía(s). Corré el script sin --verificar y bumpeá la versión."
  exit 1
fi

[ "$fallos" -gt 0 ] && { echo "$fallos origen(es) no encontrado(s)."; exit 1; }
echo "$copiados documentos copiados a $DESTINO/"

#!/usr/bin/env bash
# Verificación de coherencia de los artefactos de task-executor.
#
# No evalúa comportamiento —eso son los doce casos de `casos.yaml`—. Verifica que las
# declaraciones del rol no se contradigan entre sí, que es el fallo que más barato sale
# atrapar y el que más silenciosamente rompe una auditoría.
#
# Uso:  bash evaluacion/verificar-coherencia.sh
# Sale con 0 si todo cuadra, 1 si algo no.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

fallos=0
ok()   { printf '  ok    %s\n' "$1"; }
fallo(){ printf '  FALLO %s\n' "$1"; fallos=$((fallos+1)); }

echo "Coherencia de task-executor"
echo

# ── 1. Los artefactos existen ────────────────────────────────────────────────
for f in AGENT.md catalogo.yaml permisos.json \
         referencias/contrato.md referencias/disciplina.md referencias/traza.md \
         evaluacion/casos.yaml evaluacion/README.md; do
  [ -f "$f" ] && ok "existe $f" || fallo "falta $f"
done

# ── 2. Se pueden analizar ────────────────────────────────────────────────────
python3 -c "import yaml,sys; yaml.safe_load(open('catalogo.yaml'))" 2>/dev/null \
  && ok "catalogo.yaml analiza" || fallo "catalogo.yaml no analiza"
python3 -c "import yaml,sys; yaml.safe_load(open('evaluacion/casos.yaml'))" 2>/dev/null \
  && ok "casos.yaml analiza" || fallo "casos.yaml no analiza"
python3 -c "import json,sys; json.load(open('permisos.json'))" 2>/dev/null \
  && ok "permisos.json analiza" || fallo "permisos.json no analiza"

# ── 3. El catálogo no se contradice ──────────────────────────────────────────
# Una herramienta no puede estar en dos listas a la vez.
python3 - <<'PY'
import sys, yaml
c = yaml.safe_load(open('catalogo.yaml'))['herramientas']
p, a, d = set(c['permitidas']), set(c['autorizables']), set(c['denegadas'])
solapes = (p & a) | (p & d) | (a & d)
if solapes:
    print(f"  FALLO herramienta en dos listas: {sorted(solapes)}"); sys.exit(1)
print("  ok    las tres listas de herramientas son disjuntas")
PY
[ $? -ne 0 ] && fallos=$((fallos+1))

# ── 4. Cada límite tiene techo y razón ───────────────────────────────────────
python3 - <<'PY'
import sys, yaml
lim = yaml.safe_load(open('catalogo.yaml'))['limites']
malos = [k for k, v in lim.items()
         if isinstance(v, dict) and 'techo' in v and not v.get('razon')]
faltan = [k for k in ('iteraciones', 'tokens_salida', 'minutos') if k not in lim]
if faltan: print(f"  FALLO AUT-04 sin límite: {faltan}"); sys.exit(1)
if malos:  print(f"  FALLO límite sin razón declarada: {malos}"); sys.exit(1)
print("  ok    los tres límites de AUT-04 tienen techo y razón")
PY
[ $? -ne 0 ] && fallos=$((fallos+1))

# ── 5. El umbral declarado cuadra con los casos que existen ──────────────────
python3 - <<'PY'
import sys, yaml
c = yaml.safe_load(open('evaluacion/casos.yaml'))
s, d = len(c['seguridad']), len(c['disciplina'])
if (s, d) != (6, 6):
    print(f"  FALLO el umbral del README dice 6/6 y >=5/6; hay {s} y {d}"); sys.exit(1)
sin = [x['id'] for x in c['seguridad'] + c['disciplina'] if not x.get('se_falla_si')]
if sin: print(f"  FALLO caso sin criterio de fallo: {sin}"); sys.exit(1)
print("  ok    12 casos, todos con criterio de fallo explícito")
PY
[ $? -ne 0 ] && fallos=$((fallos+1))

# ── 6. Lo irreversible siempre denegado está denegado de verdad ──────────────
# El catálogo declara; permisos.json hace cumplir. Si el segundo no refleja al
# primero, el control es prosa. Se comprueban las familias que se pueden expresar
# como patrón de comando.
python3 - <<'PY'
import sys, json
deny = " ".join(json.load(open('permisos.json'))['permissions']['deny'])
exigidos = {
    "reescribir historial publicado": ["push --force", "push -f", "rebase"],
    "borrar ramas o etiquetas remotas": ["push --delete", "tag -d"],
    "descartar cambios sin versionar": ["reset --hard", "git clean"],
    "efectos sobre sistemas de terceros": ["curl", "ssh", "docker"],
}
faltan = {k: [p for p in v if p not in deny] for k, v in exigidos.items()}
faltan = {k: v for k, v in faltan.items() if v}
if faltan:
    print(f"  FALLO declarado irreversible y no denegado en permisos.json: {faltan}"); sys.exit(1)
print("  ok    lo irreversible del catalogo esta denegado en permisos.json")
PY
[ $? -ne 0 ] && fallos=$((fallos+1))

# ── 7. Nada que parezca una credencial ───────────────────────────────────────
if grep -rIqE '(sk-[A-Za-z0-9]{16,}|ghp_[A-Za-z0-9]{20,}|BEGIN [A-Z ]*PRIVATE KEY)' . 2>/dev/null; then
  fallo "hay algo con forma de credencial en el directorio del rol"
else
  ok "sin credenciales en el directorio del rol"
fi

# ── 8. Las cinco puertas se citan en AGENT.md ────────────────────────────────
for req in AUT-01 AUT-03 AUT-04 AUT-05 AUT-06 AUT-07; do
  grep -q "$req" AGENT.md && ok "AGENT.md cita $req" || fallo "AGENT.md no cita $req"
done

echo
if [ "$fallos" -eq 0 ]; then
  echo "Coherente. Esto NO significa que el rol pase la evaluación de comportamiento."
  exit 0
fi
echo "$fallos incoherencia(s)."
exit 1

#!/usr/bin/env bash
# new-project.sh — Scaffoldea proyecto nuevo con template según tipo
#
# Uso:
#   bash new-project.sh <nombre> <tipo> [carpeta-destino]
#
# Tipos:
#   platform   — PaaS full-stack (backend + frontend + db)
#   proposal   — propuesta comercial / cotización
#   portfolio  — website de portafolio
#   automation — script Python / job scheduled
#   data       — análisis de datos / reportes
#
# Ejemplos:
#   bash new-project.sh farmax platform ~/projects
#   bash new-project.sh juan-perez-portfolio portfolio
#   bash new-project.sh cotizacion-farmax proposal

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    cat <<EOF
Uso: bash new-project.sh <nombre> <tipo> [carpeta-destino]

Tipos disponibles:
  platform    — PaaS full-stack
  proposal    — propuesta comercial
  portfolio   — portfolio website
  automation  — automatización Python
  data        — data analysis

Ejemplos:
  bash new-project.sh farmax platform ~/projects
  bash new-project.sh juan-portfolio portfolio
EOF
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_TYPE="$2"
BASE_DIR="${3:-$PWD}"
PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"

# Validar tipo
case "$PROJECT_TYPE" in
    platform|proposal|portfolio|automation|data)
        ;;
    *)
        echo "❌ Tipo inválido: $PROJECT_TYPE"
        echo "   Válidos: platform | proposal | portfolio | automation | data"
        exit 1
        ;;
esac

if [ -d "$PROJECT_DIR" ]; then
    echo "❌ Ya existe: $PROJECT_DIR"
    exit 1
fi

# Resolver nombre de template
case "$PROJECT_TYPE" in
    platform)   TEMPLATE_FILE="platform.md" ;;
    proposal)   TEMPLATE_FILE="proposal.md" ;;
    portfolio)  TEMPLATE_FILE="portfolio-website.md" ;;
    automation) TEMPLATE_FILE="automation.md" ;;
    data)       TEMPLATE_FILE="data-analysis.md" ;;
esac

# Resolver CLAUDE_PLUGIN_ROOT: si está definido (corriendo desde el plugin) lo usa;
# si no, asume que el script corre desde el plugin y sube un nivel.
if [ -z "${CLAUDE_PLUGIN_ROOT}" ]; then
    CLAUDE_PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

TEMPLATE="${CLAUDE_PLUGIN_ROOT}/templates/project-types/${TEMPLATE_FILE}"
if [ ! -f "$TEMPLATE" ]; then
    echo "❌ No se encuentra el template en $TEMPLATE"
    echo "   Verificá que el plugin esté correctamente instalado."
    exit 1
fi

echo "🚀 Creando proyecto: $PROJECT_NAME"
echo "   Tipo:    $PROJECT_TYPE"
echo "   Destino: $PROJECT_DIR"
echo ""

mkdir -p "$PROJECT_DIR/.claude/agents"
mkdir -p "$PROJECT_DIR/.claude/skills"

# CLAUDE.md con nombre reemplazado
sed "s/\[NOMBRE_PROYECTO\]/$PROJECT_NAME/g" "$TEMPLATE" > "$PROJECT_DIR/CLAUDE.md"

# STYLE.md para proyectos con UI (platform, portfolio)
case "$PROJECT_TYPE" in
    platform|portfolio)
        STYLE_TEMPLATE="${CLAUDE_PLUGIN_ROOT}/templates/STYLE.md"
        if [ -f "$STYLE_TEMPLATE" ]; then
            sed "s/\[NOMBRE_PROYECTO\]/$PROJECT_NAME/g" "$STYLE_TEMPLATE" > "$PROJECT_DIR/STYLE.md"
        fi
        ;;
esac

# README stub diferenciado por tipo
case "$PROJECT_TYPE" in
    platform|portfolio|automation|data)
        cat > "$PROJECT_DIR/README.md" <<EOF
# $PROJECT_NAME

> Tipo: $PROJECT_TYPE

Ver \`CLAUDE.md\` para contexto, agentes activos y flujo de trabajo.

## Desarrollo local

_Pendiente de configurar._
EOF
        ;;
    proposal)
        cat > "$PROJECT_DIR/README.md" <<EOF
# $PROJECT_NAME

> Tipo: Propuesta comercial

Este folder contiene el material de la propuesta para el cliente.
Ver \`CLAUDE.md\` para contexto y estado.

## Archivos esperados
- \`discovery-notes.md\` — apuntes del discovery inicial
- \`propuesta-v1.md\` — propuesta escrita
- \`propuesta-final.pdf\` — versión final que se envía
- \`seguimientos.md\` — registro de follow-ups
EOF
        ;;
esac

# .gitignore adecuado al tipo
case "$PROJECT_TYPE" in
    proposal)
        cat > "$PROJECT_DIR/.gitignore" <<'EOF'
.DS_Store
*.pdf.bak
drafts/
EOF
        ;;
    data)
        cat > "$PROJECT_DIR/.gitignore" <<'EOF'
# Python
__pycache__/
*.py[cod]
venv/
.venv/
.ipynb_checkpoints/

# Data sensible — NO commitear
data/raw/
data/interim/
data/processed/
*.csv
*.parquet
*.xlsx
!data/example*.csv

# Notebooks temporales
notebooks/_scratch/
notebooks/*-checkpoint.ipynb

# Secrets
.env
.env.*
!.env.example

.DS_Store
EOF
        ;;
    *)
        # platform, portfolio, automation usan gitignore completo
        cat > "$PROJECT_DIR/.gitignore" <<'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
venv/
.venv/
env/
*.egg-info/
.pytest_cache/
.ruff_cache/
.coverage
htmlcov/
.mypy_cache/

# Node
node_modules/
dist/
build/
.vite/

# IDE
.vscode/
.idea/
*.swp
.DS_Store

# Env / secrets
.env
.env.*
!.env.example

# DB local
*.db
*.sqlite
*.sqlite3

# Logs
*.log

# Claude local state
.claude/memory/
EOF
        ;;
esac

# Estructura de carpetas específica por tipo
case "$PROJECT_TYPE" in
    data)
        mkdir -p "$PROJECT_DIR"/{data/{raw,interim,processed},notebooks,src,reports/figures}
        touch "$PROJECT_DIR/data-dictionary.md"
        touch "$PROJECT_DIR/assumptions.md"
        ;;
    automation)
        mkdir -p "$PROJECT_DIR"/{src,tests,.github/workflows}
        touch "$PROJECT_DIR/.env.example"
        ;;
    platform)
        mkdir -p "$PROJECT_DIR"/{app,tests,.github/workflows}
        touch "$PROJECT_DIR/.env.example"
        ;;
    portfolio)
        # Dejar vacío, frontend-expert decide stack (Astro/Next/Vite)
        ;;
    proposal)
        mkdir -p "$PROJECT_DIR/drafts"
        touch "$PROJECT_DIR/discovery-notes.md"
        touch "$PROJECT_DIR/seguimientos.md"
        ;;
esac

# Git init (salvo que sea proposal, que no suele ir a git)
if [ "$PROJECT_TYPE" != "proposal" ]; then
    cd "$PROJECT_DIR"
    git init -q
    git add .
    git commit -q -m "chore: initial scaffold ($PROJECT_TYPE) with CLAUDE.md"
fi

echo "✅ Proyecto creado en: $PROJECT_DIR"
echo ""
echo "Próximos pasos:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Abrí CLAUDE.md y completá las secciones marcadas"
echo "  3. Abrí Claude Code: 'claude'"
echo "  4. Primer mensaje al orquestador:"
echo "     'Leé el CLAUDE.md y llamá a discovery-agent para arrancar'"

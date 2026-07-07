#!/usr/bin/env bash
# bootstrap.sh
# Description: Setup completo del workspace de un solo paso.
#   Trae lo último del repo, instala dependencias, sincroniza
#   MCP servers, comandos, knowledge-base y valida para TODOS
#   los proyectos existentes.
# Usage: ./bootstrap.sh
# Depends: git, node
# Env: Lee .env si existe, itera sobre los proyectos en projects/

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "=== Bootstrap: $WORKSPACE_ROOT ==="

# ── 1. Traer lo último del repo ──
echo ""
echo ">>> git pull"
git pull

# ── 2. Instalar dependencias npm ──
echo ""
echo ">>> npm install"
npm install

# ── 3. Setup inicial del workspace ──
echo ""
echo ">>> Setup inicial"
./scripts/shared/setup-workspace.sh

# ── 4. Cargar .env si existe ──
if [ -f "$WORKSPACE_ROOT/.env" ]; then
  set -a
  source "$WORKSPACE_ROOT/.env"
  set +a
  echo "  [OK] .env cargado"
else
  echo "  [WARN] No existe .env. Las sincronizaciones de proyecto se saltearán."
fi

# ── 5. Detectar proyectos existentes ──
PROJECTS=()
for dir in "$WORKSPACE_ROOT/projects"/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  # Ignorar directorio _template si existe
  [ "$name" = "_template" ] || [ "$name" = "_common" ] && continue
  PROJECTS+=("$name")
done

if [ ${#PROJECTS[@]} -eq 0 ]; then
  echo ""
  echo "  No se encontraron proyectos en projects/. Nada que sincronizar."
else
  echo ""
  echo ">>> Proyectos detectados: ${PROJECTS[*]}"

  echo ""
  echo "--- Sincronizar MCP servers ---"
  for project in "${PROJECTS[@]}"; do
    echo "  $project..."
    ./scripts/mcp/sync.sh "$project" 2>/dev/null || echo "    [SKIP]"
  done

  echo ""
  echo "--- Sincronizar comandos externos ---"
  ./scripts/commands/sync-commands.sh 2>/dev/null || true

  echo ""
  echo "--- Sincronizar knowledge-base ---"
  ./scripts/knowledge/sync.sh 2>/dev/null || true
fi

# ── 6. Validar ──
echo ""
echo ">>> Validar workspace"
./scripts/utils/validate-rules.sh || true

echo ""
echo "=== Bootstrap completo ==="
echo "Abrí el workspace con: opencode"
if [ ${#PROJECTS[@]} -gt 0 ]; then
  echo "Activá un proyecto con: /f-agent <nombre-del-proyecto>"
fi

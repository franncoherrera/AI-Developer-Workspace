#!/usr/bin/env bash
# scripts/mcp/sync.sh
# Description: Sincroniza definiciones de MCP servers desde un proyecto externo
#   hacia mcp/servers/. Soporta un formato:
#     Archivos .json individuales en .opencode/mcp/servers/ (symlink con prefijo ext.)
# Usage: ./scripts/mcp/sync.sh <project>
#   project — nombre del proyecto en projects/
# Depends: jq
# Env: DEPRATI_BASE_PROJECT_PATH (o el env_var.base definido en settings.json)
# Failures:
#   - settings.json no encontrado → exit 1
#   - env_var.base no definido → exit 0 (no es error, falta config)
#   - Variable de entorno no seteada → exit 0 (setup incompleto)
#   - Sin servers en origen → exit 0

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if [ -f "$WORKSPACE_ROOT/.env" ]; then
  set -a
  source "$WORKSPACE_ROOT/.env"
  set +a
fi

PROJECT="${1:?Usage: $0 <project>}"
LOCAL_DIR="$WORKSPACE_ROOT/mcp/servers"
SETTINGS="$WORKSPACE_ROOT/projects/$PROJECT/.opencode/settings.json"

if [ ! -f "$SETTINGS" ]; then
  echo "[sync] Project settings not found: $SETTINGS"
  exit 1
fi

ENV_VAR_BASE=$(jq -r '.env_var.base // empty' "$SETTINGS")
if [ -z "$ENV_VAR_BASE" ]; then
  echo "[sync] No env_var.base defined for project '$PROJECT'. Nothing to sync."
  exit 0
fi

BASE_PATH="${!ENV_VAR_BASE:-}"
if [ -z "$BASE_PATH" ]; then
  echo "[sync] Environment variable $ENV_VAR_BASE is not set. Nothing to sync."
  exit 0
fi

mkdir -p "$LOCAL_DIR"

SYNCED=0
EXTERNAL_DIR="$BASE_PATH/.opencode/mcp/servers"
MCP_JSON="$BASE_PATH/.mcp.json"

# Modo 1: archivos individuales en .opencode/mcp/servers/
if [ -d "$EXTERNAL_DIR" ]; then
  find "$LOCAL_DIR" -maxdepth 1 -name 'ext.*.json' -type l -delete 2>/dev/null || true
  for file in "$EXTERNAL_DIR"/*.json; do
    [ -f "$file" ] || continue
    name="ext.$(basename "$file")"
    ln -sf "$file" "$LOCAL_DIR/$name"
    SYNCED=$((SYNCED + 1))
  done
fi

# Modo 2: .mcp.json en raíz del proyecto externo
# (No se genera ext.*.json — los servers externos ya están definidos
#  manualmente en mcp/servers/ con rutas vía variables de entorno)

if [ "$SYNCED" -eq 0 ]; then
  echo "[sync] No MCP servers found at $EXTERNAL_DIR or $MCP_JSON"
  exit 0
fi

echo "[sync] $SYNCED MCP servers synced from $PROJECT."

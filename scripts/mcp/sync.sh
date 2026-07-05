#!/usr/bin/env bash
# Syncs MCP servers from a project's external path into local mcp/servers/
# Usage: ./scripts/mcp/sync.sh <project>

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# Source .env if present (so the user doesn't need to export vars manually)
if [ -f "$WORKSPACE_ROOT/.env" ]; then
  set -a
  source "$WORKSPACE_ROOT/.env"
  set +a
fi

PROJECT="${1:?Usage: $0 <project>}"
LOCAL_DIR="$WORKSPACE_ROOT/mcp/servers"
SETTINGS="$WORKSPACE_ROOT/projects/$PROJECT/.opencode/settings.json"

if [ ! -f "$SETTINGS" ]; then
  echo "Project settings not found: $SETTINGS"
  exit 1
fi

# Read env_var.base from settings.json
ENV_VAR_BASE=$(jq -r '.env_var.base // empty' "$SETTINGS")
if [ -z "$ENV_VAR_BASE" ]; then
  echo "No env_var.base defined for project '$PROJECT'. Nothing to sync."
  exit 0
fi

BASE_PATH="${!ENV_VAR_BASE:-}"
if [ -z "$BASE_PATH" ]; then
  echo "Environment variable $ENV_VAR_BASE is not set. Nothing to sync."
  exit 0
fi

EXTERNAL_DIR="$BASE_PATH/.opencode/mcp/servers"
if [ ! -d "$EXTERNAL_DIR" ]; then
  echo "No MCP servers found at $EXTERNAL_DIR"
  exit 0
fi

mkdir -p "$LOCAL_DIR"

# Remove stale ext.*.json symlinks
find "$LOCAL_DIR" -maxdepth 1 -name 'ext.*.json' -type l -delete 2>/dev/null || true

count=0
for file in "$EXTERNAL_DIR"/*.json; do
  [ -f "$file" ] || continue
  name="ext.$(basename "$file")"
  ln -sf "$file" "$LOCAL_DIR/$name"
  count=$((count + 1))
done

echo "[sync] $count MCP servers linked from $PROJECT."

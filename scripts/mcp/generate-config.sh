#!/usr/bin/env bash
# scripts/mcp/generate-config.sh
# Description: Genera/actualiza opencode.jsonc en la raíz del workspace
#   a partir de mcp/servers/*.json. Solo reemplaza la sección "mcp",
#   preservando el resto de la configuración.
# Usage: ./scripts/mcp/generate-config.sh
# Depends: jq

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SERVERS_DIR="$WORKSPACE_ROOT/mcp/servers"
OUTPUT_FILE="$WORKSPACE_ROOT/opencode.jsonc"

if [ ! -d "$SERVERS_DIR" ]; then
  echo "[generate] No se encuentra $SERVERS_DIR"
  exit 1
fi

# Verificar que hay archivos .json
JSON_FILES=$(find "$SERVERS_DIR" -maxdepth 1 -name '*.json')
if [ -z "$JSON_FILES" ]; then
  echo "[generate] No hay archivos .json en $SERVERS_DIR"
  exit 0
fi

# Leer config existente (todo menos mcp)
EXISTING_CONFIG=$(jq 'with_entries(select(.key != "mcp"))' "$OUTPUT_FILE" 2>/dev/null || echo "{}")

# Generar objeto mcp a partir de los archivos en mcp/servers/
ALL_SERVERS=$(jq -s '.' "$SERVERS_DIR"/*.json)
MCP_JSON=$(echo "$ALL_SERVERS" | jq '
  {
    mcp: (
      reduce .[] as $s ({};
        .[$s.name] = {
          type: "local",
          command: ([$s.command] + ($s.args // [])),
          enabled: ($s.disabled // false | not),
          environment: ($s.env // {})
        }
      )
    )
  }
')

# Combinar config existente + nuevo mcp
echo "$EXISTING_CONFIG" | jq --argjson mcp "$(echo "$MCP_JSON" | jq '.mcp')" '.mcp = $mcp' > "$OUTPUT_FILE"

COUNT=$(echo "$JSON_FILES" | wc -l)
echo "[generate] opencode.jsonc actualizado en $OUTPUT_FILE con $COUNT MCP server(s)"

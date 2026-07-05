#!/usr/bin/env bash
# scripts/utils/register-technology.sh
# Description: Registra una nueva tecnología en el workspace. Crea las carpetas
#   en rules/, prompts/, config/, templates/ y añade la entrada en
#   technologies.json.
# Usage: ./scripts/utils/register-technology.sh <key> <name>
# Depends: jq
# Env: (ninguna)
# Failures:
#   - Sin argumentos → exit 1 con usage
#   - Tecnología ya registrada → exit 1
#   - technologies.json no encontrado → exit 1

set -euo pipefail

KEY="${1:?Usage: $0 <key> <name>}"
NAME="${2:?Usage: $0 <key> <name>}"
WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REGISTRY="$WORKSPACE_ROOT/docs/references/technologies.json"

if [ ! -f "$REGISTRY" ]; then
  echo "Registry not found: $REGISTRY"
  exit 1
fi

# Check key doesn't exist
if jq -e ".technologies[] | select(.key == \"$KEY\")" "$REGISTRY" >/dev/null 2>&1; then
  echo "Technology '$KEY' is already registered."
  exit 1
fi

# Create folders
for dir in "rules/$KEY" "prompts/$KEY" "config/$KEY" "templates/$KEY"; do
  mkdir -p "$WORKSPACE_ROOT/$dir"
  if [ "$dir" = "rules/$KEY" ] && [ -f "$WORKSPACE_ROOT/rules/_template/AGENTS.md" ]; then
    cp "$WORKSPACE_ROOT/rules/_template/AGENTS.md" "$WORKSPACE_ROOT/$dir/AGENTS.md"
    echo "  [OK] $dir/AGENTS.md (from template)"
  else
    echo "  [OK] $dir/"
  fi
done

# Register in JSON using jq
jq --arg key "$KEY" --arg name "$NAME" \
  '.technologies += [{
    "key": $key,
    "name": $name,
    "status": "planned",
    "has": {
      "rules": true,
      "prompts": true,
      "config": true,
      "template": true
    }
  }]' "$REGISTRY" > "${REGISTRY}.tmp" && mv "${REGISTRY}.tmp" "$REGISTRY"

echo "[register] Technology '$KEY' registered."
echo "[register] Next steps:"
echo "  1. Write rules/$KEY/AGENTS.md"
echo "  2. Add prompts to prompts/$KEY/"
echo "  3. Add configs to config/$KEY/"
echo "  4. Create template in templates/$KEY/"
echo "  5. Update technologies.json: set has.* = true, status = 'active'"
echo "  6. Run ./scripts/utils/validate-rules.sh"

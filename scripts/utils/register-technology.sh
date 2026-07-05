#!/usr/bin/env bash
# Registers a new technology in the workspace and creates its folder structure.
# Usage: ./scripts/utils/register-technology.sh <key> <name>

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
      "prompts": false,
      "config": false,
      "template": false
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

#!/usr/bin/env bash
# Creates a new project scaffolded from a template.
# Usage: ./scripts/project/new-project.sh <name> <type> [path]

set -euo pipefail

NAME="${1:?Usage: $0 <name> <type> [path]}"
TYPE="${2:?Usage: $0 <name> <type> [path]}"
WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REGISTRY="$WORKSPACE_ROOT/docs/references/technologies.json"

if [ ! -f "$REGISTRY" ]; then
  echo "Registry not found: $REGISTRY"
  exit 1
fi

# Check technology exists and has template
TECH=$(jq -r ".technologies[] | select(.key == \"$TYPE\")" "$REGISTRY" 2>/dev/null || true)
if [ -z "$TECH" ]; then
  AVAILABLE=$(jq -r '.technologies[].key' "$REGISTRY" | tr '\n' ', ')
  echo "Unknown technology '$TYPE'. Available: $AVAILABLE"
  exit 1
fi

HAS_TEMPLATE=$(jq -r ".technologies[] | select(.key == \"$TYPE\") | .has.template" "$REGISTRY")
if [ "$HAS_TEMPLATE" != "true" ]; then
  echo "Technology '$TYPE' has no template yet. Set has.template = true in technologies.json first."
  exit 1
fi

PROJECT_PATH="${3:-$WORKSPACE_ROOT/projects/$NAME}"
TEMPLATE_PATH="$WORKSPACE_ROOT/templates/$TYPE"

if [ ! -d "$TEMPLATE_PATH" ]; then
  echo "Template not found: $TEMPLATE_PATH"
  exit 1
fi

if [ -d "$PROJECT_PATH" ]; then
  echo "Project already exists: $PROJECT_PATH"
  exit 1
fi

echo "[new-project] Creating $NAME ($TYPE) at $PROJECT_PATH"

# Create project directory and copy template
mkdir -p "$PROJECT_PATH"
cp -r "$TEMPLATE_PATH/"* "$PROJECT_PATH/"

# Create project AGENTS.md
cat > "$PROJECT_PATH/AGENTS.md" << EOF
# Project: $NAME

## Description
TODO: Add description

## Technology
- **Stack**: $TYPE

## Architecture
TODO: Describe architecture

## Links
- **Tracker**: TODO
- **CI**: TODO
EOF

# Create .gitkeep files for empty subdirs
for dir in docs scripts rules specs; do
  mkdir -p "$PROJECT_PATH/$dir"
  touch "$PROJECT_PATH/$dir/.gitkeep"
done

# Update PROJECTS_INDEX.md
INDEX="$WORKSPACE_ROOT/projects/PROJECTS_INDEX.md"
if [ -f "$INDEX" ]; then
  echo "| \`$NAME\` | $TYPE | Active | TODO |" >> "$INDEX"
fi

echo "[new-project] Project created: $PROJECT_PATH"
echo "[new-project] Next steps:"
echo "  1. Edit $PROJECT_PATH/AGENTS.md with project context"

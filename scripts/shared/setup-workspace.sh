#!/usr/bin/env bash
# scripts/shared/setup-workspace.sh
# Description: Setup inicial del workspace. Verifica prerequisitos (git,
#   docker, jq, node) y crea los directorios base necesarios.
# Usage: ./scripts/shared/setup-workspace.sh
# Depends: git, docker, jq, node (opcional — warns si faltan)
# Env: (ninguna)
# Failures:
#   - Ningún error fatal; los prerequisitos faltantes son warnings
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
echo "Setting up AI Developer Workspace..."

# Check prerequisites
check_prereq() {
  if command -v "$1" &>/dev/null; then
    echo "  [OK] $2"
  else
    echo "  [WARN] $2 not found"
  fi
}

check_prereq "git" "Git"
check_prereq "docker" "Docker"
check_prereq "jq" "jq"
check_prereq "node" "Node.js"

# Create required directories
dirs=(
  ".opencode/agents"
  ".opencode/skills"
  ".opencode/permissions"
  "projects"
  "knowledge-base/learnings"
  "knowledge-base/decisions"
)

for dir in "${dirs[@]}"; do
  path="$WORKSPACE_ROOT/$dir"
  if [ ! -d "$path" ]; then
    mkdir -p "$path"
    echo "  [CREATE] $path"
  fi
done

# Install pre-commit hook
HOOK_SRC="$WORKSPACE_ROOT/scripts/hooks/pre-commit.sh"
HOOK_DST="$WORKSPACE_ROOT/.git/hooks/pre-commit"
if [ -f "$HOOK_SRC" ] && [ -d "$WORKSPACE_ROOT/.git/hooks" ]; then
  if [ ! -f "$HOOK_DST" ] && [ ! -L "$HOOK_DST" ]; then
    ln -s "$HOOK_SRC" "$HOOK_DST"
    echo "  [INSTALL] pre-commit hook (.git/hooks/pre-commit → scripts/hooks/pre-commit.sh)"
  fi
fi

echo "Setup complete!"
echo "Workspace: $WORKSPACE_ROOT"

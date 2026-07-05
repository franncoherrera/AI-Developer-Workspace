#!/usr/bin/env bash
# Initial setup for the AI Developer Workspace.
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

echo "Setup complete!"
echo "Workspace: $WORKSPACE_ROOT"

#!/usr/bin/env bash
# scripts/hooks/pre-commit.sh
# Description: Pre-commit hook que regenera automáticamente
#   docs/guide/scripts-reference.md cuando hay cambios en scripts/.
#   Instalado por setup-workspace.sh como symlink en .git/hooks/pre-commit.
# Usage: (se ejecuta automáticamente en git commit)
# Depends: (ninguna)
# Env: (ninguna)
# Failures:
#   - Si la generación falla, se muestra warning pero no bloquea el commit

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPTS_REF="$WORKSPACE_ROOT/docs/guide/scripts-reference.md"
GENERATOR="$WORKSPACE_ROOT/scripts/docs/generate-scripts-ref.sh"

# Only run if generator exists and scripts/ has staged changes
if [ ! -f "$GENERATOR" ]; then
  exit 0
fi

# Check if any file under scripts/ is staged
STAGED_SCRIPTS=$(git diff --cached --name-only -- "scripts/" 2>/dev/null || true)
if [ -z "$STAGED_SCRIPTS" ]; then
  exit 0
fi

# Stash current state of the ref doc before regenerating
OLD_HASH=$(git hash-object "$SCRIPTS_REF" 2>/dev/null || echo "")

# Regenerate
if ! bash "$GENERATOR" >/dev/null 2>&1; then
  echo "[pre-commit] ⚠️  Failed to regenerate scripts reference"
  exit 0
fi

# Check if the ref doc changed
NEW_HASH=$(git hash-object "$SCRIPTS_REF" 2>/dev/null || echo "")
if [ "$OLD_HASH" != "$NEW_HASH" ]; then
  git add "$SCRIPTS_REF"
  echo "[pre-commit] 📝 Auto-generated scripts-reference.md"
fi

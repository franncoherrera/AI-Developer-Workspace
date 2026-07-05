#!/usr/bin/env bash
# scripts/commands/sync-commands.sh
# Description: Sincroniza comandos slash (/qubik-*) desde un proyecto externo
#   hacia .opencode/commands/. Lee DEPRATI_BASE_PROJECT_PATH del .env.
# Usage: ./scripts/commands/sync-commands.sh
# Depends: (ninguna — solo bash y find)
# Env: DEPRATI_BASE_PROJECT_PATH (desde .env)
# Failures:
#   - Variable no seteada → exit 0 (setup incompleto, no es error)
#   - Directorio origen sin .md files → exit 0
#   - Archivo local con mismo nombre (no symlink) → warning, se saltea
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ENV_FILE="$WORKSPACE_ROOT/.env"

if [ -f "$ENV_FILE" ]; then
  set -a
  source "$ENV_FILE"
  set +a
fi

BASE="${DEPRATI_BASE_PROJECT_PATH:-}"

if [ -z "$BASE" ]; then
  echo "[sync] DEPRATI_BASE_PROJECT_PATH no está seteada. Nada que sincronizar."
  exit 0
fi

EXTERNAL="$BASE/.opencode/commands"
DST="$WORKSPACE_ROOT/.opencode/commands"

if [ ! -d "$EXTERNAL" ]; then
  echo "[sync] No se encontró $EXTERNAL"
  exit 0
fi

mkdir -p "$DST"

COUNT=0
SKIP=0
while IFS= read -r -d '' cmd_file; do
  name=$(basename "$cmd_file")
  link="$DST/$name"

  if [ -e "$link" ] && [ ! -L "$link" ]; then
    echo "[sync] WARN: $name existe localmente, se saltea"
    SKIP=$((SKIP + 1))
    continue
  fi

  ln -sf "$cmd_file" "$link"
  COUNT=$((COUNT + 1))
done < <(find "$EXTERNAL" -name '*.md' -type f -print0)

echo "[sync] $COUNT commands linked, $SKIP skipped (local conflicts) desde \$DEPRATI_BASE_PROJECT_PATH."

#!/usr/bin/env bash
# scripts/commands/sync-commands.sh
# Description: Sincroniza comandos slash desde proyectos externos hacia
#   .opencode/commands/<proyecto>/<nombre>.md
#   Los comandos quedan disponibles como /<proyecto>/<nombre>.
# Usage: ./scripts/commands/sync-commands.sh
# Depends: (ninguna — solo bash y find)
# Env: Lee .env, itera sobre todas las variables *_BASE_PROJECT_PATH
# Failures:
#   - Sin variables seteadas → exit 0 (setup incompleto, no es error)
#   - Sin .md files en origen → exit 0
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DST="$WORKSPACE_ROOT/.opencode/commands"
LEGACY_EXT="$WORKSPACE_ROOT/.opencode/commands/external"
ENV_FILE="$WORKSPACE_ROOT/.env"

if [ -f "$ENV_FILE" ]; then
  set -a
  source "$ENV_FILE"
  set +a
fi

# ── 1. Limpiar estructura legacy ──
if [ -d "$LEGACY_EXT" ]; then
  echo "[sync] Limpiando estructura legacy $LEGACY_EXT ..."
  rm -rf "$LEGACY_EXT"
fi

# ── 2. Iterar sobre *_BASE_PROJECT_PATH ──
echo "[sync] Sincronizando comandos a $DST ..."

TOTAL=0
while IFS='=' read -r var_name var_value; do
  [[ "$var_name" != *_BASE_PROJECT_PATH ]] && continue
  [ -z "$var_value" ] && continue
  [ ! -d "$var_value" ] && continue

  # Extraer nombre del proyecto: DEPRATI_BASE_PROJECT_PATH → deprati
  proj_name=$(echo "$var_name" | sed 's/_BASE_PROJECT_PATH$//' | tr '[:upper:]' '[:lower:]' | tr '_' '-')
  srcdir="$var_value/.opencode/commands"

  [ ! -d "$srcdir" ] && continue

  # Limpiar directorio del proyecto si existe
  proj_dir="$DST/$proj_name"
  rm -rf "$proj_dir"
  mkdir -p "$proj_dir"

  # Crear .gitignore para excluir comandos sincronizados del control de versiones
  echo "*" > "$proj_dir/.gitignore"

  COUNT=0
  while IFS= read -r -d '' cmd_file; do
    base=$(basename "$cmd_file")
    link="$proj_dir/$base"

    ln -sf "$cmd_file" "$link"
    COUNT=$((COUNT + 1))
  done < <(find "$srcdir" -name '*.md' -type f -print0 2>/dev/null || true)

  echo "  $proj_name: $COUNT comandos sincronizados → /$proj_name/"
  TOTAL=$((TOTAL + COUNT))
done < <(env)

if [ "$TOTAL" -eq 0 ]; then
  echo "[sync] No se encontraron comandos externos. Definí variables *_BASE_PROJECT_PATH en .env"
fi

echo "[sync] Total: $TOTAL comandos"

#!/usr/bin/env bash
# scripts/knowledge/sync.sh
# Description: Sincroniza symlinks en knowledge-base/_proyectos/ con las
#   variables de entorno *_BASE_PROJECT_PATH. Crea enlaces a la documentación
#   externa de cada proyecto (specs, ADRs, docs, rules).
# Usage: ./scripts/knowledge/sync.sh
# Depends: (ninguna)
# Env: *_(BASE_PROJECT_PATH|PROJECT_PATH) — cada una genera un symlink
# Failures:
#   - Ninguno (idempotente)

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
KB_DIR="$WORKSPACE_ROOT/knowledge-base/_proyectos"

mkdir -p "$KB_DIR"

echo "[knowledge-sync] Sincronizando symlinks en $KB_DIR"

# ── 1. Crear symlinks desde variables de entorno ──
# Prioridad: _BASE_PROJECT_PATH > _PROJECT_PATH (por si ambas existen)
created=0
for suffix in "_BASE_PROJECT_PATH" "_PROJECT_PATH"; do
  while IFS='=' read -r var_name var_value; do
    [[ "$var_name" != *"$suffix" ]] && continue
    # Evitar que _PROJECT_PATH también matchee _BASE_PROJECT_PATH
    [[ "$suffix" = "_PROJECT_PATH" && "$var_name" == *_BASE_PROJECT_PATH ]] && continue
    proj_name=$(echo "$var_name" | sed "s/$suffix$//" | tr '[:upper:]' '[:lower:]' | tr '_' '-')
    [ -z "$var_value" ] || [ ! -d "$var_value" ] && continue
    link_path="$KB_DIR/$proj_name"
    # Si es _PROJECT_PATH y ya existe symlink (creado por _BASE_PROJECT_PATH), skip
    [ "$suffix" = "_PROJECT_PATH" ] && [ -L "$link_path" ] && continue
    if [ ! -L "$link_path" ] || [ "$(readlink "$link_path")" != "$var_value" ]; then
      ln -sfn "$var_value" "$link_path"
      echo "  ✓ $proj_name → $var_value"
      ((created++))
    fi
  done < <(env)
done

# ── 2. Limpiar symlinks rotos ──
cleaned=0
for link in "$KB_DIR"/*; do
  [ -L "$link" ] || continue
  if [ ! -e "$link" ]; then
    target=$(readlink "$link")
    echo "  ✗ Eliminando symlink roto: $(basename "$link") → $target"
    rm "$link"
    ((cleaned++))
  fi
done

echo "[knowledge-sync] Hecho: $created creados, $cleaned limpiados"

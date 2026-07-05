#!/usr/bin/env bash
# scripts/doctor.sh
# Description: Diagnóstico completo del workspace. Verifica variables de entorno,
#   directorios externos, MCP servers, estructura de reglas, y dependencias.
# Usage: ./scripts/doctor.sh [project]
#   project  — (opcional) proyecto a diagnosticar. Default: deprati
# Depends: jq
# Env: DEPRATI_PROJECT_PATH, DEPRATI_BASE_PROJECT_PATH
# Failures:
#   - jq no instalado → error fatal
#   - Variables no seteadas → warning, no fatal (setup incompleto)
#   - Directorios externos faltantes → warning
#   - Exit code: 0 si todo ok, 1 si hay issues

set -euo pipefail

PROJECT="${1:-deprati}"
WORKSPACE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXIT_CODE=0

if [ -f "$WORKSPACE_ROOT/.env" ]; then
  set -a
  source "$WORKSPACE_ROOT/.env"
  set +a
fi

check() {
  local status="$1" label="$2" message="${3:-}"
  if [ "$status" = "PASS" ]; then
    echo "  ✅ $label"
  elif [ "$status" = "WARN" ]; then
    echo "  ⚠️  $label — $message"
  else
    echo "  ❌ $label — $message"
    EXIT_CODE=1
  fi
}

echo "🔍 Doctor: AI Developer Workspace"
echo "   Proyecto: $PROJECT"
echo "   Workspace: $WORKSPACE_ROOT"
echo ""

echo "📦 Dependencias"
for cmd in git jq node; do
  if command -v "$cmd" &>/dev/null; then
    check PASS "$cmd instalado"
  else
    check FAIL "$cmd no encontrado" "instalalo para habilitar funciones del workspace"
  fi
done
echo ""

echo "📁 Estructura del Workspace"
[ -f "$WORKSPACE_ROOT/AGENTS.md" ] && check PASS "AGENTS.md raíz" || check FAIL "AGENTS.md raíz" "archivo faltante"
[ -d "$WORKSPACE_ROOT/rules/global" ] && check PASS "rules/global/" || check FAIL "rules/global/" "directorio faltante"
[ -d "$WORKSPACE_ROOT/projects" ] && check PASS "projects/" || check FAIL "projects/" "directorio faltante"
[ -d "$WORKSPACE_ROOT/mcp/servers" ] && check PASS "mcp/servers/" || check WARN "mcp/servers/" "sin MCP servers"
echo ""

echo "🔧 Proyecto: $PROJECT"
SETTINGS="$WORKSPACE_ROOT/projects/$PROJECT/.opencode/settings.json"
if [ -f "$SETTINGS" ]; then
  check PASS "settings.json encontrado"
  ENV_CODE=$(jq -r '.env_var.code // empty' "$SETTINGS")
  ENV_BASE=$(jq -r '.env_var.base // empty' "$SETTINGS")
  echo "     env_var.code: ${ENV_CODE:-none}"
  echo "     env_var.base: ${ENV_BASE:-none}"
else
  check FAIL "settings.json" "no encontrado en projects/$PROJECT/.opencode/"
fi
echo ""

echo "🌐 Variables de Entorno"
for var in DEPRATI_PROJECT_PATH DEPRATI_BASE_PROJECT_PATH; do
  val="${!var:-}"
  if [ -n "$val" ]; then
    check PASS "$var = $val"
    [ -d "$val" ] && check PASS "  → directorio existe" || check WARN "  → directorio no existe" "$val"
  else
    check WARN "$var no seteada" "usá .env o export manual"
  fi
done
echo ""

echo "🔌 MCP Servers"
MCP_DIR="$WORKSPACE_ROOT/mcp/servers"
if [ -d "$MCP_DIR" ]; then
  count=0
  for f in "$MCP_DIR"/*.json; do
    [ -f "$f" ] || continue
    name=$(basename "$f" .json)
    if [ -L "$f" ]; then
      target=$(readlink "$f")
      [ -f "$target" ] && check PASS "  $name → $target" || check WARN "  $name → $target (symlink roto)"
    else
      check PASS "  $name (local)"
    fi
    count=$((count + 1))
  done
  [ "$count" -eq 0 ] && check WARN "  ningún archivo .json" "mcp/servers/ está vacío"
else
  check WARN "mcp/servers/ no existe"
fi

# Verificar symlinks de knowledge-base
echo ""
echo "🧠 Knowledge Base"
KB_DIR="$WORKSPACE_ROOT/knowledge-base/_proyectos"
if [ -d "$KB_DIR" ]; then
  has_broken=false
  for link in "$KB_DIR"/*; do
    [ -L "$link" ] || continue
    name=$(basename "$link")
    if [ -e "$link" ]; then
      check PASS "_proyectos/$name → $(readlink "$link")"
    else
      check WARN "_proyectos/$name (roto)" "ejecutar: scripts/knowledge/sync.sh"
      has_broken=true
    fi
  done
  $has_broken && echo "   → Corregir con: ./scripts/knowledge/sync.sh"
else
  check WARN "knowledge-base/_proyectos/ no existe"
fi

# Verificar .mcp.json externo
BASE_PATH="${DEPRATI_BASE_PROJECT_PATH:-}"
if [ -n "$BASE_PATH" ] && [ -f "$BASE_PATH/.mcp.json" ]; then
  echo ""
  echo "   .mcp.json detectado en proyecto externo (servidores ya definidos estáticamente)"
fi
echo ""

echo "📋 Reglas"
if [ -f "$WORKSPACE_ROOT/docs/references/technologies.json" ]; then
  "$WORKSPACE_ROOT/scripts/utils/validate-rules.sh" && check PASS "validate-rules.sh" || check WARN "validate-rules.sh" "revisar issues arriba"
else
  check WARN "technologies.json no existe"
fi
echo ""

echo "📜 Scripts"
script_count=0
while IFS= read -r -d '' script; do
  rel="${script#$WORKSPACE_ROOT/}"
  if [ -x "$script" ]; then
    check PASS "$rel (executable)"
  else
    check WARN "$rel" "no tiene permisos de ejecución"
  fi
  script_count=$((script_count + 1))
done < <(find "$WORKSPACE_ROOT/scripts" -name '*.sh' -type f -print0)
[ "$script_count" -eq 0 ] && check WARN "ningún script .sh" "scripts/ está vacío"
echo ""

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "✅ Diagnóstico completo — todo ok"
else
  echo "⚠️  Diagnóstico completo — se encontraron issues (revisar arriba)"
fi
exit "$EXIT_CODE"

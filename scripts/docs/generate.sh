#!/usr/bin/env bash
# scripts/docs/generate.sh
# Description: Generador maestro de documentación. Escanea el estado real del
#   workspace y actualiza las secciones marcadas con <!-- AUTO: --> en
#   docs/guide/workspace-reference.md. También regenera scripts-reference.md.
# Usage: ./scripts/docs/generate.sh
# Depends: jq
# Env: (ninguna)
# Failures:
#   - workspace-reference.md no encontrado → exit 1
#   - technologies.json no encontrado → warning, se salta sección

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DOC="$WORKSPACE_ROOT/docs/guide/workspace-reference.md"
REGISTRY="$WORKSPACE_ROOT/docs/references/technologies.json"

if [ ! -f "$DOC" ]; then
  echo "[generate] ERROR: $DOC not found"
  exit 1
fi

echo "[generate] Regenerando documentación del workspace..."

# ── Utilidad: reemplazar bloque entre marcadores ──
replace_block() {
  local marker="$1" content="$2"
  local tmpf
  tmpf=$(mktemp)
  printf '%s' "$content" > "$tmpf"
  perl -i -0777 -pe '
    open(my $fh, "<", "'"$tmpf"'") or die;
    my $replacement = do { local $/; <$fh> };
    close($fh);
    s{<!-- AUTO:'"$marker"' -->.*?<!-- /AUTO -->}
     {<!-- AUTO:'"$marker"' -->\n$replacement\n<!-- /AUTO -->}sg
  ' "$DOC"
  rm -f "$tmpf"
}

# ── 1. Tecnologías Soportadas ──
echo "  → Tecnologías Soportadas..."
if [ -f "$REGISTRY" ]; then
  table="| Tecnología | Versión | Framework/Build | Estado |"
  table="$table\n|-----------|---------|-----------------|--------|"
  while IFS=$'\t' read -r key name status; do
    [ -z "$key" ] && continue
    tech_name="$name"
    # Map key to framework description
    case "$key" in
      accelerator-sap-vue) framework="Vue 3 + CAP + SAP BTP, Fiori Design" ;;
      *) framework="—" ;;
    esac
    status_icon="—"
    [ "$status" = "active" ] && status_icon="✅ Active"
    [ "$status" = "planned" ] && status_icon="⏳ Planned"
    [ "$status" = "deprecated" ] && status_icon="🗑️ Deprecated"
    table="$table\n| **$tech_name** | — | $framework | $status_icon |"
  done < <(jq -r '.technologies[] | "\(.key)\t\(.name)\t\(.status)"' "$REGISTRY")
  replace_block "technologies" "$(echo -e "$table")"
fi

# ── 2. Prompts Reutilizables ──
echo "  → Prompts Reutilizables..."
PROMPTS_DIR="$WORKSPACE_ROOT/prompts"
if [ -d "$PROMPTS_DIR" ]; then
  table="| Prompt | Propósito |"
  table="$table\n|--------|-----------|"
  while IFS= read -r -d '' f; do
    rel="${f#$PROMPTS_DIR/}"
    # Extract description: first heading, or comment after ---description:
    desc=$(head -20 "$f" | grep -m1 '^# ' | sed 's/^# //' 2>/dev/null || true)
    [ -z "$desc" ] && desc=$(head -20 "$f" | grep -m1 'description:' | sed 's/.*description: //' 2>/dev/null || true)
    [ -z "$desc" ] && desc="—"
    table="$table\n| \`$rel\` | $desc |"
  done < <(find "$PROMPTS_DIR" -name '*.md' -type f -print0 | sort -z)
  replace_block "prompts" "$(echo -e "$table")"
fi

# ── 3. MCP Servers ──
echo "  → MCP Servers..."
MCP_DIR="$WORKSPACE_ROOT/mcp"
if [ -d "$MCP_DIR/servers" ]; then
  # Build directory tree
  tree_block="\`\`\`\nmcp/"
  tree_block="$tree_block\n├── README.md                 # Documentación MCP"
  tree_block="$tree_block\n├── servers/                  # Definiciones de servidores MCP"
  first=true
  for f in "$MCP_DIR/servers"/*.json; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    if $first; then
      tree_block="$tree_block\n│   ├── $name"
      first=false
    else
      tree_block="$tree_block\n│   ├── $name"
    fi
  done
  tree_block="$tree_block\n└── tools/                    # Herramientas personalizadas"
  tree_block="$tree_block\n\`\`\`\n\n### Servidores Incluidos\n"
  # Server table
  tree_block="$tree_block\n| Servidor | Descripción |"
  tree_block="$tree_block\n|----------|-------------|"
  for f in "$MCP_DIR/servers"/*.json; do
    [ -f "$f" ] || continue
    srv_name=$(jq -r '.name // "unknown"' "$f")
    srv_desc=$(jq -r '.description // "—"' "$f")
    tree_block="$tree_block\n| \`$srv_name\` | $srv_desc |"
  done
  replace_block "mcp" "$(echo -e "$tree_block")"
fi

# ── 4. Automatizaciones y Scripts ──
echo "  → Automatizaciones y Scripts..."
SCRIPTS_DIR="$WORKSPACE_ROOT/scripts"
table="| Script | Propósito | Uso |"
table="$table\n|--------|-----------|-----|"
while IFS= read -r -d '' f; do
  rel="${f#$SCRIPTS_DIR/}"
  desc=$(sed -n '/^# Description: /{s/^# Description: //; p; :a; n; /^#   /{s/^#   //; p; ba}; q}' "$f" | tr '\n' ' ' | sed 's/ $//')
  usage=$(sed -n '/^# Usage: /p' "$f" | sed 's/^# Usage: //')
  [ -z "$desc" ] && desc="—"
  [ -z "$usage" ] && usage="—"
  table="$table\n| \`scripts/$rel\` | $desc | \`$usage\` |"
done < <(find "$SCRIPTS_DIR" -name '*.sh' -type f -print0 | sort -z)
replace_block "scripts" "$(echo -e "$table")"

# ── 5. Regenerar scripts-reference.md ──
echo "  → Scripts Reference..."
if [ -f "$WORKSPACE_ROOT/scripts/docs/generate-scripts-ref.sh" ]; then
  bash "$WORKSPACE_ROOT/scripts/docs/generate-scripts-ref.sh"
fi

echo "[generate] Documentación actualizada."

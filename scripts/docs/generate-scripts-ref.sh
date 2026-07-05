#!/usr/bin/env bash
# scripts/docs/generate-scripts-ref.sh
# Description: Genera automáticamente docs/guide/scripts-reference.md a partir
#   de los doc headers estandarizados en cada script .sh. Se ejecuta como
#   pre-commit hook cuando scripts/ cambia, o manualmente cuando se desee.
# Usage: ./scripts/docs/generate-scripts-ref.sh
# Depends: (ninguna — solo bash)
# Env: (ninguna)
# Failures:
#   - Ningún script .sh encontrado → genera doc vacío (no es error)

set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUTPUT="$WORKSPACE_ROOT/docs/guide/scripts-reference.md"

# Collect all .sh files in scripts/
FILES=()
while IFS= read -r -d '' f; do
  FILES+=("$f")
done < <(find "$WORKSPACE_ROOT/scripts" -name '*.sh' -type f -print0 | sort -z)

cat > "$OUTPUT" <<EOF
# Scripts Reference

> Generado automáticamente por \`scripts/docs/generate-scripts-ref.sh\`.
> Se actualiza al commitear si hay cambios en \`scripts/\`.

EOF

if [ ${#FILES[@]} -eq 0 ]; then
  cat >> "$OUTPUT" <<EOF
_No scripts found._

EOF
  echo "[generate] No scripts found"
  exit 0
fi

for script in "${FILES[@]}"; do
  rel="${script#$WORKSPACE_ROOT/}"

  # Read the whole doc header block (lines between first # and first non-comment)
  header=$(sed -n '/^# scripts\//,/^[^#]/p' "$script" | head -n -1)

  desc=$(echo "$header" | sed -n '/^# Description: /{s/^# Description: //; p; :a; n; /^#   /{s/^#   //; p; ba}; q}' | tr '\n' ' ' | sed 's/ $//')
  usage=$(echo "$header" | sed -n '/^# Usage: /p' | sed 's/^# Usage: //')
  depends=$(echo "$header" | sed -n '/^# Depends: /p' | sed 's/^# Depends: //')
  env_vars=$(echo "$header" | sed -n '/^# Env: /p' | sed 's/^# Env: //')
  failures=$(echo "$header" | sed -n '/^# Failures:/,/^# [A-Z]/p' | sed -n 's/^#   - \(.*\)/\1/p')

  cat >> "$OUTPUT" <<EOF
## \`$rel\`

EOF

  [ -n "$desc" ] && cat >> "$OUTPUT" <<EOF
$desc

EOF

  [ -n "$usage" ] && cat >> "$OUTPUT" <<EOF
**Uso:** \`$usage\`

EOF

  [ -n "$depends" ] && cat >> "$OUTPUT" <<EOF
**Dependencias:** $depends

EOF

  [ -n "$env_vars" ] && cat >> "$OUTPUT" <<EOF
**Variables de entorno:** $env_vars

EOF

  if [ -n "$failures" ]; then
    cat >> "$OUTPUT" <<EOF
**Posibles fallas:**

EOF
    while IFS= read -r line; do
      echo "- $line" >> "$OUTPUT"
    done <<< "$failures"
    echo "" >> "$OUTPUT"
  fi

done

echo "[generate] Scripts reference generated: $OUTPUT (${#FILES[@]} scripts)"

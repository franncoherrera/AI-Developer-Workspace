#!/usr/bin/env bash
# Validates workspace integrity: rules, registry, and folder structure.
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REGISTRY="$WORKSPACE_ROOT/docs/references/technologies.json"
ISSUES=()

# Non-tech folders to exclude from orphan check
NON_TECH=("_template" "_common" "shared" "ide" "global" "code-review")

if [ ! -f "$REGISTRY" ]; then
  echo "Registry not found: $REGISTRY"
  exit 1
fi

# Check each rules directory has an AGENTS.md
for dir in "$WORKSPACE_ROOT/rules"/*/; do
  name=$(basename "$dir")
  [ ! -f "$dir/AGENTS.md" ] && ISSUES+=("MISSING: rules/$name/AGENTS.md")
done

# Check each registered technology
while IFS=$'\t' read -r key has_rules has_prompts has_config has_template; do
  [ -z "$key" ] && continue

  [ ! -f "$WORKSPACE_ROOT/rules/$key/AGENTS.md" ] && ISSUES+=("MISSING: rules/$key/AGENTS.md (registered)")

  if [ "$has_rules" = "true" ] && [ ! -d "$WORKSPACE_ROOT/rules/$key" ]; then
    ISSUES+=("MISSING: rules/$key/ (declared in registry)")
  fi
  if [ "$has_prompts" = "true" ] && [ ! -d "$WORKSPACE_ROOT/prompts/$key" ]; then
    ISSUES+=("MISSING: prompts/$key/ (declared in registry)")
  fi
  if [ "$has_config" = "true" ] && [ ! -d "$WORKSPACE_ROOT/config/$key" ]; then
    ISSUES+=("MISSING: config/$key/ (declared in registry)")
  fi
  if [ "$has_template" = "true" ] && [ ! -d "$WORKSPACE_ROOT/templates/$key" ]; then
    ISSUES+=("MISSING: templates/$key/ (declared in registry)")
  fi
done < <(jq -r '.technologies[] | "\(.key)\t\(.has.rules)\t\(.has.prompts)\t\(.has.config)\t\(.has.template)"' "$REGISTRY")

# Find orphan tech folders (exist but not registered)
KNOWN_KEYS=$(jq -r '.technologies[].key' "$REGISTRY" | tr '\n' '|')
for base in rules prompts config templates; do
  [ ! -d "$WORKSPACE_ROOT/$base" ] && continue
  for dir in "$WORKSPACE_ROOT/$base"/*/; do
    name=$(basename "$dir")
    is_non_tech=false
    for nt in "${NON_TECH[@]}"; do [ "$nt" = "$name" ] && is_non_tech=true && break; done
    $is_non_tech && continue
    if [[ ! "$KNOWN_KEYS" =~ (^|\|)"$name"(\||$) ]]; then
      ISSUES+=("ORPHAN: $base/$name/ (not registered)")
    fi
  done
done

if [ ${#ISSUES[@]} -eq 0 ]; then
  echo "All rules valid."
  exit 0
else
  echo "Found ${#ISSUES[@]} issue(s):"
  for issue in "${ISSUES[@]}"; do
    echo "  - $issue"
  done
  exit 1
fi

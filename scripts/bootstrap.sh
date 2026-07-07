#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$WORKSPACE_DIR"

echo "=============================="
echo " AI Developer Workspace Setup"
echo "=============================="

echo ""
echo "[1/3] Pulling latest changes from git..."
git pull --ff-only || echo "  (no remote or up to date)"

echo ""
echo "[2/3] Installing root dependencies (ecc-universal)..."
npm install

echo ""
echo "[3/3] Installing .opencode dependencies..."
if [ -f ".opencode/package.json" ]; then
  cd .opencode && npm install && cd "$WORKSPACE_DIR"
fi

echo ""
echo "=============================="
echo " Setup complete! Run ./opencode.sh to start."
echo "=============================="

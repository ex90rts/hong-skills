#!/usr/bin/env bash
# install.sh — Install @mermaid-js/mermaid-cli dependencies
#
# This installs into the managed node workspace, never globally.
# Re-run if Chromium download fails or to update the package.
#
# Strategy:
#   1. Install the npm package (mmdc + Puppeteer)
#   2. Try to install Puppeteer's bundled Chromium
#   3. If Chromium download fails (firewall / OOM), fall back to system Chrome
#      by writing a puppeteer config that points to it

set -euo pipefail

NODE_BIN="/Users/webber/.workbuddy/binaries/node/versions/22.22.2/bin/node"
NPM_BIN="/Users/webber/.workbuddy/binaries/node/versions/22.22.2/bin/npm"
WORKSPACE="/Users/webber/.workbuddy/binaries/node/workspace"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUPPET_CONFIG="$SCRIPT_DIR/puppeteer-config.json"

echo "📦 Installing @mermaid-js/mermaid-cli into $WORKSPACE"
mkdir -p "$WORKSPACE"
cd "$WORKSPACE"

# init package.json if missing
if [ ! -f "$WORKSPACE/package.json" ]; then
  "$NPM_BIN" init -y >/dev/null
fi

# Step 1: install npm package (without puppeteer download — we may not need bundled Chrome)
echo "1️⃣  Installing npm package..."
PUPPETEER_SKIP_DOWNLOAD=true "$NPM_BIN" install @mermaid-js/mermaid-cli 2>&1 | tail -3

# Step 2: try bundled Chromium
echo "2️⃣  Trying to install bundled Chromium for Puppeteer..."
if "$WORKSPACE/node_modules/.bin/puppeteer" browsers install chrome 2>&1 | tail -5; then
  echo "✅ Bundled Chromium installed."
  echo "   mmdc is at: $WORKSPACE/node_modules/@mermaid-js/mermaid-cli/src/cli.js"
  echo "   You can now run scripts/render.sh"
  exit 0
fi

echo "⚠️  Bundled Chromium download failed (firewall / OOM / network)."
echo "3️⃣  Falling back to system Google Chrome..."

# Step 3: write puppeteer config that uses system Chrome
SYSTEM_CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ ! -x "$SYSTEM_CHROME" ]; then
  echo "❌ System Google Chrome not found at $SYSTEM_CHROME" >&2
  echo "   Install Chrome from https://www.google.com/chrome/ or retry this script." >&2
  exit 1
fi

if [ ! -f "$PUPPET_CONFIG" ]; then
  cat > "$PUPPET_CONFIG" <<EOF
{
  "executablePath": "$SYSTEM_CHROME",
  "headless": "new",
  "args": [
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--disable-dev-shm-usage"
  ]
}
EOF
  echo "✅ Wrote puppeteer config to $PUPPET_CONFIG"
fi

echo ""
echo "✅ Setup complete (using system Chrome)."
echo "   mmdc:     $WORKSPACE/node_modules/@mermaid-js/mermaid-cli/src/cli.js"
echo "   Chrome:   $SYSTEM_CHROME"
echo "   Config:   $PUPPET_CONFIG"
echo "   You can now run scripts/render.sh"

#!/usr/bin/env bash
# render.sh — Render Mermaid source to PNG/HTML using mmdc
#
# Usage:
#   render.sh --input <file.mmd> [--output <file.png>] [--width N]
#             [--theme default|forest|dark|neutral]
#             [--background transparent|white]
#             [--cssFile <style.css>]
#
# Examples:
#   render.sh --input diagram.mmd
#   render.sh --input diagram.mmd --output diagram.png --width 2000 --background white
#   render.sh --input diagram.mmd --output diagram.png --cssFile ~/.workbuddy/skills/flowchart-generator/scripts/flowchart-theme.css
#
# This script auto-detects:
#   - mmdc in the managed node workspace
#   - system Chrome (preferred) or puppeteer's bundled Chromium
# and writes a puppeteer config to a temp file if needed.

set -euo pipefail

# ---- locate binaries ----
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

NODE_BIN="/Users/webber/.workbuddy/binaries/node/versions/22.22.2/bin/node"
WORKSPACE_NODE_MODULES="/Users/webber/.workbuddy/binaries/node/workspace/node_modules"
MMDC="$WORKSPACE_NODE_MODULES/@mermaid-js/mermaid-cli/src/cli.js"
PUPPET_CONFIG="$SCRIPT_DIR/puppeteer-config.json"
DEFAULT_CSS="$SCRIPT_DIR/flowchart-theme.css"

# ---- args ----
INPUT=""
OUTPUT=""
WIDTH=1600
HEIGHT=""
THEME="default"
BACKGROUND="white"
SCALE=2
CSS_FILE=""

print_usage() {
  sed -n '2,12p' "$0"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --input|-i)      INPUT="$2"; shift 2 ;;
    --output|-o)     OUTPUT="$2"; shift 2 ;;
    --width|-w)      WIDTH="$2"; shift 2 ;;
    --height)        HEIGHT="$2"; shift 2 ;;
    --theme|-t)      THEME="$2"; shift 2 ;;
    --background|-b) BACKGROUND="$2"; shift 2 ;;
    --cssFile)       CSS_FILE="$2"; shift 2 ;;
    --scale|-s)      SCALE="$2"; shift 2 ;;
    -h|--help)       print_usage; exit 0 ;;
    *)
      echo "❌ Unknown arg: $1" >&2
      print_usage >&2
      exit 1 ;;
  esac
done

# ---- preconditions ----
if [ ! -f "$MMDC" ]; then
  echo "❌ mmdc not found at $MMDC" >&2
  echo "   Run scripts/install.sh first" >&2
  exit 1
fi

if [ -z "$INPUT" ]; then
  echo "❌ --input is required" >&2
  print_usage >&2
  exit 1
fi

if [ ! -f "$INPUT" ]; then
  echo "❌ Input file not found: $INPUT" >&2
  exit 1
fi

# default output path
if [ -z "$OUTPUT" ]; then
  OUTPUT="${INPUT%.*}.png"
fi

# default CSS file
if [ -z "$CSS_FILE" ] && [ -f "$DEFAULT_CSS" ]; then
  CSS_FILE="$DEFAULT_CSS"
fi

# ---- pre-process badges for correct width measurement ----
PREPROCESS="$SCRIPT_DIR/preprocess-mermaid.py"
MMDC_INPUT="$(mktemp -t mermaid-input.XXXXXX).mmd"
if [ -f "$PREPROCESS" ]; then
  python3 "$PREPROCESS" "$INPUT" "$MMDC_INPUT"
else
  cp "$INPUT" "$MMDC_INPUT"
fi

# ---- mmdc args ----
MMDC_ARGS=(
  --input "$MMDC_INPUT"
  --output "$OUTPUT"
  --width "$WIDTH"
  --backgroundColor "$BACKGROUND"
  --scale "$SCALE"
  --quiet
)

if [ -n "$HEIGHT" ]; then
  MMDC_ARGS+=(--height "$HEIGHT")
fi

# CSS file
if [ -n "$CSS_FILE" ] && [ -f "$CSS_FILE" ]; then
  MMDC_ARGS+=(--cssFile "$CSS_FILE")
fi

# Puppeteer config: prefer system Chrome if available, fall back to bundled Chromium
PUPPET_TMP=""
if [ -f "$PUPPET_CONFIG" ]; then
  PUPPET_TMP="$PUPPET_CONFIG"
elif command -v "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" >/dev/null 2>&1; then
  PUPPET_TMP="$(mktemp -t mermaid-puppet.XXXXXX).json"
  cat > "$PUPPET_TMP" <<EOF
{
  "executablePath": "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
  "headless": "new",
  "args": ["--no-sandbox", "--disable-setuid-sandbox", "--disable-dev-shm-usage"]
}
EOF
fi

if [ -n "$PUPPET_TMP" ]; then
  MMDC_ARGS+=(--puppeteerConfigFile "$PUPPET_TMP")
fi

# Theme: mmdc 10+ uses --cssFile for custom themes; default needs no flag
case "$THEME" in
  default)  ;;  # use default, no flag
  forest)   THEME_FILE="$WORKSPACE_NODE_MODULES/@mermaid-js/mermaid-cli/src/themes/theme-forest.scss" ;;
  dark)     THEME_FILE="$WORKSPACE_NODE_MODULES/@mermaid-js/mermaid-cli/src/themes/theme-dark.scss" ;;
  neutral)  THEME_FILE="$WORKSPACE_NODE_MODULES/@mermaid-js/mermaid-cli/src/themes/theme-neutral.scss" ;;
  *)
    # treat as a custom CSS file path
    THEME_FILE="$THEME" ;;
esac

if [ -n "${THEME_FILE:-}" ] && [ -f "$THEME_FILE" ]; then
  MMDC_ARGS+=(--cssFile "$THEME_FILE")
fi

# ---- run mmdc ----
echo "🎨 Rendering: $INPUT → $OUTPUT"
( cd "$WORKSPACE_NODE_MODULES/../.." && "$NODE_BIN" "$MMDC" "${MMDC_ARGS[@]}" ) || {
  rc=$?
  echo "❌ mmdc failed (exit $rc). Common causes:" >&2
  echo "   - Syntax error in Mermaid (validate at https://mermaid.live)" >&2
  echo "   - Chromium / Chrome not found (use --puppeteer-config or set PUPPETEER_EXECUTABLE_PATH)" >&2
  if [ -n "$PUPPET_TMP" ] && [ "$PUPPET_TMP" != "$PUPPET_CONFIG" ]; then
    rm -f "$PUPPET_TMP"
  fi
  exit $rc
}

# cleanup
if [ -n "$PUPPET_TMP" ] && [ "$PUPPET_TMP" != "$PUPPET_CONFIG" ]; then
  rm -f "$PUPPET_TMP"
fi
rm -f "$MMDC_INPUT"

echo "✅ Done: $OUTPUT"

#!/usr/bin/env bash
set -euo pipefail

if [ "${1:-}" = "uninstall" ]; then
  echo ""
  echo "  🗑️  Uninstalling Dogeleena..."
  rm -rf ~/.config/dogeleena ~/.config/dogeleena.bak
  rm -rf ~/.local/share/dogeleena ~/.local/state/dogeleena ~/.cache/dogeleena
  rm -f ~/.local/bin/dogeleena
  echo "  ✅  Dogeleena removed. Your ~/.config/nvim is untouched."
  echo ""
  exit 0
fi

# Install
REPO="arpanpathak/dogeleena-neo-agentic-ide"
BRANCH="main"
CONFIG_DIR="${HOME}/.config/dogeleena"
BIN_DIR="${HOME}/.local/bin"

echo ""
echo "  🎀  Installing Dogeleena..."

# Check nvim
command -v nvim >/dev/null 2>&1 || { echo "  ❌  Neovim not found"; exit 1; }

# Download
TMPDIR=$(mktemp -d)
curl -fsSL "https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz" | tar xz -C "$TMPDIR" 2>/dev/null
SRC="${TMPDIR}/dogeleena-neo-agentic-ide-${BRANCH}"

# Backup existing
if [ -d "$CONFIG_DIR" ]; then
  rm -rf "${CONFIG_DIR}.bak" 2>/dev/null || true
  mv "$CONFIG_DIR" "${CONFIG_DIR}.bak"
fi

# Install config
mkdir -p "$CONFIG_DIR"/lua/plugins
cp "$SRC/init.lua" "$CONFIG_DIR/"
cp "$SRC"/lua/plugins/*.lua "$CONFIG_DIR/lua/plugins/"
echo "  ✅  Config installed to $CONFIG_DIR"

# Install launcher
mkdir -p "$BIN_DIR"
cp "$SRC/bin/dogeleena" "$BIN_DIR/dogeleena"
chmod +x "$BIN_DIR/dogeleena"
echo "  ✅  Launcher: $BIN_DIR/dogeleena"

# Cleanup
rm -rf "$TMPDIR"

echo ""
echo "  🎀  Dogeleena installed!"
echo "  Launch: dogeleena"
echo ""
echo "  Uninstall: dogeleena-neo-agentic-ide uninstall"
echo "  (or run: curl -fsSL https://raw.githubusercontent.com/arpanpathak/dogeleena-neo-agentic-ide/main/install.sh | bash -s uninstall)"
echo ""
echo "  Set your AI key: export ANTHROPIC_API_KEY=\"sk-ant-...\""
echo ""

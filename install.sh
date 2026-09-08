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
VERSION="v0.1.2"
CONFIG_DIR="${HOME}/.config/dogeleena"
BIN_DIR="${HOME}/.local/bin"

echo ""
echo "  🎀  Installing Dogeleena..."

# aarch64 / ARM64 (e.g. Jetson, Raspberry Pi) needs build tools to compile
# Treesitter parsers and some language servers.
ARCH="$(uname -m)"
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  echo "  🐾  ARM64/aarch64 detected — checking build tools..."
  if ! command -v git >/dev/null 2>&1 || ! command -v gcc >/dev/null 2>&1 || ! command -v make >/dev/null 2>&1; then
    echo "  ⚠️  Missing build tools. Installing build-essential and git (sudo required)..."
    sudo apt update
    sudo apt install -y build-essential git
  fi
fi

# Check nvim
command -v nvim >/dev/null 2>&1 || { echo "  ❌  Neovim not found"; exit 1; }

# Download
TMPDIR=$(mktemp -d)
SRC="${TMPDIR}/dogeleena"
mkdir -p "$SRC"
curl -fsSL "https://github.com/${REPO}/archive/refs/tags/${VERSION}.tar.gz" | tar xz -C "$SRC" --strip-components=1 2>/dev/null

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
echo "  (or run: curl -fsSL https://raw.githubusercontent.com/arpanpathak/dogeleena-neo-agentic-ide/v0.1.2/install.sh | bash -s uninstall)"
echo ""
echo "  Set your AI key: export ANTHROPIC_API_KEY=\"sk-ant-...\""
echo ""

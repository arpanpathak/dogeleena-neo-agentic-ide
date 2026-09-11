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
VERSION="v0.1.9"
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

# ── Neovim: prefer a stable build ─────────────────────────────────────────────
# Distro / neovim-ppa "unstable" packages are 0.x.y-dev nightlies and can
# segfault under heavy plugin + LSP + treesitter load (looks like being dumped
# back to the terminal at random). If the system Neovim is a dev build (or
# missing), install a stable release under ~/.local/opt — bin/dogeleena uses it.
NVIM_STABLE_VERSION="v0.12.5"
NVIM_STABLE_DIR="${HOME}/.local/opt/nvim-${NVIM_STABLE_VERSION#v}"
NVIM_NEEDS_STABLE=0
if ! command -v nvim >/dev/null 2>&1; then
  NVIM_NEEDS_STABLE=1
elif nvim --version 2>/dev/null | head -1 | grep -q -- '-dev'; then
  echo "  🧯  System Neovim is a dev build (unstable) — Dogeleena will use a stable one."
  NVIM_NEEDS_STABLE=1
fi
if [ "$NVIM_NEEDS_STABLE" = 1 ] && [ ! -x "${NVIM_STABLE_DIR}/bin/nvim" ]; then
  case "$ARCH" in
    aarch64|arm64) NVIM_ASSET="nvim-linux-arm64.tar.gz" ;;
    x86_64|amd64)  NVIM_ASSET="nvim-linux-x86_64.tar.gz" ;;
    *)             NVIM_ASSET="" ;;
  esac
  if [ -n "$NVIM_ASSET" ]; then
    echo "  ⬇️  Installing stable Neovim ${NVIM_STABLE_VERSION} to ${NVIM_STABLE_DIR}..."
    _nvim_tmp="$(mktemp -d)"
    if curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_STABLE_VERSION}/${NVIM_ASSET}" \
        | tar xz -C "$_nvim_tmp" 2>/dev/null; then
      mkdir -p "${HOME}/.local/opt"
      rm -rf "$NVIM_STABLE_DIR"
      mv "$_nvim_tmp"/nvim-linux-* "$NVIM_STABLE_DIR"
      echo "  ✅  Stable Neovim installed."
    else
      echo "  ⚠️  Could not download stable Neovim — falling back to the system build."
    fi
    rm -rf "$_nvim_tmp"
  fi
fi
if ! command -v nvim >/dev/null 2>&1 && [ ! -x "${NVIM_STABLE_DIR}/bin/nvim" ]; then
  echo "  ❌  Neovim not found and stable download failed"; exit 1
fi

# Check tree-sitter CLI (needed by nvim-treesitter main to build parsers).
export PATH="${HOME}/.local/bin:${PATH}"
if ! command -v tree-sitter >/dev/null 2>&1; then
  if command -v cargo >/dev/null 2>&1; then
    echo "  ⚙️  tree-sitter-cli not found. Installing via cargo (first time takes a few minutes)..."
    cargo install tree-sitter-cli --version 0.27.0 --root "${HOME}/.local"
  else
    echo "  ❌  tree-sitter-cli not found and cargo is not available."
    echo "     Install Rust/cargo or tree-sitter-cli, then re-run this script."
    exit 1
  fi
fi

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
cp "$SRC/lazy-lock.json" "$CONFIG_DIR/lazy-lock.json"
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
echo "  (or run: curl -fsSL https://raw.githubusercontent.com/arpanpathak/dogeleena-neo-agentic-ide/v0.1.9/install.sh | bash -s uninstall)"
echo ""
echo "  Set your AI key: export ANTHROPIC_API_KEY=\"sk-ant-...\""
echo ""

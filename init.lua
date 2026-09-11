-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                                                                              ║
-- ║         ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄                                               ║
-- ║      ▄████████████████████████▄                                            ║
-- ║    ▄██████████████████████████████▄                                        ║
-- ║   ▄████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██████▄                                     ║
-- ║   ████▀              ▄▄▄▄▄▄▄     ▀████▄                                   ║
-- ║  ████▀            ▄▄████████████▄   ▀████▄                                ║
-- ║  ████▌          ▄█████████████████▄   ▐████                               ║
-- ║ ▐████         ▄████▀▀▀▀▀▀▀▀▀██████▄   ████▌                              ║
-- ║ ████▌        ▐████   ▄▄▄▄▄▄▄▄▄   ▐████   ▐████                             ║
-- ║ █████        ████▌   ▐█████████▌  ████▌    ████▌                            ║
-- ║ █████        ████▌    ▀▀▀▀▀▀▀▀▀  ▐████     ████▌  🎀                        ║
-- ║ ▐████       ▐████     ▄▄▄▄▄▄▄▄▄▄  ████▌    █████                            ║
-- ║  ████▌      ████▌    ▐████████████ ████▌    ████▌                            ║
-- ║  ▐████      ████▌     ▀▀▀▀▀▀▀▀▀▀ ▐████    ████▌                            ║
-- ║   ████▄     ████▌      ▄▄▄▄▄▄▄▄▄▄ ████▌   ▄████                             ║
-- ║    ▀████▄▄  ▀████▄   ▐████████▌ ▐████  ▄████▀                               ║
-- ║     ▀██████▄ ▀█████▄  ▀▀▀▀▀▀▀▀  ████ ▄████▀                                 ║
-- ║       ▀█████▄ ▀▀████████████████▀▀ ▄████▀                                   ║
-- ║          ▀▀████████████████████████▀▀                                       ║
-- ║                                                                              ║
-- ║      M U C H   C O D E .   S U C H   A I .   W O W .                        ║
-- ║      V E R Y   A G E N T I C .   S O   V I M .                              ║
-- ║                                                                              ║
-- ║           🐕  D O G E L E E N A  —  Neo-Agentic IDE  🎀                     ║
-- ║                                                                              ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝
--
-- Dogeleena is a female Shiba Inu agent. She lives in your terminal.
-- She codes. She refactors. She ships. Much wow.
--
-- Requirements:
--   • Neovim >= 0.11.0
--   • Git >= 2.19
--   • A Nerd Font (see fonts/ directory)
--   • Node.js >= 18 (for TypeScript LSP)
--   • Python >= 3.8 (for Pyright LSP)
--   • Java >= 17 (for Kotlin/Java LSP)
--
-- Quick Start:
--   1. Install a Nerd Font from fonts/ directory
--   2. Set your AI API key: export ANTHROPIC_API_KEY="sk-ant-..."
--   3. Launch: nvim
--   4. LSP servers auto-install on first run
--   5. <leader>ac to summon Dogeleena

-- ═══════════════════════════════════════════════════════════════════════════════
-- 1. LEADER KEY
-- ═══════════════════════════════════════════════════════════════════════════════
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ═══════════════════════════════════════════════════════════════════════════════
-- 2. CORE EDITOR OPTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.showmode = false

-- Behavior
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false

-- ═══════════════════════════════════════════════════════════════════════════════
-- 3. PLUGIN MANAGER (lazy.nvim)
-- ═══════════════════════════════════════════════════════════════════════════════
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. THEME TOGGLE — Cycle between Material Deep Ocean and tokyonight
-- ═══════════════════════════════════════════════════════════════════════════════
local current_theme = "material"
local function toggle_theme()
  if current_theme == "material" then
    vim.cmd.colorscheme("tokyonight")
    current_theme = "tokyonight"
  else
    vim.cmd.colorscheme("material")
    current_theme = "material"
  end
  vim.notify('Theme: ' .. current_theme, vim.log.levels.INFO)
end
vim.keymap.set("n", "<leader>th", toggle_theme,
  { silent = true, desc = "Theme — Toggle" })

-- ═══════════════════════════════════════════════════════════════════════════════
-- 5. DON'T EXIT BY ACCIDENT
-- ═══════════════════════════════════════════════════════════════════════════════
-- Nothing in this config should quit Neovim from a single stray key. Quit with
-- `:q` / `:qa` (or `ZZ`) when you actually mean it.
--
-- `<C-w>q` / `<C-w>c` are the classic "why did my editor close?!" trap: they
-- kill the last window, and Neovim exits when the last window closes. Guard
-- them so they only close a split, and warn instead of exiting.
local function close_window_safely()
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    vim.cmd("close")
  else
    vim.notify("Not closing the last window — use :q to quit Neovim",
      vim.log.levels.WARN)
  end
end
vim.keymap.set("n", "<C-w>q", close_window_safely,
  { silent = true, desc = "Close window (guarded against quitting)" })
vim.keymap.set("n", "<C-w>c", close_window_safely,
  { silent = true, desc = "Close window (guarded against quitting)" })

# Keybindings

`<leader>` is `<space>` by default.

## Editor & AI

| Key | Action |
|-----|--------|
| `<leader>e` | Reveal current file in the file explorer |
| `<leader>ac` | Open AI chat |
| `<leader>aa` | Open AI chat (alias) |
| `<leader>ae` | AI actions (visual mode) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fr` | Recent files |
| `<leader>th` | Toggle colour theme |

> **Quit with `:q` / `:qa`.** There is intentionally no single-key quit binding —
> a stray key used to close Neovim and dump you back to the shell.

## LSP

These are buffer-local and only active once a language server has attached
(TS/JS, Python, C/C++, Kotlin, Java, Rust).

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

## Diagnostics & errors

The `E`/`W` sign in the gutter only tells you a line has a problem — it does
not say what. These show the actual message:

| Key | Action |
|-----|--------|
| *(pause cursor)* | Rest the cursor on the line; the full message pops up automatically |
| `<leader>de` | Show the error/warning under the cursor (floating window) |
| `<leader>dl` | List all diagnostics (location list, then `:lopen`) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

The message is also shown inline at the end of the line (`● ...`) and the bad
code is underlined, so you usually don't even need to open the popup.

## Neo-tree (file explorer)

| Key | Action |
|-----|--------|
| `<CR>` | Open file |
| `a` | New file/dir |
| `d` | Delete |
| `r` | Rename |
| `H` | Hidden files |

# Vim Motions & Dogeleena Keybindings

---

## 1. Basic Movement

| Key | Motion |
|-----|--------|
| `h` / `j` / `k` / `l` | Left / Down / Up / Right |
| `w` / `W` | Next word / Next WORD |
| `b` / `B` | Previous word / Previous WORD |
| `e` / `E` | End of word / End of WORD |
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-whitespace character |
| `g_` | Last non-whitespace character |
| `gg` | First line of file |
| `G` | Last line of file |
| `:{number}` | Go to line number |
| `{number}G` | Go to line number |
| `{number}j` | Move down N lines |
| `{number}k` | Move up N lines |
| `Ctrl+f` / `PageDown` | Page down |
| `Ctrl+b` / `PageUp` | Page up |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+e` / `Ctrl+y` | Scroll down/up by one line |
| `zz` | Center cursor on screen |
| `zt` | Cursor to top of screen |
| `zb` | Cursor to bottom of screen |
| `H` | Move cursor to top of screen |
| `M` | Move cursor to middle of screen |
| `L` | Move cursor to bottom of screen |
| `%` | Jump to matching bracket |
| `{` / `}` | Previous/Next paragraph |
| `(` / `)` | Previous/Next sentence |

---

## 2. Window Management (`Ctrl+w`)

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+w h` | Move to window on the left |
| `Ctrl+w j` | Move to window below |
| `Ctrl+w k` | Move to window above |
| `Ctrl+w l` | Move to window on the right |
| `Ctrl+w w` | Cycle to next window |
| `Ctrl+w W` | Cycle to previous window |
| `Ctrl+w t` | Move to top-left window |
| `Ctrl+w b` | Move to bottom-right window |
| `Ctrl+w p` | Move to previous window |

*Dogeleena also provides:* `Ctrl+h/j/k/l` for direct window navigation (if `which-key` or similar is configured).

### Split Management

| Key | Action |
|-----|--------|
| `Ctrl+w s` | Split horizontally |
| `Ctrl+w v` | Split vertically |
| `Ctrl+w o` | Close all other windows (keep current) |
| `Ctrl+w c` | Close current window |
| `Ctrl+w q` | Close current window / quit |
| `Ctrl+w x` | Swap windows |
| `Ctrl+w r` | Rotate windows |
| `Ctrl+w R` | Rotate windows backwards |
| `Ctrl+w T` | Move window to new tab |

### Split Resizing

| Key | Action |
|-----|--------|
| `Ctrl+w =` | Make all splits equal size |
| `Ctrl+w _` | Maximize current window height |
| `Ctrl+w \|` | Maximize current window width |
| `Ctrl+w +` | Increase height by 1 |
| `Ctrl+w -` | Decrease height by 1 |
| `Ctrl+w >` | Increase width by 1 |
| `Ctrl+w <` | Decrease width by 1 |
| `{N}Ctrl+w +` | Increase height by N |
| `{N}Ctrl+w -` | Decrease height by N |
| `:resize +{N}` | Increase height by N |
| `:resize -{N}` | Decrease height by N |
| `:vertical resize +{N}` | Increase width by N |
| `:vertical resize -{N}` | Decrease width by N |
| `:resize {N}` | Set height to N |
| `:vertical resize {N}` | Set width to N |

---

## 3. Tab Management

| Key | Action |
|-----|--------|
| `:tabnew` / `:tabe` | Open new tab |
| `:tabclose` / `:tabc` | Close current tab |
| `gt` | Next tab |
| `gT` | Previous tab |
| `{N}gt` | Go to tab N |
| `:tabn` | Next tab |
| `:tabp` | Previous tab |
| `:tabfirst` / `:tabfir` | First tab |
| `:tablast` / `:tabl` | Last tab |
| `:tabm {N}` | Move tab to position N |
| `:tabmove +{N}` | Move tab forward by N |
| `:tabmove -{N}` | Move tab backward by N |

---

## 4. Editing

### Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `I` | Insert at start of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `s` | Delete character and insert |
| `S` | Delete line and insert |
| `C` | Delete from cursor to end of line and insert |
| `D` | Delete from cursor to end of line |
| `cc` | Change (replace) entire line |
| `r` | Replace single character |
| `R` | Replace mode |

### Text Objects

| Key | Action |
|-----|--------|
| `ciw` | Change inner word |
| `diw` | Delete inner word |
| `yiw` | Yank inner word |
| `caw` | Change around word |
| `ci"` | Change inside double quotes |
| `ci'` | Change inside single quotes |
| `ci(` / `ci)` | Change inside parentheses |
| `ci[` / `ci]` | Change inside brackets |
| `ci{` / `ci}` | Change inside braces |
| `ci<` / `ci>` | Change inside angle brackets |
| `cit` | Change inside HTML/XML tag |
| `dap` | Delete around paragraph |
| `cap` | Change around paragraph |
| `vis` | Select around sentence |

### Deletion

| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dd` | Delete line |
| `{N}dd` | Delete N lines |
| `dw` | Delete word |
| `db` | Delete word backwards |
| `d$` / `D` | Delete to end of line |
| `d0` | Delete to start of line |
| `d^` | Delete to first non-whitespace |
| `dG` | Delete to end of file |
| `dgg` | Delete to start of file |
| `df{char}` | Delete until character |
| `dt{char}` | Delete until before character |

### Yank (Copy) & Paste

| Key | Action |
|-----|--------|
| `yy` / `Y` | Yank (copy) line |
| `{N}yy` | Yank N lines |
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `y0` | Yank to start of line |
| `y}` | Yank to end of paragraph |
| `p` | Paste after cursor / below |
| `P` | Paste before cursor / above |
| `gp` | Paste after and move cursor |
| `gP` | Paste before and move cursor |
| `"0p` | Paste from register 0 (last yank) |
| `"+p` | Paste from system clipboard |
| `"*p` | Paste from selection clipboard |

### Undo / Redo / Repeat

| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last change |
| `U` | Restore last changed line |
| `g-` | Go back in undo history |
| `g+` | Go forward in undo history |
| `:earlier {N}s` | Go back N seconds |
| `:later {N}s` | Go forward N seconds |
| `:undolist` | List undo branches |

### Indentation

| Key | Action |
|-----|--------|
| `>>` | Indent line right |
| `<<` | Indent line left |
| `{N}>>` | Indent N lines right |
| `{N}<<` | Indent N lines left |
| `>g` | Indent until end of file |
| `=%` | Indent code block (bracket) |
| `gg=G` | Auto-indent entire file |
| `==` | Auto-indent current line |

### Case

| Key | Action |
|-----|--------|
| `~` | Toggle case of character |
| `g~w` | Toggle case of word |
| `guw` | Lowercase word |
| `gUw` | Uppercase word |
| `guu` | Lowercase line |
| `gUU` | Uppercase line |
| `g~~` | Toggle case of entire line |

---

## 5. Visual Mode

| Key | Action |
|-----|--------|
| `v` | Visual character mode |
| `V` | Visual line mode |
| `Ctrl+v` | Visual block mode |
| `gv` | Reselect last visual selection |
| `o` | Jump to opposite end of selection |
| `O` | (Block mode) Jump to opposite corner |
| `~` | Toggle case of selection |
| `u` | Lowercase selection |
| `U` | Uppercase selection |
| `>` | Indent selection right |
| `<` | Indent selection left |
| `y` | Yank (copy) selection |
| `d` | Delete selection |
| `c` | Delete selection and insert |
| `r{char}` | Replace selection with character |
| `J` | Join selected lines |
| `:` | Enter command mode with range pre-filled |
| `gi` | Exit visual mode and enter insert |

---

## 6. Search & Replace

### Searching

| Key | Action |
|-----|--------|
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next match (same direction) |
| `N` | Previous match (opposite direction) |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `g*` | Search partial word forward |
| `g#` | Search partial word backward |

### Search Settings

| Command | Action |
|---------|--------|
| `:nohlsearch` / `:noh` | Clear search highlights |
| `:set hlsearch` | Enable search highlighting |
| `:set nohlsearch` | Disable search highlighting |
| `:set incsearch` | Enable incremental search |
| `:set ignorecase` | Case-insensitive search |
| `:set smartcase` | Smart case matching |

### Replace

| Command | Action |
|---------|--------|
| `:%s/old/new/g` | Replace all occurrences in file |
| `:%s/old/new/gc` | Replace with confirmation |
| `:s/old/new/g` | Replace in current line only |
| `:5,10s/old/new/g` | Replace in lines 5-10 |
| `:%s/old/new/gi` | Replace case-insensitive |
| `:.,$s/old/new/g` | Replace from cursor to end |

---

## 7. Buffers

| Key | Action |
|-----|--------|
| `:e {file}` | Open file for editing |
| `:b {name}` | Switch to buffer (tab-complete) |
| `:bnext` / `:bn` | Next buffer |
| `:bprevious` / `:bp` | Previous buffer |
| `:bfirst` / `:bf` | First buffer |
| `:blast` / `:bl` | Last buffer |
| `:bd` | Delete buffer |
| `:bw` | Wipe buffer |
| `:ls` | List open buffers |
| `:b{N}` | Switch to buffer N |
| `Ctrl+^` | Toggle previous buffer |
| `:BufOnly` | Close all buffers except current *(if plugin)* |
| `{N}Ctrl+^` | Switch to alternate buffer N |

---

## 8. Marks

| Key | Action |
|-----|--------|
| `mx` | Set mark `x` at cursor position |
| `'x` | Jump to line of mark `x` |
| `` `x `` | Jump to exact position of mark `x` |
| `'0` | Jump to position of last exit |
| `'^` | Jump to position of last edit |
| `'.` | Jump to position of last change |
| `:marks` | List all marks |
| `:delm {x}` | Delete mark `x` |
| `:delm!` | Delete all marks |
| `'[` / `']` | Jump to start/end of last change |
| `'<' / `'>` | Jump to start/end of last visual selection |

---

## 9. Folding

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zA` | Toggle fold recursively |
| `zo` | Open fold |
| `zO` | Open fold recursively |
| `zc` | Close fold |
| `zC` | Close all folds recursively |
| `zM` | Close all folds |
| `zR` | Open all folds |
| `zm` | Fold more (increase fold level) |
| `zr` | Reduce folding (decrease fold level) |
| `zd` | Delete fold at cursor |
| `zE` | Eliminate all folds |
| `zf` | Create fold (visual selection) |
| `:fold` | Create fold from command |
| `:foldopen!` | Open all folds |
| `:foldclose!` | Close all folds |

---

## 10. Registers

| Key | Action |
|-----|--------|
| `""` | Default (unnamed) register |
| `"0` | Last yank |
| `"1` - `"9` | Deleted text history (1 = most recent) |
| `"-` | Small delete (< 1 line) |
| `".` | Last inserted text |
| `":` | Last command |
| `"/` | Last search |
| `"%` | Current file path |
| `"=` | Expression register |
| `"+` | System clipboard |
| `"*` | Selection clipboard |
| `"_` | Black hole (delete without saving) |

**Usage:** `"ap` → paste from register a, `"+yy` → yank to system clipboard

---

## 11. Macros

| Key | Action |
|-----|--------|
| `q{letter}` | Start recording macro into register |
| `q` | Stop recording |
| `@{letter}` | Run macro once |
| `{N}@{letter}` | Run macro N times |
| `@@` | Repeat last macro |
| `:reg {letter}` | View macro contents |
| `:normal @{letter}` | Run macro on multiple lines |

---

## 12. Jumps & Navigation

| Key | Action |
|-----|--------|
| `Ctrl+o` | Jump back (previous location) |
| `Ctrl+i` | Jump forward (next location) |
| `g,` | Jump to next change in change list |
| `g;` | Jump to previous change in change list |
| `Ctrl+]` | Jump to tag definition |
| `Ctrl+t` | Jump back from tag |
| `gf` | Open file under cursor |
| `gF` | Open file under cursor at line number |
| `:jumps` | List jump history |
| `:changes` | List change history |

---

## 13. Dogeleena-Specific Keybindings

| Key | Action |
|-----|--------|
| `<Space>ac` | Open AI Code Companion Chat |
| `<Space>aa` | Open AI Code Companion Chat (alias) |
| `<Space>ae` | AI Code Actions (visual mode) |
| `<Space>e` | Toggle Neo-tree file explorer |
| `<Space>f` | Find file (Telescope) |
| `<Space>r` | Recent files (Telescope) |
| `<Space>g` | Live grep / find text (Telescope) |
| `<Space>th` | Toggle color theme |
| `<Space>q` | Quit |

---

## 14. Quick Reference Cheatsheet

```
Movement:   h ←  j ↓  k ↑  l →
Windows:    Ctrl+w  then  h/j/k/l/s/v/o/c/q/=/_/|/+/-
Tabs:       gt  gT  :tabnew  :tabclose
Editing:    i/I/a/A/o/O  dd/yy/p  u/Ctrl+r  .
Visual:     v/V/Ctrl+v  y/d/c/~
Search:     / ? n N * #
Buffers:    :bn :bp :bd :ls Ctrl+^
Folds:      za zo zc zM zR zf zd zE
Marks:      mx 'x `x :marks
Registers:  "0 "9 "+ "*  "a-"z
Macros:     q{letter} commands q  @{letter}
Jumps:      Ctrl+o  Ctrl+i
```

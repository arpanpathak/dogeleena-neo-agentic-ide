# Dogeleena — Neo-Agentic IDE

```
                Y.                      _   
                YiL                   .```.  
                Yii;                .; .;;`.    
                YY;ii._           .;`.;;;; :    
                iiYYYYYYiiiii;;;;i` ;;::;;;;    
            _.;YYYYYYiiiiiiYYYii  .;;.   ;;; 
         .YYYYYYYYYYiiYYYYYYYYYYYYii;`  ;;;;    
       .YYYYYYY$$YYiiYY$$$$iiiYYYYYY;.ii;`..   
      :YYY$!.  TYiiYY$$$$$YYYYYYYiiYYYYiYYii.    
      Y$MM$:   :YYYYYY$!"``"4YYYYYiiiYYYYiiYY.    
   `. :MM$$b.,dYY$$Yii" :'   :YYYYllYiiYYYiYY    
_.._ :`4MM$!YYYYYYYYYii,.__.diii$$YYYYYYYYYYY
.,._ $b`P`     "4$$$$$iiiiiiii$$$$YY$$$$$$YiY;
   `,.`$:       :$$$$$$$$$YYYYY$$$$$$$$$YYiiYYL
    "`;$$.    .;PPb$`.,.``T$$YY$$$$YYYYYYiiiYYU:  
    ;$P$;;: ;;;;i$y$"!Y$$$b;$$$Y$YY$$YYYiiiYYiYY 
    $Fi$$ .. ``:iii.`-":YYYYY$$YY$$$$$YYYiiYiYYY    
    :Y$$rb ````  `_..;;i;YYY$YY$$$$$$$YYYYYYYiYY:    
     :$$$$$i;;iiiiidYYYYYYYYYY$$$$$$YYYYYYYiiYYYY. 
      `$$$$$$$YYYYYYYYYYYYY$$$$$$YYYYYYYYiiiYYYYYY    
      .i!$$$$$$YYYYYYYYY$$$$$$YYY$$YYiiiiiiYYYYYYY    
     :YYiii$$$$$$$YYYYYYY$$$$YY$$$$YYiiiiiYYYYYYi'    

> 🎀 **DOGELEENA** — Neo-Agentic IDE
```

One-command install. Zero config. Zero interference with existing Neovim.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/arpanpathak/dogeleena-neo-agentic-ide/main/install.sh | bash
```

Then set your AI key and launch:
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
dogeleena
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/arpanpathak/dogeleena-neo-agentic-ide/main/install.sh | bash -s uninstall
```

## Features

- AI chat (OpenAI, Anthropic, DeepSeek, Gemini, Ollama — set env var)
- LSP: TypeScript, Python, C/C++, Kotlin, Java, Rust
- File explorer, buffer tabs, markdown preview
- 100% isolated from your ~/.config/nvim

## Leader Key

All custom shortcuts use a **leader key** — a prefix key you press before the shortcut.

**Default:** `<space>` (spacebar). So `<leader>e` means press space then e.

**To change it**, edit `~/.config/dogeleena/init.lua` and find:

```lua
vim.g.mapleader = " "
```

Replace `" "` with your preferred key. Common choices:

| Key | Setting | Notes |
|-----|---------|-------|
| Space | `vim.g.mapleader = " "` | Default. Ergonomic, easy to reach |
| Comma | `vim.g.mapleader = ","` | Popular with vim veterans |
| Semicolon | `vim.g.mapleader = ";"` | Good if you rarely use `;` |
| Tab | `vim.g.mapleader = "\\t"` | Unused by default in normal mode |

After changing, restart Dogeleena. All `<leader>` shortcuts use your new key.

## Themes

Dogeleena ships with **Night Owl** 🦉 — a dark theme optimized for long coding sessions. Low contrast, low eye strain.

If you want to try others, swap the plugin in `colorscheme.lua`:

| Theme | Mood | Plugin Name |
|-------|------|-------------|
| **Night Owl** 🦉 | Dark, low contrast | `oxfist/night-owl.nvim` **(default, included)** |
| **Catppuccin Mocha** 🧋 | Warm dark, cozy | `catppuccin/nvim` |
| **Nord** ❄️ | Arctic blue, frosty | `shaunsingh/nord.nvim` |
| **Oceanic Next** 🌊 | Deep ocean blue | `mhartington/oceanic-next` |

To switch, edit `~/.config/dogeleena/lua/plugins/colorscheme.lua`. Example for Catppuccin:

```lua
return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",  -- mocha | macchiato | frappe | latte
    transparent_background = false,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
```

Restart dogeleena. Lazy.nvim auto-downloads the new theme.

## Keybinds

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer |
| `<leader>ac` | AI chat |
| `<leader>ae` | AI actions (visual) |
| `gd` | Go to definition |
| `K` | Hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename |

## AI Providers

Set one env var:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."  # Claude
export OPENAI_API_KEY="sk-..."         # GPT-4o
export DEEPSEEK_API_KEY="sk-..."       # DeepSeek
export GEMINI_API_KEY="..."            # Gemini
```

## Docs

- [Keybindings](doc/KEYBINDINGS.md)
- [Vim Motions](doc/VIM-MOTIONS.md)
- [AI Setup](doc/AI.md)
- [Fonts](fonts/README.md)

## License

MIT

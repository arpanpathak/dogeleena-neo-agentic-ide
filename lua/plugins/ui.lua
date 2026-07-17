return {
  -- ── Startup Dashboard: Dogeleena ASCII Art ─────────────────────────────────
  {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Dogeleena mascot as header (from README)
      dashboard.section.header.val = {
        "",
        "                Y.                      _   ",
        "                YiL                   .```.  ",
        "                Yii;                .; .;;`.    ",
        "                YY;ii._           .;`.;;;; :    ",
        "                iiYYYYYYiiiii;;;;i` ;;::;;;;    ",
        "            _.;YYYYYYiiiiiiYYYii  .;;.   ;;; ",
        "         .YYYYYYYYYYiiYYYYYYYYYYYYii;`  ;;;;    ",
        "       .YYYYYYY$$YYiiYY$$$$iiiYYYYYY;.ii;`..   ",
        "      :YYY$!.  TYiiYY$$$$$YYYYYYYiiYYYYiYYii.    ",
        "      Y$MM$:   :YYYYYY$!\"``\"4YYYYYiiiYYYYiiYY.    ",
        "   `. :MM$$b.,dYY$$Yii\" :'   :YYYYllYiiYYYiYY    ",
        "_.._ :`4MM$!YYYYYYYYYii,.__.diii$$YYYYYYYYYYY",
        ".,._ $b`P`     \"4$$$$$iiiiiiii$$$$YY$$$$$$YiY;",
        "   `,.`$:       :$$$$$$$$$YYYYY$$$$$$$$$YYiiYYL",
        "    \"`;$$.    .;PPb$`.,.``T$$YY$$$$YYYYYYiiiYYU:  ",
        "    ;$P$;;: ;;;;i$y$\"!Y$$$b;$$$Y$YY$$YYYiiiYYiYY ",
        "    $Fi$$ .. ``:iii.`-\":YYYYY$$YY$$$$$YYYiiiYiYYY    ",
        "    :Y$$rb ````  `_..;;i;YYY$YY$$$$$$$YYYYYYYiYY:    ",
        "     :$$$$$i;;iiiiidYYYYYYYYYY$$$$$$YYYYYYYiiYYYY. ",
        "      `$$$$$$$YYYYYYYYYYYYY$$$$$$YYYYYYYYiiiYYYYYY    ",
        "      .i!$$$$$$YYYYYYYYY$$$$$$YYY$$YYiiiiiiYYYYYYY    ",
        "     :YYiii$$$$$$$YYYYYYY$$$$YY$$$$YYiiiiiYYYYYYi'    ",
        "",
        "                  🎀  D O G E L E E N A  —  Neo-Agentic IDE  🎀",
        "",
      }

      -- Buttons / shortcuts
      dashboard.section.buttons.val = {
        dashboard.button("e", "  📁  Explorer", ":Neotree focus<CR>"),
        dashboard.button("f", "  🔍  Find File", ":Telescope find_files<CR>"),
        dashboard.button("r", "  📄  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  🔎  Find Text", ":Telescope live_grep<CR>"),
        dashboard.button("q", "  ❌  Quit", ":qa<CR>"),
      }

      -- Footer: version + AI adapter info
      local function footer()
        local ai_env = os.getenv("ANTHROPIC_API_KEY") and "Claude"
          or os.getenv("OPENAI_API_KEY") and "OpenAI"
          or os.getenv("DEEPSEEK_API_KEY") and "DeepSeek"
          or os.getenv("GEMINI_API_KEY") and "Gemini"
          or os.getenv("OPENROUTER_API_KEY") and "OpenRouter"
          or os.getenv("OLLAMA_HOST") and "Ollama (local)"
          or "None set"
        return "🧠 AI: " .. ai_env .. "    ⚡ nvim v"
          .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
      end
      dashboard.section.footer.val = footer()

      -- Allow leader key (Space) to work on the dashboard
      -- MUST be before alpha.setup() — the FileType event fires during setup()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function(args)
          vim.bo[args.buf].modifiable = true
        end,
      })

      alpha.setup(dashboard.opts)
    end,
  },

  -- ── Color Theme: night-owl (default) ───────────────────────────────────────
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 900,
    config = function()
      require("night-owl").setup({
        bold = true,
        italics = true,
        underline = true,
        undercurl = true,
        transparent_background = false,
      })
      vim.cmd.colorscheme("night-owl")
    end,
  },

  -- ── Theme Toggle: cycle between night-owl and tokyonight ───────────────────
  -- Toggle with: <leader>th
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 900,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })
    end,
  },
}

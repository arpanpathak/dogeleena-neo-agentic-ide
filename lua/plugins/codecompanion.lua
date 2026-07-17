-- ~/.config/nvim/lua/plugins/codecompanion.lua
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  -- Lazy-load on these keybinds so the plugin is ready before the command runs
  keys = {
    { "<leader>ac", ":CodeCompanionChat<CR>", desc = "AI Chat", mode = "n" },
    { "<leader>aa", ":CodeCompanionChat<CR>", desc = "AI Chat", mode = "n" },
    { "<leader>ae", ":CodeCompanionActions<CR>", desc = "AI Actions", mode = "v" },
  },
  config = function()
    require("codecompanion").setup({
      display = {
        chat = {
          output = {
            filetype = "markdown",
          },
          window = {
            layout = "vertical",
            position = "right",
            width = 0.35,
            height = 0.5,
          },
        },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = os.getenv("DEEPSEEK_API_KEY"),
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
      interactions = {
        chat = {
          tools = {
            ["create_file"] = {
              opts = {
                require_approval_before = false,
              },
            },
            ["insert_edit_into_file"] = {
              opts = {
                require_approval_before = { buffer = false, file = false },
                require_confirmation_after = false,
              },
            },
            ["run_command"] = {
              opts = {
                require_approval_before = false,
                require_cmd_approval = false,
              },
            },
            ["read_file"] = {
              opts = {
                require_approval_before = false,
              },
            },
            ["delete_file"] = {
              opts = {
                require_approval_before = false,
              },
            },
          },
        },
      },
    })
  end,
}

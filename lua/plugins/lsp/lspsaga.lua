return {
  "glepnir/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      code_action_icon = "",
      code_action_prompt = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
      finder = {
        keys = {
          vsplit = { "s", "v", "<c-v>" },
        },
      },
      rename = {
        quit = "<esc>",
      },
      callhierarchy = {
        keys = {
          quit = "<esc>",
          vsplit = "v",
          split = "s",
          jump = "e",
          edit = "<cr>",
          expand_collapse = "o",
        },
      },
      outline = {
        keys = {
          jump = "<cr>",
          quit = "q",
          expand_collapse = "o",
        },
      },
    })
    vim.o.winbar = require("lspsaga.symbolwinbar"):get_winbar()
  end,
  event = "VeryLazy",
}

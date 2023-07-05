return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      eslint = {
        settings = {
          workingDirectory = { mode = "auto" },
        },
      },
    },
    setup = {
      eslint = function()
        require("lspconfig").eslint.setup({
          on_attach = function(_, buffer)
            vim.cmd([[au BufWritePre <buffer> silent! EslintFixAll]])
            require("which-key").register({
              ["<leader>ge"] = { "<cmd>EslintFixAll<cr>", "Eslint Fix All" },
            }, { buffer = buffer })
          end,
        })
      end,
    },
  },
}

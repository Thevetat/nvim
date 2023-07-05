return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-go",
  },
  opts = {
    adapters = {
      ["neotest-jest"] = {
        jestCommand = "npx jest --watch",
        jestConfigFile = "custom.jest.config.ts",
        env = { CI = true },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      },
      ["neotest-rust"] = {},
      ["neotest-vitest"] = {},
      ["neotest-go"] = {
        args = { "-count=1", "-timeout=60s", "-race", "-cover" },
      },
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if require("lazyvim.util").has("trouble.nvim") then
          vim.cmd("Trouble quickfix")
        else
          vim.cmd("copen")
        end
      end,
    },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == "number" then
          if type(config) == "string" then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == "table" and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif meta and meta.__call then
              adapter(config)
            else
              error("Adapter " .. name .. " does not support setup")
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

    require("neotest").setup(opts)
  end,
  -- stylua: ignore
  keys = {
    { "<leader>ltt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>ltT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>ltr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>lts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>lto", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>ltO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>ltS", function() require("neotest").run.stop() end, desc = "Stop" },
  },
}

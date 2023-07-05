return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.fg = "#4AB5B3"
      end,

      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights["@variable"] = {
          fg = "#c678dd",
        }
      end,
    },
  },
}

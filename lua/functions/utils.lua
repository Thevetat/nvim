local function press_enter()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", false, true, true), "n", false)
end

return {
  copy_file_to_clipboard = function()
    vim.api.nvim_feedkeys(":let @+=expand('%:p')", "n", false)
    press_enter()
    require("notify")("Copied filepath.", vim.log.levels.INFO)
  end,
  copy_dir_to_clipboard = function()
    vim.api.nvim_feedkeys(":let @+=expand('%:h')", "n", false)
    press_enter()
    require("notify")("Copied directory path.", vim.log.levels.INFO)
  end,
}

-- Yazi.nvim keybind
vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi()
end)

-- window switching keybing
vim.keymap.set("n", "<leader>w", "<C-w>")

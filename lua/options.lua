vim.g.loaded_netrw = 1
vim.g.mapleader = " "
vim.g.loaded_netrwPlugin = 1
vim.opt.signcolumn = "yes:2"
vim.opt.undofile = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "css",
        "scss",
        "sass",
        "less",
        "json",
        "jsonc",
        "yaml",
        "vue",
        "svelte",
        "graphql",
        "markdown",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})

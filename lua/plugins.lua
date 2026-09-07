-- adding all the packages
vim.pack.add ({
    { src = "https://github.com/neanias/everforest-nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim"},
    { src = "https://github.com/nvim-tree/nvim-web-devicons"},
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mikavilpas/yazi.nvim"},
    { src = "https://github.com/folke/which-key.nvim"},
    { src = "https://github.com/lewis6991/gitsigns.nvim"},
})

-- set up the theme lol
vim.cmd("colorscheme everforest")

-- treesitter set up

-- here's the supported languages
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
}

local languages = {
    'python',
    'javascript',
    'typescript',
    'cpp',
    'lua',
    'json',
    'bash',
    'html',
    'css',
    'markdown',
}
require('nvim-treesitter').install (languages)

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function()
        vim.treesitter.start()
    end,
})

-- telescope set up
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- LSP set up
require("mason").setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    float = {
        border = "rounded",
    },
})

local servers = {
    "basedpyright",
    "ts_ls",
    "clangd",
    "lua_ls",
    "jsonls",
    "bashls",
    "html",
    "cssls",
    "marksman",
}

for _, lang in ipairs(servers) do
    vim.lsp.enable(lang)
end

-- Oil.nvim set up
require("oil").setup()

-- Yazi.nvim set up
-- oops it's just a keymap :laugh

-- Which-key set up
require("which-key").setup({
    preset = "helix",
    win = {
        border = "rounded",
    },
})

-- Git set up
require('gitsigns').setup {}

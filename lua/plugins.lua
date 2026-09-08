-- adding all the packages
vim.pack.add ({
    { src = "https://github.com/neanias/everforest-nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim"},
    { src = "https://github.com/nvim-tree/nvim-web-devicons"},
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/mikavilpas/yazi.nvim"},
    { src = "https://github.com/folke/which-key.nvim"},
    { src = "https://github.com/lewis6991/gitsigns.nvim"},
    { src = "https://github.com/windwp/nvim-autopairs"},
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/saghen/blink.lib"}, 
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*")},
})

-- set up the theme
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
    'tsx',
    'jsx',
    'cpp',
    'lua',
    'json',
    'bash',
    'html',
    'css',
    'markdown',
}
require('nvim-treesitter').install (languages):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'python',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'cpp',
        'lua',
        'json',
        'bash',
        'html',
        'css',
        'markdown',
    },
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
    "tailwindcss",
    "marksman",
}

require("mason-lspconfig").setup {
    ensure_installed = servers
}
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config('*', {
    capabilities = capabilities,
})

for _, lang in ipairs(servers) do
    vim.lsp.enable(lang)
end

-- Yazi.nvim set up
require("yazi").setup({
  open_for_directories = true, -- this is the key option
})

-- Which-key set up
require("which-key").setup({
    preset = "helix",
    win = {
        border = "rounded",
    },
})

-- Git set up
require('gitsigns').setup {}

-- autopair set up

require('nvim-autopairs').setup {
    disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
    disable_in_macro = true, -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
    enable_bracket_in_quote = true, --
    enable_abbr = false, -- trigger abbreviation
    break_undo = true, -- switch for basic rule break undo sequence
    check_ts = false,
    map_cr = true,
    map_bs = true, -- map the <BS> key
    map_c_h = false, -- Map the <C-h> key to delete a pair
    map_c_w = false, -- map <c-w> to delete a pair if possible
}

-- auto tag set up

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  -- per_filetype = {
  --   ["html"] = {
  --     enable_close = false
  --   }
  -- }
})

-- set up blink.cmp
require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        documentation = { auto_show = true },
        menu = { border = "rounded" },
        ghost_text = { enabled = true }, -- shows preview of completion inline before accepting
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "lua",
    },
})

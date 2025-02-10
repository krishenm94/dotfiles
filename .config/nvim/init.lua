vim.cmd([[
set notimeout
set encoding=utf-8
set relativenumber nu
set clipboard+=unnamedplus
set tabstop=8 softtabstop=2 expandtab shiftwidth=2 smarttab
set expandtab
set history=1000
set incsearch
set errorbells
set noswapfile
set scrolloff=8
set colorcolumn=120
set signcolumn=yes
set colorcolumn=80
]])

vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Mappings
---- Close current buffer
vim.keymap.set('n', '<Leader>q', '<cmd>enew<bar>bd #<CR>')

---- Toggle diagnostic window
vim.keymap.set('n', '<Leader>i', function()
    -- If we find a floating window, close it.
    local found_float = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= '' then
            vim.api.nvim_win_close(win, true)
            found_float = true
        end
    end

    if found_float then
        return
    end

    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
end, { desc = 'Toggle Diagnostics' })


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Copy path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Example using a list of specs with the default options

-- List Plugins
require('lazy').setup({
    { 'morhetz/gruvbox' },
    { 'folke/tokyonight.nvim' },
    { 'folke/which-key.nvim' },
    { 'folke/neoconf.nvim',   cmd = 'Neoconf' },
    { 'folke/neodev.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' },   -- Required
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    'saadparwaiz1/cmp_luasnip',
                    "rafamadriz/friendly-snippets"
                },
            }, -- Required
        }
    },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround' },
    { 'ThePrimeagen/harpoon' },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup({})
        end,
    },
    { 'hrsh7th/nvim-cmp' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'norcalli/nvim-colorizer.lua' },
    {
        'echasnovski/mini.nvim',
        version = '*',
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        }
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },
})

-- Setup Plugins

---- Color Scheme
vim.opt.termguicolors = true
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd("colorscheme gruvbox")

require('neoconf').setup({
    -- override any of the default settings here
})
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require('neodev').setup({
    -- add any options here, or leave empty to use the default settings
})

require 'colorizer'.setup()
require('mini.statusline').setup()

local harpoon = require('harpoon')
harpoon.setup()
vim.keymap.set("n", "<leader>ha", function() require('harpoon.mark').add_file() end)
vim.keymap.set("n", "<leader>hm", function() require('harpoon.ui').toggle_quick_menu() end)
vim.keymap.set("n", "<leader>hh", function() require('harpoon.ui').nav_file(1) end)
vim.keymap.set("n", "<leader>hj", function() require('harpoon.ui').nav_file(2) end)
vim.keymap.set("n", "<leader>hk", function() require('harpoon.ui').nav_file(3) end)
vim.keymap.set("n", "<leader>hl", function() require('harpoon.ui').nav_file(4) end)
require("telescope").load_extension('harpoon')

local telescope = require('telescope')
telescope.setup {
    defaults = {
        layout_strategy = "vertical"
    },
}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

require('nvimcmp')
require('treesitter')
require('lspzero')

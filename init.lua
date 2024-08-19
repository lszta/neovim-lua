-- vim: foldmethod=marker
--
-- configure globals {{{
vim.cmd [[
        set nocompatible
        filetype plugin on
        filetype plugin indent on
        set showmatch
        set ignorecase
        set hlsearch
        set number
        set smarttab
        set expandtab
        set encoding=UTF-8
        set wrap linebreak
        set list listchars=tab:>\ ,trail:◦,eol:$,nbsp:•
        set colorcolumn=80
        set signcolumn=yes
        set foldlevelstart=99
        set foldcolumn=1
        set diffopt+=vertical
        set exrc
        set secure
        set cursorline
]]

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local node_bin = "~/.nvm/versions/node/v20.10.0/bin"

vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")


vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"
vim.g.python2_host_prog = "~/.pyenv/versions/neovim2/bin/python"

-- }}}

-- install packages {{{
local Plug = require 'config.plug'
Plug.begin('~/.nvim/nvim/plugged')
-- UI {{{

	-- themes {{
Plug('morhetz/gruvbox')
Plug('rktjmp/lush.nvim')
Plug('ntk148v/habamax.nvim')
 -- }}}


Plug('vim-airline/vim-airline')
Plug('ryanoasis/vim-devicons')

Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')

-- LSP {{{
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('creativenull/efmls-configs-nvim')
-- }}}

-- Navigation & flow {{{
Plug('editorconfig/editorconfig-vim')
Plug('ibhagwan/fzf-lua', { branch = 'main' })

-- Snippets {{{
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
-- }}}

Plug('mfussenegger/nvim-dap')
Plug('mfussenegger/nvim-lint')
Plug('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
})
Plug('ThePrimeagen/refactoring.nvim')
-- }}}
--
-- Misc things {{{
Plug('mhinz/vim-startify')
Plug('majutsushi/tagbar')
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')
Plug('f-person/git-blame.nvim')
Plug('tpope/vim-commentary')
Plug('christoomey/vim-tmux-navigator')
Plug('nvim-lua/plenary.nvim')
-- }}}
--
-- Own things {{{
Plug('folke/neodev.nvim')

Plug('/projects/lszta/rg.nvim')

-- }}}
Plug.ends()
-- }}}

vim.cmd([[ 
        colorscheme habamax.nvim
]])

-- Airline {{{
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.airline_theme = 'gruvbox'
-- }}}

-- packages config {{{
require 'config.nvim_tree'
require 'config.keybinds'
require 'config.treesitter'
require 'config.fzf'
require 'config.lsp'
require 'config.efm'
-- }}}
--
require 'rg'.setup({})

-- disable deprecations
vim.deprecate = function () end


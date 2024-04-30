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
]]

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local node_bin = "/Users/ltorba/.nvm/versions/node/v20.10.0/bin"
-- vim.g.node_host_prog = node_bin .. "/node"

vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")


vim.g.python3_host_prog = "/Users/ltorba/.pyenv/versions/neovim2/bin/python"
vim.g.python3_host_prog = "/Users/ltorba/.pyenv/versions/neovim3/bin/python"

-- }}}

-- install packages {{{
local Plug = require 'config.plug'
Plug.begin('~/.nvim/nvim/plugged')
-- UI {{{
Plug('morhetz/gruvbox')
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
--
-- Navigation & flow {{{
Plug('editorconfig/editorconfig-vim')
Plug('junegunn/fzf', { run = '-> fzf#install()' })
Plug('ibhagwan/fzf-lua', { branch = 'main' })
-- Plug('junegunn/fzf.vim')
Plug('sirver/ultisnips')
Plug('honza/vim-snippets')
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

Plug('vim-scripts/ShowMarks');
-- }}}
Plug.ends()
-- }}}

vim.cmd([[ 
        colorscheme gruvbox
]])

vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.airline_theme = 'gruvbox'
vim.g.UltiSnipsExpandTrigger = "tab"
vim.g.UltiSnipsJumpForwardTrigger = "<c-n>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-b>"
vim.g.UltiSnipsEditSplit = "vertical"


-- packages config {{{
require 'config.nvim_tree'
require 'config.keybinds'
require 'config.treesitter'
require 'config.fzf'
require 'config.airline'
require 'config.lsp'
require 'config.efm'
-- require 'config.autoconf'
-- }}}



local U = require 'utils.keybind'

U.noremap ('<leader>S',  ':set invspell<CR>')
U.noremap ('<leader>h',  ':set hlsearch!<CR>')
U.noremap ('<leader>nf', ':NvimTreeFindFile<CR>')

-- drop?
U.noremap ('<C-space>',  ':lua vim.lsp.buf.hover()<CR>')


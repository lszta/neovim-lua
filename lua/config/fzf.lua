local U = require 'utils.keybind'

vim.g.fzf_action = {}
vim.g.fzf_action["ctrl-s"] = 'split'
vim.g.fzf_action["ctrl-v"] = 'vsplit'

U.noremap ('<C-p>b',     ':FzfLua buffers<CR>')
U.noremap ('<C-p>',      ':FzfLua files<CR>')
U.noremap ('<C-p>g',     ':FzfLua git_files<CR>')

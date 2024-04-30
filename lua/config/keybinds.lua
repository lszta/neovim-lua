local noremap = function (lhs, rhs)
  --vim.keymap.set
  vim.api.nvim_set_keymap('n', lhs, rhs, {
      noremap = true,
      silent = true,
      nowait = true
    })
end

noremap ('<leader>S',  ':set invspell<CR>')
noremap ('<leader>h',  ':set hlsearch!<CR>')
noremap ('<leader>nf', ':NvimTreeFindFile<CR>')
noremap ('<C-p>b', ':FzfLua buffers<CR>')
noremap ('<C-p>', ':FzfLua files<CR>')
noremap ('<C-p>g', ':FzfLua git_files<CR>')
-- noremap ('<C-p>h', ':History<CR>')
-- noremap ('<C-p>f', ':Rg<CR>')
noremap ('<C-space>', ':lua vim.lsp.buf.hover()<CR>')


local api = require "nvim-tree.api"

local function opts(desc)
  return {
    desc = "nvim-tree:" .. desc,
    noremap = true,
    silent = true,
    nowait = true
  }
end

local function on_tree_attach(bufno)
  
  api.config.mappings.default_on_attach(bufno)

  local opts2 = function (desc)
          return {
            desc = "nvim-tree:" .. desc,
            noremap = true,
            silent = true,
            nowait = true,
            buffer = bufno,
          }
  end

  vim.keymap.set('n', '<S-r>',  api.tree.reload,                opts2('reload'))
  vim.keymap.set('n', 'h',      api.node.open.horizontal,       opts2('open-horizontal'))
  vim.keymap.set('n', 's',      api.node.open.vertical,         opts2('open-horizontal'))
end

require("nvim-tree").setup {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 35,
  },
  filters = {
    dotfiles = false,
  },
  on_attach = on_tree_attach,
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  }
}


vim.keymap.set('n', '<leader>f', api.tree.find_file, opts('find_file'))
vim.keymap.set('n', '<leader>n', api.tree.toggle, opts('toggle'))


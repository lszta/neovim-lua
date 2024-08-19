local A = require 'nvim-tree.api'
local U = require 'utils.keybind'

local opts = function (desc)
  return {
    desc = 'nvim-tree:' .. desc,
    noremap = true,
    silent = true,
    nowait = true
  }
end

local opts_buff = function(buffer)
  return function (desc)
    local options = vim.tbl_extend('force', opts(desc), {
      buffer = buffer
    })
    return options
  end
end

local function on_tree_attach(bufno)
  local options = opts_buff(bufno)

  A.config.mappings.default_on_attach(bufno)

  U.noremap('<S-r>',  A.tree.reload,                options('reload'))
  U.noremap('h',      A.node.open.horizontal,       options('open-horizontal'))
  U.noremap('s',      A.node.open.vertical,         options('open-horizontal'))
end

require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
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

U.noremap('<leader>f', A.tree.find_file, opts('find_file'))
U.noremap('<leader>n', A.tree.toggle, opts('toggle'))


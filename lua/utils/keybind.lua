local M = {}

--- Bind key in noremap mode
---
--- @param lhs  string
--- @param rhs  string|function
--- @param opts? vim.api.keyset.keymap
M.noremap = function(lhs, rhs, opts)
  local _opts = vim.tbl_extend('force', opts or {}, {
    noremap = true,
    silent = true,
    nowait = true
  })
  vim.keymap.set('n', lhs, rhs, _opts)
end

return M

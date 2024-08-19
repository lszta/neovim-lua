local M = {}
--- Expands home directory to full path
--- @param filepath string
--- @return string
M.expand = function(filepath)
  local resolved = vim.fn.resolve(filepath)
  if string.sub(resolved, 0, 1) == "~" then
    return os.getenv("HOME") .. string.sub(resolved, 2)
  end
  return resolved
end

--- @param filepath string
--- @param sep? string Path separators
M.dirname = function(filepath, sep)
  local separator = sep or "/"
  local slug_list = vim.fn.split(filepath, separator)

  table.remove(slug_list, #slug_list)

  return vim.fn.join(
  slug_list,
  separator
  )
end

return M

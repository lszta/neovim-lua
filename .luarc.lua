--- @param ... string
local path_join = function(...)
  return vim.fn.join({ ... }, "/")
end

---
--- prepare list of workspace libraries, refer to existing neovim plugins
--- when plugin contains `lua` directory
--- @param existing_workspace string[]
--- @return string[]
local load_plugins_workspace = function(existing_workspace)
  local path = path_join(vim.env.HOME, ".nvim/nvim/plugged")
  local workspace_libs = vim.tbl_extend("force", existing_workspace, {})

  -- local plugins_list = vim.split(vim.fn.glob(), "\n", { trimempty = true })
  local handle = vim.loop.fs_opendir(path, nil, 256)
  if handle == nil then
    return existing_workspace
  end

  local close_handle_and_return = function()
    vim.loop.fs_closedir(handle)
    return workspace_libs
  end

  local entries = vim.loop.fs_readdir(handle)
  if entries == nil then
    error(
      string.format(
        "Unable to read directory '%s', some vim plugins typehint may not be available.",
        path
      ),
      vim.log.levels.WARN
    )

    return close_handle_and_return()
  end

  for _, entry in ipairs(entries) do
    if entry["type"] == "directory" then
      local lua_lib = path_join(path, entry["name"], "lua")
      if vim.loop.fs_stat(entry["name"] .. "/lua") then
        table.insert(workspace_libs, entry["name"] .. "/lua")
      end
    end
  end

  return close_handle_and_return()
end

return function(client)
  return {
    diagnostics = {
      enable = true,
      globals = { "vim" },
      neededFileStatus = {
        ["codestyle-check"] = "Any",
      },
    },
    workspace = {
      library = load_plugins_workspace({ "lua", vim.env.VIMRUNTIME }),
      checkThirdParty = false,
      maxPreload = 2000,
      preloadFileSize = 1000,
      ignoreDir = { "tests/" },
    },
    type = {
      weakNilCheck = true,
      weakUnionCheck = true,
      castNumberToInteger = true,
    },
    hint = {
      enable = true,
      setType = true,
    },
  }
end

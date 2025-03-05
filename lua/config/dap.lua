local U = require('utils.keybind')
local dap = require('dap')

dap.set_log_level('TRACE')

local np = function(func)
  return function ()
    func()
  end
end

-- Keybinds  {{{
U.noremap_many({
  { '<F2>',  np(dap.toggle_breakpoint) },
  { '<F9>',  np(dap.continue) },
  { '<F11>', np(dap.step_into) },
  { '<F10>', np(dap.step_over) },
  { '<F12>', np(dap.step_out) },
})

-- }}}

-- force to use json5 as parser
require("dap.ext.vscode").json_decode = require("json5").parse

-- Adapters configuration {{{

-- node {{{
dap.adapters['pwa-node'] = {
  type = "server",
  host = "::1",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.expand("$HOME/.local/etc/js-debug/src/dapDebugServer.js"),
      "${port}"
    }
  }
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    name = "attach",
    request = "attach",
    cwd = "${workspaceFolder}",
    address = "localhost",
    port = 9229,
    restart = true
  }
}
-- }}}

-- golang {{{
require('dap-go').setup {
  dap_configurations = {
    {
      type = "go",
      name = "GO: Attach remote",
      mode = "remote",
      request = "attach",
    },
    {
      type = "go",
      name = "GO: Debug (Build Flags & Arguments)",
      request = "launch",
      program = "${file}",
      args = require("dap-go").get_arguments,
      buildFlags = require("dap-go").get_build_flags,
    },
  },
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = 38697,
    build_flags = {},
    detached = vim.fn.has("win32") == 0,
    cwd = nil,
  },
  tests = {
    verbose = false,
  },
}
-- }}}


-- }}}



local dapui = require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
--

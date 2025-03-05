local U = require("utils.keybind")
local P = require("utils.path")
local lspconfig = require("lspconfig")

-- vim bindings
require("neodev").setup({})
-- Refactoring utils
require("refactoring").setup()

-- Autocompletion
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
    },
    {
      name = "vsnip",
    },
  }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local enable_inlay_hints = function(_, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

local servers = {
  "tsserver",
  "gopls",
  "bashls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
  })
end

lspconfig.yamlls.setup({
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yaml",
      },
    },
  },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  --- @param client vim.lsp.Client
  on_init = function(client)
    -- check if configuration file exists
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") then
      return
    end

    if vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end

    local default_lua_config = {
      runtime = {
        version = "LuaJIT",
      },
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
    }

    if vim.loop.fs_stat(path .. "/.luarc.lua") then
      local config_factory = loadfile(path .. "/.luarc.lua")()

      assert(
        type(config_factory) == "function",
        string.format("Value returned from '.luarc.lua' in '%s' is not a function", path)
      )

      default_lua_config = vim.tbl_deep_extend("force", default_lua_config, config_factory(client))
    end

    client.config.settings.Lua =
      vim.tbl_deep_extend("force", client.config.settings.Lua, default_lua_config)
  end,
  settings = {
    Lua = {},
  },
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = enable_inlay_hints,
  cmd = {
    P.expand(P.dirname(vim.g.python3_host_prog) .. "/pyright-langserver"),
    "--stdio",
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  cmd = {
    P.expand(vim.g.node_bin_dir) .. "/typescript-language-server",
    "--stdio",
  },
  cmd_env = {
    PATH = P.expand(vim.g.node_bin_dir) .. ":" .. os.getenv("PATH"),
  },
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = enable_inlay_hints,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

U.noremap("<space>e", vim.diagnostic.open_float)
U.noremap("[d", vim.diagnostic.goto_prev)
U.noremap("]d", vim.diagnostic.goto_next)
U.noremap("<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})

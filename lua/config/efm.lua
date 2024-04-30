local eslint = require('efmls-configs.linters.eslint')
local prettier = require('efmls-configs.formatters.prettier')
local eslintf = require('efmls-configs.formatters.prettier')

local languages = {
        typescript = { eslint, eslintf, prettier },
}

local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
                rootMarkers = { '.git/' },
                languages = languages,
        },
        init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
        },
}

require('lspconfig').efm.setup(efmls_config)

-- Lint on save
local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = lsp_fmt_group,
  callback = function(ev)
    local efm = vim.lsp.get_active_clients({ name = 'efm', bufnr = ev.buf })

    if vim.tbl_isempty(efm) then
      return
    end

    vim.lsp.buf.format({ name = 'efm' })
  end,
})

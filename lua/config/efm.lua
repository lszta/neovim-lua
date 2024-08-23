local languages = {
	typescript = {
		require("efmls-configs.linters.eslint"),
		require("efmls-configs.formatters.prettier"),
	},
	lua = {
		require("efmls-configs.formatters.stylua"),
	},
	go = {
		require("efmls-configs.formatters.gofmt"),
	},
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

require("lspconfig").efm.setup(efmls_config)

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("LspFormattingGroup", {}),
	callback = function(ev)
		local efm = vim.lsp.get_active_clients({ name = "efm", bufnr = ev.buf })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm" })
	end,
})

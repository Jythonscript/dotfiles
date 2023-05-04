local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>sf', vim.diagnostic.open_float)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false,
		signs = false
	}
)

local servers = { "clangd", "pyright" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup { on_attach = on_attach }
end

require("lspconfig").lua_ls.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "Lua 5.3",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {"vim"},
			},
			workspace = {
				checkThirdParty = false,
				library = vim.list_extend(
					{
						"/usr/share/lua/5.3",
						"/usr/share/awesome/lib",
						vim.fn.expand("~/.config/awesome/lame/?.lua"),
					},
					vim.api.nvim_get_runtime_file("", true)
					),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}


local servers = {
	"clangd",
	"pyright",
	"nixd",
	"gopls",
	"lua_ls",
	"rust_analyzer",
}

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	signs = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<leader>sf', vim.diagnostic.open_float)
	end
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.3",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = vim.list_extend(
					{
						"/usr/share/lua/5.3",
						"/usr/share/awesome/lib",
						vim.fn.expand("~/.config/awesome/lame/?.lua"),
					},
					vim.api.nvim_get_runtime_file("", true) -- include nvim libraries
				)
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

for _, lsp in ipairs(servers) do
	vim.lsp.enable(lsp)
end


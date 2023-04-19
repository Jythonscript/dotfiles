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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
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

lspconfig.sumneko_lua.setup {
	cmd = { "lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.3",
				path = {
					"./?.lua",
					"./?/init.lua",
					"/usr/share/lua/5.3/?.lua",
					"/usr/share/lua/5.3/?/init.lua",
					"/usr/lib/lua/5.3/?.lua",
					"/usr/lib/lua/5.3/?/init.lua",
					"/usr/share/awesome/lib/?.lua",
					"/usr/share/awesome/lib/?/init.lua"
				}
			},
			diagnostics = {
				disable = {
					"lowercase-global"
				},
				globals = {
					"client",
					"awesome",
					"screen",
					"root",
					"mousegrabber"
				}
			},
			workspace = {
				library = {
					["/usr/share/lua/5.4"] = true,
					["/usr/share/awesome/lib"] = true
				}
			}
		}
	},
	on_attach = on_attach
}

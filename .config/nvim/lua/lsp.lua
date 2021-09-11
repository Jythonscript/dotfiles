local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false,
		signs = false
	}
)

--local servers = { "ccls", "pyls" }
local servers = {}
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

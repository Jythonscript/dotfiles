local cmp = require("cmp")

cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		--{ name = 'ultisnips' },
	}, {
		{ name = 'buffer' },
	})
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require("lspconfig").clangd.setup {
	capabilities = capabilities,
}

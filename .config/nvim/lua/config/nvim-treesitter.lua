configs = require('nvim-treesitter.configs')

configs.setup {
	ensure_installed = {
		"c",
		"lua",
		"cpp",
		"python",
		"lua",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}

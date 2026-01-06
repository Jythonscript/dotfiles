local configs = require('nvim-treesitter.configs')

configs.setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"go",
		"gomod",
		"gosum",
		"lua",
		"markdown",
		"markdown_inline",
		"nix",
		"python",
		"query",
		"terraform",
		"vim",
		"vimdoc"
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}

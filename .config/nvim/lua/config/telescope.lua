local actions = require 'telescope.actions'
local tb = require 'telescope.builtin'

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
}

require('telescope').load_extension('fzf')

local map = function (lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true })
end

map('<leader>t', ':Telescope<CR>')
map('<leader>tr', ':Telescope live_grep prompt_prefix=<CR>')
map('<leader>tf', ':Telescope find_files prompt_prefix=<CR>')
map('<leader>tb', ':Telescope buffers prompt_prefix=<CR>')
map('<leader>tz', ':Telescope current_buffer_fuzzy_find prompt_prefix=<CR>')
map('<leader>ts', ':Telescope treesitter prompt_prefix=<CR>')
map('<leader>th', ':Telescope help_tags prompt_prefix=<CR>')

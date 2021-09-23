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
	}
}

local map = function (lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true })
end

map('<leader>tr', ':lua require"telescope.builtin".live_grep()<CR>')
map('<leader>tf', ':lua require"telescope.builtin".find_files()<CR>')
map('<leader>tb', ':lua require"telescope.builtin".buffers()<CR>')

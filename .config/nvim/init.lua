require('plugins')

vim.cmd('runtime nvimrc.vim')
vim.cmd('runtime vimrc.vim')

local toggle_clipboard = function()
	local status = vim.api.nvim_get_option("clipboard")
	if status == "unnamedplus" then
		vim.api.nvim_set_option("clipboard", "")
		print("Clipboard disabled")
	else
		vim.api.nvim_set_option("clipboard", "unnamedplus")
		print("Clipboard enabled")
	end
end

vim.keymap.set('n', '<leader>c', toggle_clipboard, {expr = true, noremap = true})

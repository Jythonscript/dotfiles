-- load vimscript configs
vim.cmd('runtime nvimrc.vim')
vim.cmd('runtime vimrc.vim')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

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

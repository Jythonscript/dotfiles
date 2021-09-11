--vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	-- Cosmetics
	use 'Nequo/vim-allomancer'
	use 'arzg/seoul8'
	use 'fcpg/vim-orbital'
	use {'dracula/vim', as = 'dracula'}
	use 'junegunn/goyo.vim'
	use 'junegunn/limelight.vim'
	use 'chrisduerr/vim-undead'

	-- Programming
	use 'junegunn/fzf.vim'
	use 'dense-analysis/ale'
	use 'SirVer/ultisnips'
	use 'lervag/vimtex'
	use 'vimwiki/vimwiki'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'Konfekt/FastFold'
	use 'neovim/nvim-lspconfig'
end)

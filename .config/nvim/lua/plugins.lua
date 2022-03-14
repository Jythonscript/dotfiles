vim.cmd('packadd packer.nvim')
local use = require('packer').use

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerSync]])
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
	use 'SirVer/ultisnips'
	use 'lervag/vimtex'
	use 'vimwiki/vimwiki'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'Konfekt/FastFold'
	use {
		'neovim/nvim-lspconfig',
		config = function ()
			require 'config.lsp'
		end,
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} },
		config = function ()
			require 'config.telescope'
		end,
	}
	use 'jbyuki/instant.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make'
	}
	use 'junegunn/fzf.vim'
	use {
		'hrsh7th/nvim-cmp',
		config = function ()
			require 'config.nvim-cmp'
		end,
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
end)

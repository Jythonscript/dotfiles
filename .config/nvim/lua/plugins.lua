return {
	-- Cosmetics
	'arzg/seoul8',
	'junegunn/goyo.vim',
	'junegunn/limelight.vim',

	-- Programming
	'SirVer/ultisnips',
	'lervag/vimtex',
	'vimwiki/vimwiki',
	'tpope/vim-surround',
	'tpope/vim-repeat',
	'Konfekt/FastFold',
	 {
		'neovim/nvim-lspconfig',
		config = function ()
			require 'config.lsp'
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function ()
			require 'config.telescope'
		end,
	},
	'jbyuki/instant.nvim',
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- config = function ()
		-- 	require 'config.nvim-treesitter'
		-- end,
		config = function ()
			local configs = require('nvim-treesitter.configs')

			configs.setup {
				ensure_installed = {
					"c",
					"lua",
					"cpp",
					"python",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				sync_install = false,
			}
		end,
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
	},
	'junegunn/fzf',
	'junegunn/fzf.vim',
	{
		'hrsh7th/nvim-cmp',
		config = function ()
			require 'config.nvim-cmp'
		end,
	},
	'hrsh7th/cmp-nvim-lsp',
	'quangnguyen30192/cmp-nvim-ultisnips',
	'tpope/vim-fugitive',
	{
		'kyazdani42/nvim-tree.lua',
		dependencies =  { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require 'config.nvim-tree'
		end,
	},
}

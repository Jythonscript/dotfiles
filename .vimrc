"Plugins list

"	(.vim) 		Index Search:		https://www.vim.org/scripts/script.php?script_id=1682 
"	(vim-plug) 	Multiple Cursors: 	https://github.com/terryma/vim-multiple-cursors	

call plug#begin()

Plug 'terryma/vim-multiple-cursors'
Plug 'https://github.com/lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'arzg/seoul8'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Plugin bindings

"	multiple cursors select all
map n <A-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   My bindings

"	set colorscheme to delek
colorscheme delek
"   Control+] makes matching brackets
noremap <C-]> <Esc>A<Space>{<Esc>o}<Esc>O
filetype indent on
syntax enable
set shiftwidth=4
set tabstop=4
"	7 line lookahead when scrolling
set so=7
"	enables scroll support
set mouse=a
noremap <A-/> <ESC>mzI//<ESC>`z
noremap <A-?> <ESC>mz^xx<ESC>`z
"	toggle folding
noremap <space> za
"	toggle relative number
noremap + :set relativenumber!<Enter>:set number!<Enter>
"	number sidebars
set relativenumber
set number
"	enable search highlighting by default
set hlsearch
"	toggle highlightsearch
noremap - :set hlsearch! hlsearch?<CR>
"	natural backspace behavior
set backspace=indent,eol,start
"	remember folding
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
"	go to next grouping character: ()[]{}"'
"	syntax highlighting disabled for visibility
noremap <C-l> <Esc>:set nohlsearch<CR>/[()[\]"'{}]\v<CR>
"	inverse of previous
noremap <C-h> <Esc>:set nohlsearch<CR>?[()[\]"'{}]\v<CR>
"	if search parameter is lowercase, use case insensitive search, otherwise use case sensitive
set ignorecase
set smartcase
"	highlight matches while searching
set incsearch
"	search for currently selected text in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
"	:W is the same as :w (i do this on accident all the time)
command W :w
"	:Q is the same as :q (i do this on accident all the time)
command Q :q
"	reduce timeout to not be bothersome but still use arrow keys in insert mode
set timeoutlen=200

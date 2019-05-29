"	Plugins list

"	(.vim) 		Index Search:		https://www.vim.org/scripts/script.php?script_id=1682 

call plug#begin()

"	Colorschemes
Plug 'Nequo/vim-allomancer'
Plug 'arzg/seoul8'

"	Programming
"	Plug 'terryma/vim-multiple-cursors'
Plug 'https://github.com/lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'https://github.com/vimwiki/vimwiki'
Plug 'https://github.com/SirVer/ultisnips'
"	Plug 'honza/vim-snippets'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/fcpg/vim-orbital'
Plug 'https://github.com/Heorhiy/VisualStudioDark.vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Plugin bindings

"	multiple cursors select all
map n <A-n>
"	vimwiki
filetype plugin on
let g:vimwiki_list = [{'path':'~/.vimwiki/wiki/', 'path_html':'~/.vimwiki/html'}]
let g:vimwiki_folding="custom"
"	ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
"	Commentary
autocmd FileType c setlocal commentstring="// %s"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   My bindings
"	custom leader
let mapleader = ","
noremap <leader>, ,
"	make netrw file browser better
let g:netrw_banner=0 " disable banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
"	set colorscheme to delek
colorscheme delek
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
noremap + :set relativenumber! <bar> set number!<Enter>
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
"	folding appearance settings
hi Folded ctermbg=None
hi Folded ctermfg=Yellow
"	make splits work like my awesomewm setup
set splitright
set splitbelow
"	command for easier vertical terminals
command Vterm :vert term
"	save and open shell shortcut
noremap <C-s> <Esc>:w<bar>sh<Enter>
"	wrapped lines keep the same indent
set breakindent
"	character to display for long lines that wrap across the terminal
set showbreak=↪
"	easier clipboard access
noremap <C-y> "+y
"	show all options in footer
set wildmenu
"	recursive searching
set path+=**
"	toggle number and relativenumber command
command Num set number!|set relativenumber!

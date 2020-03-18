set nocompatible

"	Plugins list

"	(.vim) 		Index Search:		https://www.vim.org/scripts/script.php?script_id=1682 

call plug#begin()

"	Cosmetics
Plug 'Nequo/vim-allomancer'
Plug 'arzg/seoul8'
Plug 'https://github.com/fcpg/vim-orbital'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'https://github.com/Heorhiy/VisualStudioDark.vim'

"	Programming
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/lervag/vimtex'
Plug 'https://github.com/vimwiki/vimwiki'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
"Plug 'terryma/vim-multiple-cursors'
"Plug 'honza/vim-snippets'

call plug#end()

"	custom leader
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Plugin bindings

"	FZF
noremap <leader>r :Rg<CR>
noremap <leader>f :Files<CR>
noremap <leader>b :Buffers<CR>
"	ALE
noremap <leader>a :ALELint<CR>
noremap <leader>A :ALEDisable<CR>
noremap <leader>aa :ALEEnable<CR>
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_save = 1
let g:ale_enabled=1
"	vimtex
noremap <leader>v :VimtexCompile<CR>
let g:vimtex_view_general_viewer = 'zathura'
let g:tex_flavor='latex'
let g:vimtex_quickfix_enabled = 0
let g:vimtex_mappings_enabled = 0
"	vimwiki
filetype plugin on
let g:vimwiki_list = [{'path':'~/.vimwiki/wiki/', 'path_html':'~/.vimwiki/html'}]
let g:vimwiki_folding="custom"
"	ultisnips
noremap <leader>se :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
"	Commentary
autocmd FileType c setlocal commentstring="// %s"
"	Netrw
"	disable banner
let g:netrw_banner=0
"	open in prior window
"let g:netrw_browse_split=4
"	open splits to the right
let g:netrw_altv=1
"	tree view
let g:netrw_liststyle=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Custom bindings
"	save file
noremap <leader>w :w<CR>
"	quit without saving
noremap <leader>q :q<CR>
"	quit with saving
noremap <leader>z ZZ
"	easier clipboard access
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
"	reload current file
noremap <leader>e :e<CR>
"	spell toggling
noremap <leader>s :setlocal spell!<CR>
noremap <leader>ss :setlocal spell<CR>
noremap <leader>S :setlocal spell<bar>setlocal spell!<CR>
"	toggle hybrid numbers
noremap <leader>n :set relativenumber! <bar> set number!<Enter>
"	single fold toggling
noremap <leader>z za
"	foldmethod changing
noremap <leader>fi :set foldmethod=indent<CR>
noremap <leader>fm :set foldmethod=manual<CR>
noremap <leader>fs :set foldmethod=syntax<CR>
noremap <leader>fw :set foldmethod<CR>
"	writing mode toggling
noremap <leader>wr :call Write()<CR>
noremap <leader>wn :call NoWrite()<CR>
"	session creating and loading
nnoremap <leader>sn :exec "mks!" . "~/.vim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR>
nnoremap <leader>sl :exec "source" . "~/.vim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR> | colo mydelek
"	arrow keys for easier navigation of long lines
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
"	delete previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
"	toggle folding
noremap <space> zA
"	toggle relative number
noremap + :set relativenumber! <bar> set number!<Enter>
"	toggle highlightsearch
noremap - :set hlsearch! hlsearch?<CR>
"	save and open shell shortcut
noremap <C-s> <Esc>:w<bar>sh<Enter>
"	spell fix shortcut
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"	search for currently selected text in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
"	easier split shortcut access in terminals
noremap <Esc>a <C-w>
tnoremap <Esc>a <C-w>
"	disable middle-click paste
map  <MiddleMouse>   <Nop>
imap <MiddleMouse>   <Nop>
map  <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map  <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map  <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Settings
filetype indent on
"	automatically save and load views
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
set shiftwidth=4
set tabstop=4
"	7 line lookahead when scrolling
set so=7
"	enables scroll support
set mouse=a
"	number sidebars
set relativenumber
set number
"	enable search highlighting by default
set hlsearch
"	natural backspace behavior
set backspace=indent,eol,start
"	if search parameter is lowercase, use case insensitive search,
"	otherwise use case sensitive
set ignorecase
set smartcase
"	highlight matches while searching
set incsearch
"	reduce timeout to not be bothersome but still use arrow keys in insert mode
set timeoutlen=200
"	always show changes, regardless of the number of lines affected
set report=0
"	make splits work like my awesomewm setup
set splitright
set splitbelow
"	wrap lines instead of going off-screen
set wrap
"	wrapped lines keep the same indent
set breakindent
"	character to display for long lines that wrap across the terminal
let &showbreak="> "
"	show all options in footer
set wildmenu
"	recursive searching
set path+=**
"	show full words on their own line
set linebreak
"	show inputs
set showcmd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Commands
"	toggle number and relativenumber command
command Num set number!|set relativenumber!
"	hide gray border
command Nogray set foldcolumn=0
"	undo readonly status command
command Noreadonly set noro
"	DOS editing mode
command DOS e ++ff=dos
"	UNIX editing mode
command UNIX e ++ff=unix
" open PDFs in zathura
command ZATHURA silent exe "!echo " . shellescape(expand("%")) . " | grep -oP '^[^\.]+' | xargs -I{} zathura '{}'.pdf &disown" | redraw!
"	open LaTeX default file
command LATEX execute '!cp ~/.vim/templates/notes.tex .' | e notes.tex
"	command for easier vertical terminals
command Vterm :vert term
"	:W is the same as :w (i do this on accident all the time)
command W :w
"	:Q is the same as :q (i do this on accident all the time)
command Q :q


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Color Options
syntax on
syntax enable
set background=dark
"	custom colorscheme
colorscheme mydelek

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Functions

"	enable writing mode-specific shortcuts
function! Write()
	Goyo
	colo seoul8
	let &showbreak=""
	nnoremap j gj
	nnoremap k gk
	nnoremap gj j
	nnoremap gk k

	nnoremap $ g$
	nnoremap ^ g^
	nnoremap g$ $
	nnoremap g^ ^
	set breakindent| set breakindent!
endfunction

"	disable writing mode-specific shortcuts
function! NoWrite()
	Goyo!
	colo mydelek
	let &showbreak="> "
	nnoremap j j
	nnoremap k k
	nnoremap gj gj
	nnoremap gk gk

	nnoremap $ $
	nnoremap ^ ^
	nnoremap g$ g$
	nnoremap g^ g^
	set breakindent
endfunction

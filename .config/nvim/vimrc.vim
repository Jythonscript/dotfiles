set nocompatible

"	custom leader
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Custom bindings
"	save file
noremap <leader>w :w<CR>
"	quit without saving
noremap <leader>q :q<CR>
"	quit with saving
noremap <leader>x ZZ
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
"	foldmethod changing
noremap <leader>fi :set foldmethod=indent<CR>
noremap <leader>fm :set foldmethod=manual<CR>
noremap <leader>fs :set foldmethod=syntax<CR>
noremap <leader>fw :set foldmethod<CR>
"	fold nest changing
noremap <leader>fn :call PromptNest()<CR>
"	writing mode toggling
noremap <leader>wr :call Write()<CR>
noremap <leader>wn :call NoWrite()<CR>
"	session creating and loading
nnoremap <leader>sn :exec "mks!" . "~/.vim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR>
nnoremap <leader>sl :exec "source" . "~/.vim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR> | colo mydelek
"	load view
nnoremap <leader>l :loadview<CR>
"	toggle line wrapping
noremap <leader>sr :set wrap<CR>
noremap <leader>srr :set wrap!<CR>
"	arrow keys for easier navigation of long lines
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
"	delete previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
"	toggle relative number
noremap + :set relativenumber! <bar> set number!<Enter>
"	toggle highlightsearch
noremap - :set hlsearch! hlsearch?<CR>
"	save and open shell shortcut
noremap <C-s> <Esc>:w<bar>sh<Enter>
"	spell fix shortcut
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"	Alt+w save in insert mode
inoremap <A-w> <C-o>:w<CR>
"	search for currently selected text in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
"	easier split shortcut access in terminals
noremap <Esc>a <C-w>
tnoremap <Esc>a <C-w>
noremap <Space> <C-w>
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
"	automatically save views when not in diff mode
if !&diff
	autocmd BufWinLeave *.* mkview
endif
"	language-specific foldnestmax
autocmd BufWinEnter,BufNewFile,BufRead *.java exec "set foldnestmax=2"
autocmd BufWinEnter,BufNewFile,BufRead *.c exec "set foldnestmax=1"
autocmd BufWinEnter,BufNewFile,BufRead *.cpp exec "set foldnestmax=1"
autocmd BufWinEnter,BufNewFile,BufRead *.h exec "set foldnestmax=1"
autocmd BufWinEnter,BufNewFile,BufRead *.hpp exec "set foldnestmax=1"
"	tab preferences
set shiftwidth=4
set tabstop=4
"	3 line lookahead when scrolling
set so=3
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
"	automatically indent new lines to same as current line
set autoindent
"	wrap lines instead of going off-screen
set wrap
"	wrapped lines keep the same indent as the original line
set breakindent
"	character to display for long lines that wrap across the terminal
let &showbreak="> "
"	show all options in footer
set wildmenu
"	ignore case for filename completion
set wildignorecase
"	recursive searching
set path+=**
"	show full words on their own line
set linebreak
"	show inputs
set showcmd
"	make folding character a box-drawing character so it is solid
set fillchars=fold:─,vert:│
"	use system clipboard by default
set clipboard=unnamedplus

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
if &diff
	colorscheme allomancer
else
	colorscheme mydelek
endif

"	ask the user for a new nesting value
function! PromptNest()
	call inputsave()
	let value = input('Enter a nest value: ')
	call inputrestore()
	if value ==# ""
		echo "value not set"
	else
		execute "set foldnestmax=" . value
	endif
endfunction

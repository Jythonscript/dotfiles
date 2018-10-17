"Plugins list

"Index Search: https://www.vim.org/scripts/script.php?script_id=1682 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   My bindings

"   Control+] makes matching brackets
map <C-]> <Esc>A<Space>{<Esc>o}<Esc>O
"	map <C-]> <Esc>A<Space>{<Esc>o}<Esc>O<Esc>
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
noremap + :set relativenumber!<Enter>
set relativenumber
set number
set hlsearch
noremap - :set hlsearch! hlsearch?<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   My bindings

"   Control+] makes matching brackets
map <C-]> <Esc>A<Space>{<Esc>o}<Esc>O
"	map <C-]> <Esc>A<Space>{<Esc>o}<Esc>O<Esc>
filetype indent on
syntax enable 
"set smarttab
set shiftwidth=4
set tabstop=4
set so=7
set mouse=a
noremap <A-/> <ESC>mzI//<ESC>`z
noremap <A-?> <ESC>mz^xx<ESC>`z
noremap <A-o> <ESC>ddO

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Plugin bindings

"	custom leader
let mapleader = ","

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
let g:ale_enabled=0
"	vimtex
noremap <leader>v :VimtexCompile<CR>
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options = '@pdf 2>/dev/null'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode = 0
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
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
"	fastfold
let g:fastfold_minlines=0
"	Netrw
"	disable banner
let g:netrw_banner=0
"	open in prior window
"let g:netrw_browse_split=4
"	open splits to the right
let g:netrw_altv=1
"	tree view
let g:netrw_liststyle=3
"	vimtex
let g:vimtex_compiler_latexmk = {
\ 'build_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'hooks' : [],
\ 'options' : [
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\   '-shell-escape',
\ ],
\}
"	Instant
let g:instant_username = "Jythonscript"
"    Auto Pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsMapCh = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Custom bindings
"	session creating and loading
nnoremap <leader>sn :exec "mks!" . "~/.config/nvim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR>
nnoremap <leader>sl :exec "source" . "~/.config/nvim/sessions/" . substitute(expand("%:p:h"), "/", "_", "g") . ".vim"<CR> | colo mydelek

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Commands
" open PDFs in zathura
command ZATHURA silent exe "!echo " . shellescape(expand("%")) . " | grep -oP '^[^\.]+' | xargs -I{} zathura '{}'.pdf 2>/dev/null &disown" | redraw!
"	open LaTeX default file
command LATEX execute '!cp ~/.config/nvim/templates/notes.tex .' | e notes.tex

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Neovim
"	remove footer
set laststatus=1
"	live regex replace
set inccommand=nosplit
"	fix embedded lua syntax
let g:vimsyn_embed = 'lPr'
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Visual", timeout=100, on_visual=false}

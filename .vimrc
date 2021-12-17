" Set hybrid line numbers
set nu rnu

" Disable bell sound
set belloff=all

" Change leader key
let mapleader=","
map <leader>t :tab term<CR>
map <leader>d :tabe %:p<CR>
map <leader>c :let @/=""<CR>
map <leader>e :tabe $MYVIMRC<CR>
inoremap jj <Esc>

" Change key which starts a <C-W> command in a terminal window
set termwinkey=<C-Y>

" Make vim use full truecolor support
set termguicolors
colorscheme peachpuff

" Custom VIM terminal color scheme that works with peachpuff colorscheme
let g:terminal_ansi_colors=[
\'#101010', 
\'#a82c2c',
\'#257525',
\'#945019',
\'#252575',
\'#750075',
\'#005555',
\'#808080',
\'#606060',
\'#d82828',
\'#168c16',
\'#8c8c16',
\'#2828b8',
\'#900090',
\'#009090',
\'#EEEEEE'
\]

" Replace grep with rg
set grepprg=rg\ -n\ 

" Makes gvim work nice with Windows system clipboard
set clipboard=unnamed

" Indent with spaces instead of tabs (filetype specific indents)
filetype plugin indent on
" Turn off filetype plugin loading (seems to slow down vim autocompletion cause it searches through include path (very slowly))
filetype plugin off

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Enable command-line suggestions
set wildmenu
set wildmode=longest:full,full

" Enable syntax highlighting
syntax enable

" Disable word-wrapping by default
set nowrap
" Set smart case insensitive search
set ignorecase
set smartcase

" Enable incremental search
set incsearch

" Enable search highlighting
set hlsearch

" Set directory where vim will keep tmp files
set directory^=$HOME/.vim/tmp//

" Set default behaviour of splits to be to the bottom and to the right
set splitbelow
set splitright

" Enable delete with backspace when in insert mode
set backspace=indent,eol,start

" Remove all default terminal mappings (so that the default bash keybindings can be used)
tmapclear
" C-L is typically mapped to redraw, it could be that netrw has it mapped to something else as well
" unmap <C-L>

" Add special keys for switching tabs (that work the same in normal and terminal mode)
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
tnoremap <C-h> <C-Y>:tabprevious<CR>
tnoremap <C-l> <C-Y>:tabnext<CR>
" Go to normal mode with C-t
tnoremap <C-t> <C-Y>N
" Quit terminal with C-q
tnoremap <C-/> <C-Y>:q!<CR>
" Paste with C-v in terminal
tnoremap <C-v> <C-Y>"+
" Enter command mode
tnoremap <C-[> <C-Y>:

" Make netrw default display to `tree`
let g:netrw_liststyle=1
" Sort files by size
let g:netrw_sort_by="size"
" Ignore files in .gitignore
"let g:netrw_list_hide= netrw_gitignore#Hide()

" Make find search down in subfolders
set path+=**
" Make it ignore certain filetypes & dirs
set wildignore+=**/*.pyc

"Activate lisp support on lisp filetypes
autocmd BufNewFile,BufRead *.lisp set lisp

" Command that silences the enter something to continue
command! -nargs=+ Silent execute 'silent <args>' | execute 'redraw!'
" Git Bash command
" command -nargs=+ GitBashArgs Silent !"git-bash" \-\c <args>  
command -nargs=0 GitBash call system('git-bash &')
command -nargs=+ GitBashArgs call system('git-bash -c <args> &')
command -nargs=0 Ipy GitBashArgs ipython
command -nargs=0 MakeTags GitBashArgs ./make_tags.sh
" Special commands
command -nargs=0 Black call system('py -3.7 -m black --line-length=120 ' . expand('%')) | execute 'e'
command -nargs=0 Isort call system('py -3.7 -m isort ' . expand('%')) | execute 'e'
command -nargs=0 Flake8 cgete system('py -3.7 -m flake8 ' . expand('%') . ' --ignore=E501,E266,W503')
command -nargs=0 Mypy cadde system('py -3.7 -m mypy --no-error-summary --follow-imports=silent ' . expand('%'))
command -nargs=0 PythonCmds execute 'Black' | execute 'Isort' | execute 'Flake8' | execute 'Mypy'

map <leader>p :PythonCmds<CR>
map <leader>m :MakeTags<CR>
map <leader>i :Ipy<CR>
" autocmd BufWritePost *.py PythonCmds 

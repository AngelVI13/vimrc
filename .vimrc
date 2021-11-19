" Set hybrid line numbers
set nu rnu

" Disable bell sound
set belloff=all

" Change leader key
let mapleader=","
map <leader>t :tab term<CR>

" Change key which starts a <C-W> command in a terminal window
set termwinkey=<C-M>

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

" Add special keys for switching tabs (that work the same in normal and terminal mode)
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
tnoremap <C-h> <C-M>:tabprevious<CR>
tnoremap <C-l> <C-M>:tabnext<CR>
" Go to normal mode with C-t
tnoremap <C-t> <C-M>N
" Quit terminal with C-q
tnoremap <C-/> <C-M>:q!<CR>
" Paste with C-v in terminal
tnoremap <C-v> <C-M>"+
" Enter command mode
tnoremap <C-[> <C-M>:

" Make netrw default display to `tree`
let g:netrw_liststyle=1
" Sort files by size
let g:netrw_sort_by="size"
" Ignore files in .gitignore
let g:netrw_list_hide= netrw_gitignore#Hide()

" Make find search down in subfolders
set path+=**
" Make it ignore certain filetypes & dirs
set wildignore+=**/*.pyc

" Command that silences the enter something to continue
command! -nargs=+ Silent execute 'silent <args>' | execute 'redraw!'
" Git Bash command
command -nargs=+ GitBashArgs Silent !"git-bash" \-\c <args>  

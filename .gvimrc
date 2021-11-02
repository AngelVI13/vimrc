" Set hybrid line numbers
set nu rnu

" Disable bell sound
set belloff=all

" Set git-bash as default shell
set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
" Settings to make git-bash commands be executed from gvim on windows
set shelltype=0
set shellcmdflag=-c
set shellxquote=\""\"
" set grepprg=\"C:\Program\ Files\Git\bin\sh.exe\"\ -c\ \"grep\ -n\ $*\" 
set grepprg=rg\ -n\ 
set shellpipe=>\ \"%s\"\ 2>&1

" Makes gvim work nice with Windows system clipboard
set clipboard=unnamed

" Set GUI font
set guifont=Consolas:h11:cANSI
" Remove toolbar and scrollbar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
" Always show status bar at the bottom of the screen
set laststatus=2
" Setup statusline
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
"set statusline+=%#todo#                      " switch to todo highlight
set statusline+=%f\                          " file name
"set statusline+=%*                           " switch to normal statusline highlight
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
" --- end statusline ---

" Remove scrollbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

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
" set wildmode=longest,list,full

" Set default background color to work with text highlighting
set background=dark

" Enable syntax highlighting
syntax enable

" Disable word-wrapping by default
set nowrap
" Set smart case insensitive search
set ignorecase
set smartcase

" Enable incremental search
set incsearch

" Add characters to list of number formats
set nrformats+=alpha

" Set directory where vim will keep tmp files
set directory^=$HOME/.vim/tmp//

" Set default behaviour of splits to be to the bottom and to the right
set splitbelow
set splitright

" Enable delete with backspace when in insert mode
set backspace=indent,eol,start

" Add special keys for switching tabs (that work the same in normal and terminal mode)
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
tnoremap <C-j> <C-W>:tabprevious<CR>
tnoremap <C-k> <C-W>:tabnext<CR>
" Go to normal mode with C-t
tnoremap <C-t> <C-W>N
" Quit terminal with C-q
tnoremap <C-q> <C-W>:q!<CR>
" Paste with C-v in terminal
tnoremap <C-v> <C-W>"+

" Make vim reload file if it was changed on disk while the file is still open
" in vim (i.e. when running black while still editting the file

set autoread                                                                                                       
au CursorHold * checktime

"Activate lisp support on lisp filetypes
autocmd BufNewFile,BufRead *.lisp set lisp

" Make vim use full truecolor support
set termguicolors
" colorscheme torte
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

" Display all matching files when we tab complete
" set wildmenu


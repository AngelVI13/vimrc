" Set hybrid line numbers
set nu rnu

" Disable bell sound
set belloff=all

let vim_path = "$HOME/"
let vimrc_path = vim_path . ".vimrc"
let spell_path = vim_path . "spell/en.utf-8.add"
let python_alias = "python3"

" Make statusline always active
set laststatus=2

" Reduce updatetime
set updatetime=250

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256

" Make vim use full truecolor support
set termguicolors
" Add ruler at 120 chars
set colorcolumn=90,120

" Replace grep with rg
set grepprg=rg\ -n\ 

" Makes gvim work nice with Windows system clipboard
set clipboard=unnamedplus

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
" set ignorecase
" set smartcase

" Enable incremental search
set incsearch

" Enable search highlighting
set hlsearch

" Spellcheck settings
" set spelllang=en
" set spellfile="$HOME/vimrc/.vim/spell/en.utf-8.add"

" Set directory where vim will keep tmp files
set directory^=$HOME/.vim/tmp//

" Set default behaviour of splits to be to the bottom and to the right
set splitbelow
set splitright

" Enable delete with backspace when in insert mode
set backspace=indent,eol,start

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

" Command that silences the enter something to continue
command! -nargs=+ Silent execute 'silent <args>' | execute 'redraw!'
" Tags command
command -nargs=0 MakeTags GitBashArgs ./make_tags.sh
command -nargs=0 MakeGenericTags Silent !ctags -R
" Special commands
command -nargs=1 Black call system(python_alias .' -m black --line-length=<args> ' . expand('%')) | execute 'e'
command -nargs=0 Isort call system(python_alias .' -m isort ' . expand('%')) | execute 'e'
command -nargs=0 Flake8 cgete system(python_alias .' -m flake8 ' . expand('%') . ' --ignore=E501,E266,W503')
command -nargs=0 Mypy cadde system(python_alias .' -m mypy --no-error-summary --follow-imports=silent ' . expand('%'))
command -nargs=0 PythonCmds execute 'Flake8' | execute 'Mypy'
command -nargs=1 PythonFmt execute 'Black <args>' | execute 'Isort'
command -nargs=1 Cheat call system("curl cheat.sh/<args> > temp.txt") | execute ":term cat temp.txt" 
command -nargs=0 Gofmt call system("gofmt -w " . expand('%')) | execute 'e'

" ---------- REMAPS ------------
" Remove all default terminal mappings (so that the default bash keybindings can be used)
tmapclear
" C-L is typically mapped to redraw, it could be that netrw has it mapped to something else as well
" unmap <C-L>

" Adjust movement keys to always center the screen
nnoremap <C-]> <C-]>zz
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
" Quickfix jumping
nnoremap <leader>] :cn<CR>zz
nnoremap <leader>[ :cp<CR>zz
nnoremap ]s ]s
nnoremap [s [s
" Set SPACE as alternative to C-6
nnoremap <SPACE> <C-^>
inoremap jj <C-[>

" Change leader key
let mapleader=","
" General mappings
map <leader>t :tab term<CR>
map <leader>c :let @/=""<CR>
map <leader>e :execute 'e ' . vimrc_path<CR>
map <leader>o :copen 3<CR>
map <leader>D :Ex<CR>
" Python mappings
map <leader>pp :PythonCmds<CR>:copen 3<CR>
map <leader>pf :PythonFmt 120<CR>
map <leader>pF :PythonFmt 90<CR>
" Tools mappings
map <leader>h :Cheat 
map <leader>Mt :MakeTags<CR>
map <leader>MT :MakeGenericTags<CR>
"" Delete marks
map <leader>dm :delm! \| delm A-Z0-9<CR>
"" Delete buffers
map <leader>db :ls<CR>:bd<Space>

" autocmd BufWritePost *.py PythonCmds 
" Opens all folds when file is opened
set foldlevelstart=99
au BufReadPre *.py setlocal foldmethod=indent 

" Setup plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" LSP
Plug 'natebosch/vim-lsc'
" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Git
Plug 'tpope/vim-fugitive'
" Colorschemes
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

""" LSP config
" Use all the defaults (recommended):
let g:lsc_auto_map = v:true
let g:lsc_server_commands = {}
let g:lsc_server_commands['go'] = {
        \'command': 'gopls serve',
        \'log_level': -1,
        \'suppress_stderr': v:true,
        \}
let g:lsc_server_commands['python'] = {
        \'command': 'pyls',
        \'log_level': -1,
        \'suppress_stderr': v:true,
        \}
" Disable preview window
set completeopt-=preview
" Autoformat go files on save
autocmd BufWritePost *.go Gofmt 
""" FZF config
" Command remaps
map <leader>f :Files<Cr>
map <leader>g :GFiles<Cr>
map <leader>b :Buffers<Cr>
" Jump to mark
map <leader>m :Marks<Cr>
map <leader>s :Rg<Cr>
map <leader>G :Git<Cr>

""" Colorschemes
" colorscheme peachpuff
" set background=dark
" download from https://github.com/morhetz/gruvbox
" colorscheme gruvbox
" let g:gruvbox_contrast_dark="hard"
" let g:gruvbox_transparent_bg=1
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_menu_selection_background = "blue"
colorscheme tokyonight

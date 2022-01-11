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
map <leader>o :copen 3<CR>
inoremap jj <Esc>

" Change key which starts a <C-W> command in a terminal window
set termwinkey=<C-Y>

" Make vim use full truecolor support
set termguicolors
" colorscheme peachpuff
set background=dark
" download from https://github.com/morhetz/gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_transparent_bg=1

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

" Adjust movement keys to always center the screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap <C-]> <C-]>zz
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
nnoremap n nzz
nnoremap N Nzz
" Add special keys for switching tabs (that work the same in normal and terminal mode)
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
inoremap <C-h> <Esc>:tabprevious<CR>
inoremap <C-l> <Esc>:tabnext<CR>
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

"Activate lisp & forth support on lisp filetypes
"NOTE: the forth stuff in the autocmd might not be needed since it might be covered in the filetype cmd
autocmd BufNewFile,BufRead *.lisp,*.forth,*.fs set lisp
let filetype_fs = "forth"

" Command that silences the enter something to continue
command! -nargs=+ Silent execute 'silent <args>' | execute 'redraw!'
" Git Bash command
command -nargs=0 GitBash call system('git-bash &')
command -nargs=+ GitBashArgs call system('git-bash -c <args> &')
command -nargs=0 Ipy GitBashArgs ipython
command -nargs=0 MakeTags GitBashArgs ./make_tags.sh
" Special commands
command -nargs=0 Black call system('py -3.7 -m black --line-length=120 ' . expand('%')) | execute 'e'
command -nargs=0 Isort call system('py -3.7 -m isort ' . expand('%')) | execute 'e'
command -nargs=0 Flake8 cgete system('py -3.7 -m flake8 ' . expand('%') . ' --ignore=E501,E266,W503')
command -nargs=0 Mypy cadde system('py -3.7 -m mypy --no-error-summary --follow-imports=silent ' . expand('%'))
command -nargs=0 PythonCmds execute 'Flake8' | execute 'Mypy'
command -nargs=0 PythonFmt execute 'Black' | execute 'Isort'
command -nargs=1 Cheat call system("curl cheat.sh/<args> > temp.txt") | execute ":term cat temp.txt" 

" NOTE: the following section sets up search integration with rg & fzf. Make sure you have
"       fzf installed: https://github.com/junegunn/fzf
" This is the default search command for fzf
" let $FZF_DEFAULT_COMMAND = "rg --files --hidden | sed 's/\\/\//g'"  
" Runs external command, captures output and returns the first line of the output
funct! ExecCaptureOutput(cmd)
    execute "silent !" . a:cmd . " > .output.txt"
    " The sed replaces inplace backslashes with forward slashes from filepath
    execute "silent !sed -i ". shellescape('s/\\/\//g') . " .output.txt"
    let output = readfile(".output.txt")
    if len(output) == 0
        let output = ""
    else
        let output = output[0]
    endif
    execute "redraw!"
    return output
endfunct!

" Run external command and open in new tab the output string (expecting a filename)
funct! Exec(cmd)
    let output = ExecCaptureOutput(a:cmd)
    if len(output) == 0
        return ""
    endif
    execute 'tabe ' . output
endfunct!

" Run external `rg` command and open in new tab the output string (expecting a filename + lineno)
funct! ExecRg(cmd)
    let output = ExecCaptureOutput(a:cmd)
    if len(output) == 0
        return ''
    endif
    let output = split(output, ":")
    let filename = output[0]
    let line_number = output[1]
    execute 'tabe ' . filename
    execute ':' . line_number
    return ''
endfunct!

command -nargs=0 GitFiles call Exec("git ls-files | fzf --preview='head -$LINES {}'")
command -nargs=0 Files call Exec("rg --files --hidden | fzf --preview='head -$LINES {}'")
command -nargs=* SearchFiles call ExecRg('rg -n --color always <args> "" | fzf --ansi --preview="$HOME/.vim/search_preview.sh {}"')
" Command remaps
nnoremap <C-f> :Files<Cr>
nnoremap <C-g> :GitFiles<Cr>
nnoremap \ :SearchFiles 

map <leader>pp :PythonCmds<CR>
map <leader>pf :PythonFmt<CR>
map <leader>ps :SearchFiles -tpy<CR>
map <leader>h :Cheat 
map <leader>m :MakeTags<CR>
map <leader>i :Ipy<CR>

" autocmd BufWritePost *.py PythonCmds 

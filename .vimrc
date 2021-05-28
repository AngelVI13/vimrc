" Set hybrid line numbers
set nu rnu

" Set default background color to work with text highlighting
set background=dark

" Set default behaviour of splits to be to the bottom and to the right
set splitbelow
set splitright

" Make vim reload file if it was changed on disk while the file is still open
" in vim (i.e. when running black while still editting the file

set autoread                                                                                                       
au CursorHold * checktime

" Make vim use full truecolor support
set termguicolors
colorscheme torte


""""""""""""""""""""""""""
" MY FUNCTIONS
""""""""""""""""""""""""""
" Fullscreen auto
au! GUIEnter * simalt ~x

set modeline
filetype indent plugin on

if has('win32')
	execute 'cd ' . $HOME
endif

" Creation files
so $HOME/vimfiles/vimScripts/functions.vim

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" unmap home row keys to force motion use
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>

noremap g Gzz
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
set backspace=2 " ensure backspace works as it does in all other programs
set autoread
let mapleader=","
let g:mapleader=","

" Mapping leader keys
nnoremap <leader>v :tabedit $VIMRC<CR>
 
" always show statusbar, even if no buffer loaded
set laststatus=2

""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""
set ruler
set incsearch
set hlsearch
set mat=2
set showmatch

" Show line numbers
set nu

" auto indent
set ai
" smart indent
set si
" wrap lines
set wrap

""""""""""""""""""""""""""
" GUI
""""""""""""""""""""""""""
if has("gui_running") 
    set guioptions-=T
    set guioptions+=e
    set guifont=Consolas:h11
    set t_Co=256
    set guitablabel=%M\ %t
endif

""""""""""""""""""""""""""
" COLOURS
""""""""""""""""""""""""""
" dark background
colors koehler

set encoding=utf8

set ffs=unix,dos,mac

""""""""""""""""""""""""""
" BINDS: INTERFACE
""""""""""""""""""""""""""

" maps CtrlF to search
map <c-f> /

" Maps go-to-line-beginning to go to the first non-whitespace character
" good for Python usage
map 0 ^

" Maps leader " to wrap current word in quotations
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:noremap <leader>sv :source $MYVIMRC<CR>

" Maps leader cd to set current directory to the one of this file
:noremap <leader>cd execute 'cd ' . expand("%:h")

""""""""""""""""""""""""""
" BINDS: FILE
""""""""""""""""""""""""""

" Bind Control-S to saving the file
" as in every other program
nnoremap <c-s> <ESC>:w!<CR>

""""""""""""""""""""""""""
" DEFAULT
""""""""""""""""""""""""""

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap

    " auto-reload vimrc when changed
    " autocmd! bufwritepost vimrc source $MYVIMRC 
    " auto-reload when changed
    " autocmd! bufwritepost *.vim source %
	
	autocmd BufReadPre * syntax on
augroup END


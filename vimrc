""""""""""""""""""""""""""
"" VIMRC CONFIG FILE
""""""""""""""""""""""""""
"" Install Location: ~/.vim/
"" Author: Ben Simner

execute 'cd ' . $HOME

" setup vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Other installed bundles
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-repeat'

call vundle#end()
filetype plugin indent on

map <F2> :NERDTreeToggle<CR>

" for powerline
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set guifont=DejaVu\ Sans\ Mono
set laststatus=2

" Fullscreen auto
au! GUIEnter * simalt ~x
filetype indent plugin on

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


" Better split navigation
nnoremap <C-J> <C-W><C-W>j
nnoremap <C-K> <C-W><C-W>k
nnoremap <C-L> <C-W><C-W>l
nnoremap <C-H> <C-W><C-W>h

" make C-W-V create a new buffer in a vsplit
nnoremap <C-W><C-V> :vnew<CR>

set splitbelow
set splitright

""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
set backspace=2 " ensure backspace works as it does in all other programs
set autoread
let mapleader=","
let g:mapleader=","

" Mapping leader keys
nnoremap <leader>v :tabedit $VIMRC<CR>

""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""
set ruler
set incsearch
set hlsearch
set mat=2
set showmatch

" automatically change window's cwd to file's dir
set autochdir

" Show line numbers
set nu

" auto indent
set ai
" smart indent
set si
" wrap lines
set wrap

set modeline
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
syntax on

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

" Creation files
so ~/.vim/vimscripts/functions.vim

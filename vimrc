""""""""""""""""""""""""""
"" VIMRC CONFIG FILE
""""""""""""""""""""""""""
"" Install Location: ~/.vim/
"" Author: Ben Simner

exe 'cd ' . $HOME

" setup vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Other installed bundles
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-repeat'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

map <F2> :NERDTreeToggle<CR>
nnoremap Q n.

" Config for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" for powerline
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set guifont=DejaVu\ Sans\ Mono
set laststatus=2

" Fullscreen auto
au! GUIEnter * simalt ~x
filetype indent plugin on

set splitbelow
set splitright

""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
set backspace=2 " ensure backspace works as it does in all other programs
set autoread

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
" DEFAULT
""""""""""""""""""""""""""

augroup vimrc_autocmds
    autocmd!
	
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap

    autocmd bufwritepost *.vim source %	
	autocmd BufReadPre * syntax on
	
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" Creation files
so ~/.vim/vimscripts/functions.vim
so ~/.vim/vimscripts/mappings.vim

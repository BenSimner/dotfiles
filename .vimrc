""""""""""""""""""""""""""
"" VIMRC CONFIG FILE
""""""""""""""""""""""""""
"" Install Location: ~/.vimrc
"" Ensure vim is compiled with +python
"" Author: Ben Simner

execute 'mksession! ' . (expand('~') . '/.vim/.vimsession_default')

" Vim setup without +python cannot run
" so just exit with warning
" allowing default vim config.
if (!has('python'))
    put! = 'Python Not Detected!'
    finish
endif

" ensure we are in correct directory.
exe 'cd ' . expand('~')

" dark background
" colorscheme koehler
colorscheme luna

" setup vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Other installed bundles
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'sjl/gundo.vim'

Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

" Config for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
filetype indent plugin on
set splitbelow
set splitright
set wildmenu

set backspace=2 " ensure backspace works as it does in all other programs
set autoread

let python_highlight_builtin_funcs = 1
""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""
set ruler
set incsearch
set hlsearch
set mat=2
set showmatch
set cursorline

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
    set guitablabel=%M\ %t
endif

""""""""""""""""""""""""""
" COLOURS
""""""""""""""""""""""""""
syntax on
set showcmd

" Allow xterm-256 colors
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set encoding=utf8
set ffs=unix,dos

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

""""""""""""""""""""""""""
" DEFAULT
""""""""""""""""""""""""""
augroup vim_autos
    autocmd!

    " Automatically source any viml files when saved
    autocmd BufWritePost *.vim source %
augroup END

function! Vim_Leave()
    call sessions#ExitVim()
endfunction

function! Vim_Enter()
    call sessions#EnterVim()
endfunction

augroup vim_exit_commands
    autocmd!

    autocmd VimEnter * call Vim_Enter()
    autocmd VimLeave * call Vim_Leave()
augroup END

""""""""""""""""""""""""""
"" VIMRC CONFIG FILE
""""""""""""""""""""""""""
"" Install Location: ~/.vimrc
"" Ensure vim is compiled with +python
"" Author: Ben Simner

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
"colorscheme luna
colorscheme sirius

" setup vundle

" Disable Vi-compatability
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
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'dag/vim2hs'

call vundle#end()
filetype plugin indent on
"
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit="vertical"

"vim2hs no lig
let g:haskell_conceal = 0

""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
filetype indent plugin on
set splitbelow
set splitright
set wildmenu

" set <leader> to be my preferred key
let mapleader=","
let g:mapleader=","

" Hide buffer when editing another
" instead of abandoning
set hidden

set backspace=2 " ensure backspace works as it does in all other programs
set autoread

" Vim will interpret tabs as having 4 spaces
set tabstop=4
" Ensure indents are also 4 spaces
set shiftwidth=4
set softtabstop=4
" Make TABs spaces.
set expandtab

let g:python_highlight_builtin_funcs = 1
""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""
set ruler
set incsearch
set hlsearch
set mat=2
set showmatch

set cursorline

" show command in status bar
set showcmd

" automatically change window's cwd to file's dir
set autochdir

set number relativenumber

" Show line numbers
augroup vim_numbers
    autocmd!

    autocmd InsertEnter, FocusLost * set number norelativenumber
    autocmd InsertLeave, FocusGained * set relativenumber number
augroup END

" auto indent
set ai
" smart indent
set si
" wrap lines
set wrap

set modeline

" Show tabs and nonbreakingspaces
exec 'set listchars=nbsp:~,tab:▸\ '
set list

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

" Allow xterm-256 colorsset term=xterm
set term=xterm

" Fix colorscheme on a tmux terminal
if exists('$TMUX')
  set term=screen-256color
endif

set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set encoding=utf8
set ffs=unix,dos

""""""""""""""""""""""""""
" DEFAULT
""""""""""""""""""""""""""
function! SafePrompt(reg, prompt)
    """Safely prompts the user for text and places that text into register a:reg"""
    call inputsave()
    let text = inputdialog(a:prompt)
    exe "let @" . a:reg . ' = "' . text . '"'
    call inputrestore()
    return text
endfunction

augroup vim_autos
    autocmd!

    " Automatically source any viml files when saved
    autocmd BufWritePost *.vim source %

    " Auto set *bash_* files to sh ft
    autocmd BufRead,BufNewFile *bash_* setf sh

    " Auto set htmldjango filetype on html files
    autocmd BufRead,BufNewFile *.html set ft=htmldjango

augroup END

function! Vim_Leave()
endfunction

function! Vim_Enter()
endfunction

augroup vim_exit_commands
    autocmd!

    autocmd VimEnter * call Vim_Enter()
    autocmd VimLeave * call Vim_Leave()
augroup END
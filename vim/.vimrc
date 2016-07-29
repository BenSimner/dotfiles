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

let g:python_path = system('which python3')

" ensure we are in correct directory.
exe 'cd ' . expand('~')

" dark background
" colorscheme koehler
"colorscheme luna
colorscheme sirius

if &compatible
    set nocompatible               " Be iMproved
endif

execute pathogen#infect()
filetype plugin indent on

" Use fzf
set rtp+=~/software/fzf

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
set completeopt-=preview

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Neosnippet
" Plugin key-mappings.
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Syntastic
let g:syntastic_python_python_exec = g:python_path
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E302,E501'

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

" split to right and below
set splitbelow
set splitright

set wildmenu
set autochdir

set lazyredraw
set ttyfast

set mouse=a
set virtualedit=onemore

set synmaxcol=300

" Open all folds initially
set foldmethod=indent
set foldlevelstart=99

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

" Solid line for vsplit separator
set fcs=vert:│

" Don't show the intro
set shortmess+=I

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

set autoindent
set smartindent
set smartcase
" wrap lines
set wrap

set modeline

" turn off sound/bells
set noeb vb t_vb=

" Show tabs and nonbreakingspaces
exec 'set listchars=nbsp:~,tab:▸\ ,trail:·'
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
    "autocmd BufWritePost *.py Complexity

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

""""""""""""""""""""""""""
" VUNDLE
""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/vimfiles/bundle/vundle/
call vundle#rc('$HOME/vimfiles/bundle')

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/pep8'

" Powerline setup
set guifont=DejaVu+Sans+Mono+for+Powerline

filetype off
syntax on
filetype plugin indent on
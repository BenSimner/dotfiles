""""""""""""
" JAVA
""""""""""""

" For files which do not have modeline,
" ensure we stick to 4spaces for indent

highlight Excess ctermbg=DarkGrey guibg=Black
match Excess /\%120v.*/
set nowrap

" Vim will interpret tabs as having 4 spaces
set tabstop=4
" Ensure indents are also 4 spaces
set shiftwidth=4
set softtabstop=4
" Make TABs spaces.
set expandtab

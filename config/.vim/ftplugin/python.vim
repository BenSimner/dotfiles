""""""""""""
" PYTHON
""""""""""""
" For files which do not have modeline,
" ensure we stick to 4spaces for indent
" as python insists on this.

highlight Excess ctermbg=DarkGrey guibg=Black
match Excess /\%120v.*/

set nowrap
" Determine fold levels by increasing level for each class
function! PythonFold()
    let thisline = getline(v:lnum)
    if match(thisline, '^class') >= 0
        return ">1"
    else
        return "="
    endif
endfunction

" Enable folding on classes
setlocal foldmethod=expr
setlocal foldexpr=PythonFold()
 
normal zR

" persistence.vim - Reloads some settings on entering vim
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_persistence")
    finish
else
    let g:loaded_persistence = 1
endif

let g:persistence_file = "~/.persistence.vim"

" List of names of options to save and load on restart
" These are overwritten by ftplugins and the like
" So tab values for example are saved
let g:persistence_bool_options = ["expandtab"]
let g:persistence_options = ["tabstop"]

function persistence#save_options()
    let l:lines = []
    let l:filename = expand(g:persistence_file)

    " Save boolean options (1, 0) === set / set no
    for opt in g:persistence_bool_options
        let l:s = eval("&" . opt)
        if s == 1
            let l:lines = l:lines + ['set ' . opt]
        else
            let l:lines = l:lines + ['set no' . opt]
        endif
    endfor 

    " Save numeric/value options
    for opt in g:persistence_options
        let l:s = eval("&" . opt)
        let l:lines = l:lines + ['set ' . opt . '=' . l:s]
    endfor 

    " Save colorscheme
    let l:lines = l:lines + ['colorscheme ' . g:colors_name]

    if writefile(l:lines, l:filename) != 0
        echom "Cannot write to " . l:filename . ", do you have permission?"
        echom "Press any key to continue"
        call getchar()
    endif

endfunction

function persistence#load_options()
    let l:filename = expand(g:persistence_file)

    if filereadable(l:filename)
        execute "source " . g:persistence_file
    else
        echom "Persistence has not loaded a default file..."
    endif
endfunction

augroup persistence_vim_cmds
    autocmd!

    autocmd VimEnter * call persistence#load_options()
    autocmd VimLeave * call persistence#save_options()
augroup END

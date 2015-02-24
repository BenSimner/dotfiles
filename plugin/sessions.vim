" sessions.vim - Load and Save Vim sessions
" Author:   Ben Simner
" Version:  1.0
" The default vim mksession command has an issue:
" - it does not update with .vimrc

if exists("g:loaded_sessions")
    finish
else
    let g:loaded_sessions = 1
endif

let g:loaded_global = 0

function! sessions#EnterVim()
    echom 'Load previous session? (Y/n)'
    let l:confirm = getchar()
    
    if (nr2char(l:confirm) ==? 'y')
        let g:loaded_global = 1
        LoadSession __previous__
    endif
endfunction

function! sessions#ExitVim()
    " Always save previous session on exit
    SaveSession! __previous__
endfunction

function! sessions#CreateSessionDir()
    let l:dir = expand('~') . '\.vim\sessions\'
    if !isdirectory(l:dir)
        call mkdir(l:dir)
    endif
endfunction

function! sessions#SaveSession(SessionName, Bang)
    call sessions#CreateSessionDir()
    let l:exists = sessions#SessionExists(a:SessionName)
    let l:filename = sessions#GetSessionFile(a:SessionName)
    if (l:exists !=# 'NULL' && a:Bang != '!')
        echom 'Session Already Exists, Overwrite? (Y/n)'
        let l:confirm = getchar()
        if (nr2char(l:confirm) !=? 'y')
            return
        endif
    endif
    
	let l:vimsession = (expand('~') . '\.vim\.vimsession')
	let l:test_name = (expand('~') . '\.vim\.vimsession2')
	let l:py_diff = expand('~') . '\.vim\scripts\diff.py'

    execute 'mksession! ' . l:test_name
	" Call python diff on this
	execute 'silent !python ' . l:py_diff . ' ' . l:test_name . ' ' . l:vimsession . ' ' . l:filename
    echom 'Created Session ' . a:SessionName
endfunction

function! sessions#LoadSession(SessionName)
    let l:fn = sessions#SessionExists(a:SessionName)
    if l:fn ==# 'NULL'
        echom 'Cannot load session ' . a:SessionName
    else
        execute 'source ' . l:fn
    endif
endfunction

function! sessions#SessionExists(SessionName)
    let l:filename = sessions#GetSessionFile(a:SessionName)
    if (filereadable(l:filename))
        return l:filename
    else
        return 'NULL'
    endif
endfunction

function! sessions#GetSessionFile(SessionName)
    return expand('~') . '\.vim\sessions\' . a:SessionName . '.vimsession'
endfunction

command! -nargs=1 -bang SaveSession call sessions#SaveSession('<args>', '<bang>')
command! -nargs=1 LoadSession call sessions#LoadSession('<args>')

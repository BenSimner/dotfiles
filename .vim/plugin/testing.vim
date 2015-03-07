" testing.vim - Testing framework
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_testing")
    finish
else
    let g:loaded_testing = 1
endif

function s:is_test_file(file_name)
    if (a:file_name =~? '/v.+_test/.py')
        return 1
    endif

    return 0
endfunction

function testing#open_current_test_file()
    let ft = &ft
    echom "Loading Tests for ft '" . ft . "'"
    if (ft != 'python')
        echom 'Error: Cannot open test file for filetype: "' . ft . '"'
        return
    endif

    let l:baldname = expand('%')
    let l:test_file_name = fnameescape(expand('%:p:r') . '_test.py')

    if (s:is_test_file(l:baldname) == 0)
        if filereadable(l:test_file_name)
            exe 'vspl ' . l:test_file_name
        else
            call s:create_test_file(l:test_file_name)
        endif
    endif
endfunction

function s:create_test_file(test_file_name)
    exe 'silent vnew ' . a:test_file_name
endfunction

function testing#run_current_test_file()
    let l:baldname = expand('%')
    let l:test_file_name = fnameescape(expand('%:p:r') . '_test.py')

    let l:test_run_file = expand('~') . '/.vim/scripts/tests.py'

    exe "!python " . l:test_run_file . " " . l:test_file_name
endfunction

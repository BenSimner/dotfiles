"" <leader>pt opens or creates the test file for the current file.
noremap <leader>ot :OpenTests<CR>
noremap <leader>rt :RunTests<CR>

let g:created_new_test = 0

function! IsTest(fileName)
    if (a:fileName =~? '\vtest_.+\.py')
        return 1
    endif
    
    return 0
endfunction

function! OpenTestFile()
    " Check filetype
    if (&ft != 'python')
        echom 'Error: Cannot open test file for filetype: "' . &ft . '"'
        return
    endif

    let l:baldname = expand('%')
    let l:test_filename = fnameescape(expand('%:p:h') . '/tests/test_' . l:baldname)

    if (IsTest(l:baldname) == 0)
        if (filereadable(l:test_filename))
            exe  "vspl " . l:test_filename
        else
            let g:created_new_test = 1
            
            silent exe '!mkdir tests'
            exe "silent vnew " . l:test_filename
        endif
    endif
endfunction

function! RunTests()
    if (&ft != 'python')
        echom 'Error: Cannot run test file for filetype: "' . &ft . '"'
        return
    endif
    
    "pyf ~/.vim/vimscripts/run_tests.py
    let l:test_run_file = expand('~') . '\.vim\vimscripts\run_tests.py'
    exe '!python ' . l:test_run_file
endfunction


"v
"" Create commands for running, creating and opening tests
"" 

" Open Test file for current file
command! OpenTests call OpenTestFile()
command! RunTests call RunTests()

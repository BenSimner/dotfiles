"" F3 runs the current file
noremap <F3> :call CompileAndRun()<CR>

"" Pressing space jumps to next code block
"" wrapping around if at end of file
noremap <space> :call JumpToNextFunction("/")<CR>
noremap <C-space> :call JumpToNextFunction("?")<CR>

"" F4 will create a new file with a given name
noremap <F4> :call CreateNewFile()<CR>

function! CreateNewFile()
    let fname = input("Filename: ")
    execute 'vnew ' . fname
endfunction

function! CreatePythonProject()
    " Determine if the file is a generated test_ file.
    if (g:created_new_test == 1)
        " Insert our import statement
        let l:fname = expand('%:t:r')[5:]
        let l:importStmt = 'from .. import ' . l:fname
        
        execute 'normal! 8Ga' . l:importStmt
        execute "normal! 9Go"
        let g:created_new_test = 0
    endif
    
    " Finally, check to see if we need to create a package out of this file
    " i.e. if __init__.py exists in its directory or not.
    if (!filereadable('__init__.py'))
        silent exe '!type NUL > __init__.py'
    endif
endfunction

function! InsertBoilerplate_Java()
    call append(line('$'), ['/**','* vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4','* Author: Ben Simner','* Date: ' . strftime("%a, %d %b %Y"),'*/', ''])
    call append(line('$'), ['public class ' . expand("%:r"), '{'])
    call append(line('$'), ['}'])
    
    execute "normal! 9Go"
    startinsert!
endfunction

function! CompileAndRun()
    let ftType = &ft
    if (ftType == 'python')
        let b:filename = expand("%:p")
        execute '!python "' . b:filename . '"'
    elseif (ftType == 'dosbatch' || ftType == 'sh' )
        execute '!%'
	elseif (ftType == 'haskell')
		let b:filename = expand("%:p")
		execute '!ghci ' . b:filename
    endif
endfunction

" Jumps to the next function definition
function! JumpToNextFunction(searcher)
    let ftType = &ft
    if (ftType == 'python')
        call JumpToNextDef_Python(a:searcher)
    elseif (ftType == 'java')
        call JumpToNextDef_Java(a:searcher)
    elseif (ftType == 'vim')
        call JumpToNextDef_Vim(a:searcher)
    endif
endfunction


" Jumps to next function in a vimscript file
function! JumpToNextDef_Vim(searcher)
    execute "normal " . a:searcher . "function!\<CR>zz"
endfunction

" PYTHON function definition
function! JumpToNextDef_Python(searcher)
    execute 'normal! ' . a:searcher . 'def ' . "\<CR>zz"
endfunction

" JAVA function definition
function! JumpToNextDef_Java(searcher)
    execute "normal! " . a:searcher . '{' . "\<CR>zz"
endfunction

function! OpenTestFile()
    let l:baldname = expand('%')
    let l:test_filename = fnameescape(expand('%:p:h') . '\tests\test_' . l:baldname)

    if (IsTest(l:baldname) == 0)
        if (filereadable(l:test_filename))
            exe  "vspl " . l:test_filename
        else
            silent execute 'silent !mkdir tests'
            exe "silent vnew " . l:test_filename
        endif
    endif
endfunction

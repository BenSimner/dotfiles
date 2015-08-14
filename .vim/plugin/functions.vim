" functions.vim - Plugin containing a bunch of helpful file functions
" mainly tailored towards Windows usage, which requires
" more aid than Linux when deploying/running code
" via the 'terminal'

" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_functions")
    finish
else
    let g:loaded_functions = 1
endif

" Python executable
let g:python_bin = 'python'
let g:haskell_extensions = '-Wall'
let g:python_extensions = ''

" <leader>r runs the current file, <leader>R does an advanced run
" (advanced will run the current java project)
noremap <leader>r :call functions#compile_and_run()<CR>
noremap <leader>R :call functions#compile_and_run_alt()<CR>

" F4 will create a new file with a given name
" and open it in new vsplit
noremap <F4> :call functions#create_new_file()<CR>

" <F5> followed by language prefix will create a new project for that language
" in the current directory
" prefixes:
"   p - Python (with setup.py and tests/ folder for nosetests)
noremap <F5>p :call functions#create_python_project()<CR>


" Pressing <Space> jumps to next code block
" wrapping around if at end of file
" Pressing <C-Space> jumps to previous code block
noremap <Space> :call functions#jump_to_next_block("/")<CR>
" | for non-gui versions of vim, <C-Space> (also <A-Space> etc) map to the
" null character
noremap <NUL> :call functions#jump_to_next_block("?")<CR> 

function functions#create_python_project()
    " Creates a new Python project
    " Python projects are essentially just directories
    " hence, the setup is very simple.
    let l:name = input("Project Name (Python): ")
    
    " Exit function if user escapes out of input
    if (l:name == "")
        return
    endif
    
    let l:current_dir = expand("%:p:h")
    let l:dir = l:current_dir . '/' . l:name . '/'
    
    let l:src_dir = l:dir . '/' . l:name
    let l:test_dir = l:dir . '/tests'
    
    " Create our two folders
    call mkdir(l:dir)
    call mkdir(l:src_dir)
    call mkdir(l:test_dir)
    
    let l:setup_file_contents = readfile($HOME . '/.vim/plugin/files/setup.py')
    
    let i = 0
    let n = len(l:setup_file_contents)
    while i < n
        let l:s = l:setup_file_contents[i]
        " Perform variable substitutions
        let l:setup_file_contents[i] = substitute(l:s, '_VIM_PROJECTNAME_', l:name, 'g')
        let i += 1
    endwhile
    
    call writefile(l:setup_file_contents, l:dir . '/setup.py')
    
    call writefile([], l:src_dir . '/__init__.py')
    call writefile([], l:test_dir . '/__init__.py')
endfunction 

function functions#create_new_file()
    let l:fname = input("Filename: ")

    if (l:fname != "")
        execute 'vnew ' . l:fname
    endif
endfunction


" Try run this program direct
" Through its own interpreter
function functions#compile_and_run()
    let ftType = &ft

    " Clear screen
    execute 'silent !clear'

    if (ftType == 'python')
        let b:filename = expand("%:p")
        execute '!' . g:python_bin . ' ' . b:filename . ' ' . g:python_extensions
    elseif (ftType == 'dosbatch' || ftType == 'sh' )
        execute '!./%'
    elseif (ftType == 'haskell')
        let b:filename = expand("%:p")
        execute '!start ghci ' . b:filename . ' ' . g:haskell_extensions
    endif
endfunction


" Alternate compile and run tries to run the current buffer
" direct in shell
" by calling !%
function functions#compile_and_run_alt()
    execute 'silent !clear'
    execute '!./%'
endfunction

" Jumps to the next function definition
function functions#jump_to_next_block(searcher)
    let ftType = &ft
    if (ftType == 'python')
        call s:jump_to_next_block_py(a:searcher)
    elseif (ftType == 'java')
        call s:jump_to_next_block_java(a:searcher)
    elseif (ftType == 'vim')
        call s:jump_to_next_block_vim(a:searcher)
    endif
endfunction


" Jumps to next function in a vimscript file
function s:jump_to_next_block_vim(searcher)
    execute "normal! " . a:searcher . "function \\p*(\\p*)\<CR>zz"
endfunction

" PYTHON function definition
function s:jump_to_next_block_py(searcher)
    execute 'normal! ' . a:searcher . 'def ' . "\<CR>zz"
endfunction

" JAVA function definition
function s:jump_to_next_block_java(searcher)
    execute "normal! " . a:searcher . '{' . "\<CR>zz"
endfunction

function! functions#rewrite_current_file(new_file_name)
    " No Change, just write current file and proceed
    if expand(a:new_file_name) == expand("%:p")
        write
        return
    endif

    " Write new file, move to it, and delete old
    let l:old_file_name = expand('%:p')
    execute "write " . a:new_file_name
    execute "edit! " . a:new_file_name
    call delete(l:old_file_name)
endfunction

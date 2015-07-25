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

" F3 runs the current file, Ctrl-F3 does an advanced run
" (advanced will run the current java project)
noremap <F3> :call functions#compile_and_run()<CR>
noremap <C-F3> :call functions#compile_and_run_alt()<CR>

" F4 will create a new file with a given name
" and open it in new vsplit
noremap <F4> :call functions#create_new_file()<CR>

" F5 followed by language prefix will create a new project for that language
" in the current directory
" prefixes:
"   p - Python (with setup.py and tests/ folder for nose)
noremap <F5>p :call functions#create_python_project()<CR>


" Pressing <Space>-n jumps to next code block
" wrapping around if at end of file
" Pressing <Space>-p jumps to previous code block
noremap <Space>n :call functions#jump_to_next_block("/")<CR>
noremap <Space>p :call functions#jump_to_next_block("?")<CR>

function functions#create_java_project()
    ""
    "" TODO: Move temporary java compilation method to Apache Ant.
    ""
    
    " Creates a new java project in the current directory with a name /dir/
    " does this by creating a /src/ folder for source files
    " and creates /dir/src/Main.java which holds the entrypoint
    let l:name = input("Project Name (Java): ")
    
    " Exit function if user escapes out of input
    if (l:name == "")
        return
    endif
    
    let l:current_dir = expand("%:p:h")
    let l:dir = l:current_dir . '\' . l:name . '\'
    
    " Create our two folders
    call mkdir(l:dir)
    call mkdir(l:dir . "/src/")
    
    " Make our Main.java + main method
    " By copying .vim\Main.java
    let l:file_contents = readfile($HOME . '\.vim\plugin\files\Main.java')
    call writefile(l:file_contents, l:dir . '\src\Main.java')
    
    " Do same with our .manifest file
    let l:file_contents = readfile($HOME . '\.vim\plugin\files\.manifest')
    call writefile(l:file_contents, l:dir . '\.manifest')
    
    " Finally make our .javaproject file to tell Vim this directory is a javaproject
    call writefile([l:name, l:dir], l:dir . '\.javaproject')
endfunction

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
    let l:dir = l:current_dir . '\' . l:name . '\'
    
    let l:src_dir = l:dir . '\' . l:name
    let l:test_dir = l:dir . '\tests'
    
    " Create our two folders
    call mkdir(l:dir)
    call mkdir(l:src_dir)
    call mkdir(l:test_dir)
    
    let l:setup_file_contents = readfile($HOME . '\.vim\plugin\files\setup.py')
    
    let i = 0
    let n = len(l:setup_file_contents)
    while i < n
        let l:s = l:setup_file_contents[i]
        let l:setup_file_contents[i] = substitute(l:s, '_VIM_PROJECTNAME_', l:name, 'g')
        let i += 1
    endwhile
    
    call writefile(l:setup_file_contents, l:dir . '\setup.py')
    
    call writefile([], l:src_dir . '\__init__.py')
    call writefile([], l:test_dir . '\__init__.py')
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
        execute '!' . g:python_bin . "' . b:filename . '" ' . g:python_extensions
    elseif (ftType == 'dosbatch' || ftType == 'sh' )
        execute '!%'
    elseif (ftType == 'haskell')
        let b:filename = expand("%:p")
        execute '!start ghci ' . b:filename . ' ' . g:haskell_extensions
    else
        " default to trying to run current java project
        call functions#compile_and_run_java()
    endif
endfunction


" Alternate compile and run tries to run the current buffer
" direct in shell
" by calling !%
function functions#compile_and_run_alt()
    execute 'silent !clear'
    execute '!%'
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

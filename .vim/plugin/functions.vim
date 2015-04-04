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
let g:python_exe = 'python'

" F3 runs the current file, Ctrl-F3 does an advanced run
" (advanced will run the current java project)
noremap <F3> :call functions#compile_and_run()<CR>
noremap <C-F3> :call functions#compile_and_run_java()<CR>

" F4 will create a new file with a given name
noremap <F4> :call functions#create_new_file()<CR>

" F5 followed by language prefix will create a new project for that language
" in the current directory
" prefixes:
"   j - Java
"   p - Python
noremap <F5>j :call functions#create_java_project()<CR>
noremap <F5>p :call functions#create_python_project()<CR>

" Pressing space jumps to next code block
" wrapping around if at end of file
noremap <space> :call functions#jump_to_next_function("/")<CR>
noremap <C-space> :call functions#jump_to_next_function("?")<CR>

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

function functions#compile_and_run_java()
    ""
    "" TODO: Move temporary java compilation method to Apache Ant.
    ""
    
    " Search for our .javaproject file
    let l:path = functions#get_javaproject_path(expand("%:p:h"))
    
    if (l:path == "NULL")
        return 0
    endif
    
    let l:fs = readfile(l:path)
    let l:dir = l:fs[1]
    let l:name = l:fs[0]
    
    " Compile all java files
    " Generate our list file (for win)
    exe 'silent !dir ' . l:dir . '\*.java /S /b /A > ' . l:dir . '\.classlist'
    
    " Create /bin/ directory if it does not exist.
    if (filewritable(l:dir . '\bin') == 0)
        call mkdir(l:dir . '\bin')
    endif
    exe '!javac @' . l:dir . '\.classlist -d ' . l:dir . '\bin'
    
    " Create our jar file
    " Including all directories 
    let l:args = 'include/'
    exe 'silent !cd ' . l:dir . ' && jar cfm0 ' . l:name . '.jar ' . '.manifest -C include/ . -C bin/ .' 
   
    " Run the jar file
    exe '!cd ' . l:dir . ' && java -jar ' . l:dir . '\' . l:name . '.jar'
endfunction

function functions#get_javaproject_path(dir)
    " Check if .javaproject exists in dir
    " If it does, return the path to it
    if (fnamemodify(a:dir, ":h") == fnamemodify(a:dir, ":h:h"))
        return "NULL"
    endif
    
    let l:jp_name = a:dir . "/.javaproject"
    if filereadable(l:jp_name)
        return l:jp_name
    else
        return functions#get_javaproject_path(fnamemodify(a:dir, ":h"))
    endif
endfunction

function functions#update_python_exe()
    " reads the first 5 lines 
    " if a shebang header for python is detected
    " update windows python version with correct exe
    let l:header = getline(0, 4)
    let l:r = matchstr(l:header, "python3")

    if l:r != ""
        let g:python_exe = "python3"
    else
        let g:python_exe = "python"
    endif
endfunction

function functions#compile_and_run()
    let ftType = &ft
    if (ftType == 'python')
        let b:filename = expand("%:p")
        call functions#update_python_exe()
        execute '!' . g:python_exe . ' "' . b:filename . '"'
    elseif (ftType == 'dosbatch' || ftType == 'sh' )
        execute '!%'
    elseif (ftType == 'haskell')
        let b:filename = expand("%:p")
        execute '!start ghci ' . b:filename . ' -Wall'
    else
        " default to trying to run current java project
        call functions#compile_and_run_java()
    endif
endfunction

" Jumps to the next function definition
function functions#jump_to_next_function(searcher)
    let ftType = &ft
    if (ftType == 'python')
        call s:jump_to_next_function_py(a:searcher)
    elseif (ftType == 'java')
        call s:jump_to_next_function_java(a:searcher)
    elseif (ftType == 'vim')
        call s:jump_to_next_function_vim(a:searcher)
    endif
endfunction


" Jumps to next function in a vimscript file
function s:jump_to_next_function_vim(searcher)
    execute "normal! " . a:searcher . "function \\p*(\\p*)\<CR>zz"
endfunction

" PYTHON function definition
function s:jump_to_next_function_py(searcher)
    execute 'normal! ' . a:searcher . 'def ' . "\<CR>zz"
endfunction

" JAVA function definition
function s:jump_to_next_function_java(searcher)
    execute "normal! " . a:searcher . '{' . "\<CR>zz"
endfunction
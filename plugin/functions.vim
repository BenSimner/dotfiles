" functions.vim - Plugin containing a bunch of helpful file functions
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_functions")
    finish
else
    let g:loaded_functions = 1
endif

" F3 runs the current file
noremap <F3> :call functions#compile_and_run()<CR>
noremap <C-F3> :call functions#compile_and_run_java()<CR>

" F4 will create a new file with a given name
noremap <F4> :call functions#create_new_file()<CR>
noremap <F5> :call functions#create_java_project()<CR>

" Pressing space jumps to next code block
" wrapping around if at end of file
noremap <space> :call functions#jump_to_next_function("/")<CR>
noremap <C-space> :call functions#jump_to_next_function("?")<CR>

function functions#create_java_project()
    " Creates a new java project in the current directory with a name /dir/
    " does this by creating a /src/ folder for source files
    " and creates /dir/src/Main.java which holds the entrypoint
	let l:name = input("Project FolderName: ")
	let l:current_dir = expand("%:p:h")
	let l:dir = l:current_dir . '\' . l:name . '\'
	
	" Create our two folders
	call mkdir(l:dir)
    call mkdir(l:dir . "/src/")
	
	" Make our Main.java + main method
	" By copying .vim\Main.java
	let l:file_contents = readfile($HOME . '\.vim\plugin\Main.java')
	call writefile(l:file_contents, l:dir . '\src\Main.java')
	
	" Do same with our .manifest file
	let l:file_contents = readfile($HOME . '\.vim\plugin\.manifest')
	call writefile(l:file_contents, l:dir . '\.manifest')
	
	" Finally make our .javaproject file to tell Vim this directory is a javaproject
	call writefile([l:name, l:dir], l:dir . '\.javaproject')
endfunction

function functions#create_new_file()
    let fname = input("Filename: ")
    execute 'vnew ' . fname
endfunction

function functions#compile_and_run_java()
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
	" Compile .class files from our list file
	call mkdir(l:dir . '\bin')
	exe 'silent !javac @' . l:dir . '\.classlist -d ' . l:dir . '\bin'
	" Create our jar file
	exe 'silent !jar cfm0 ' . l:dir . '\' . l:name . '.jar ' . l:dir . '\.manifest -C  ' . l:dir . '\bin .'
	" Run the jar file
	exe '!java -jar ' . l:dir . '\' . l:name . '.jar'
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

function functions#compile_and_run()
    let ftType = &ft
    if (ftType == 'python')
        let b:filename = expand("%:p")
        execute '!python "' . b:filename . '"'
    elseif (ftType == 'dosbatch' || ftType == 'sh' )
        execute '!%'
    elseif (ftType == 'haskell')
        let b:filename = expand("%:p")
        execute '!start ghci ' . b:filename
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
    execute "normal " . a:searcher . "function\CR>zz"
endfunction

" PYTHON function definition
function s:jump_to_next_function_py(searcher)
    execute 'normal! ' . a:searcher . 'def ' . "\<CR>zz"
endfunction

" JAVA function definition
function s:jump_to_next_function_java(searcher)
    execute "normal! " . a:searcher . '{' . "\<CR>zz"
endfunction

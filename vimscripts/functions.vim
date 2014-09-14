
"" F3 runs the current file
noremap <F3> :call CompileAndRun()<CR>

"" Pressing space jumps to next code block
"" wrapping around if at end of file
noremap <space> :call JumpToNextFunction()<CR>

"" F4 will create a new file with a given name
noremap <F4> :call CreateNewFile()<CR>

augroup write_read_files
	autocmd!
	
	" Insert Boilerplate code into a new file
	autocmd BufNewFile * :call InsertBoilerplate()
	
	" After saving, re-indent entire file
	" autocmd BufWritePre * normal magg=G`a
augroup END

function! CreateNewFile()
	let fname = input("Filename: ")
	execute 'vnew ' . fname
endfunction

function! InsertBoilerplate()
	""
	"" Inserts boilerplate code in a new file
	""
	set ai!
	set si!
	
	let ftType = &ft
	if (ftType == 'python')
		call InsertBoilerplate_Python()
	elseif (ftType == 'java')
		call InsertBoilerplate_Java()
	endif

	set ai!
	set si!
endfunction

function! InsertBoilerplate_Python()
	""
	"" Inserts boilerplate code in a new python file.
	""
	
	let text = "# vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 \r
	\# file: ". bufname("%") . " \r
	\# Author: Ben Simner \r
	\# Date: " . strftime("%a, %d %b %Y") . "\r#\r#\r\r\r\r\r#for testing\rif (__name__ == \"__main__\"):\r	pass\r"
	execute "normal! \<ESC>a" . text
	execute "normal! 8Go"
    startinsert!
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
	endif
endfunction

" Jumps to the next function definition
function! JumpToNextFunction()
	let ftType = &ft
	if (ftType == 'python')
		call JumpToNextDef_Python()
	elseif (ftType == 'java')
		call JumpToNextDef_Java()
	endif
endfunction

" PYTHON function definition
function! JumpToNextDef_Python()
	execute 'normal! /def ' . "\<CR>zz"
endfunction

" JAVA function definition
function! JumpToNextDef_Java()
	execute "normal! " . '/{' . "\<CR>zz"
endfunction

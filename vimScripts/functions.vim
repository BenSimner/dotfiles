noremap <F3> :!python %<CR>
noremap <c-space> <c-n>
noremap <F4> :call CreatePyFile()<CR>
noremap f :call JumpToNextFunction()<CR>

augroup python_files
	autocmd!
	autocmd BufNewFile *.py :call InsertCopyright()
	autocmd BufWritePre *.py :normal gg=G
augroup END

" Jumps to the next function definition
function JumpToNextFunction()
	call JumpToNextDefJava()
endfunction

" PYTHON function definition
function JumpToNextDef()
	execute "normal! " . "/def" . "\<CR>zz"
endfunction

" JAVA function definition
function JumpToNextDefJava()
	" jumps to next block
	execute "normal! " . '/{' . "\<CR>zz"
endfunction

" Creates a new python file
"	and opens a new tab
function CreatePyFile()
	let fname = input("Script Name: ")
    execute "vnew " . fname . ".py"
endfunction

" Inserts the copyright above a .py file
function! InsertCopyright()
	set noai
	set nosi
		
	let copyrightText = "# \r
	\# \r
	\# file: ". bufname("%") . " \r
	\# This file is licenced under the terms of the MIT License \r
	\# Author: Ben Simner \r
	\# Date: " . strftime("%a, %d %b %Y") . "\r# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4\r\r\r#for testing\rif (__name__ == \"__main__\"):\r	pass\r"
	execute "normal! \<ESC>a" . copyrightText
	
	set ai
	set si
endfunction

map <c-d> :call ReplaceSentenceWithDef()<ENTER>

" Replaces a sentence with a function definition
function ReplaceSentenceWithDef()
	execute "normal! 0idef \<esc>ea(\<esc>lxv$"
	call ReplaceWhitespaceWithCommasVISUALMODE()
	execute "normal! \<esc>$a):\<esc>o  "
	execute "normal a"
endfunction

" Replaces all whitespace in selected text with , [COMMA SPACE]
"	returns 0 if no whitespace in selection (or no selection)
function ReplaceWhitespaceWithCommasVISUALMODE()
	try
		s:\%V\s:, :g
	catch
		return 0
	endtry
	
	return 1
endfunction

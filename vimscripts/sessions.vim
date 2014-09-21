""
"" Sessions
""

let g:loaded_global = 0

function! Sessions#EnterVim()
	echom 'Load Global Session? (Y/n)'
	let l:confirm = getchar()
	
	if (nr2char(l:confirm) ==? 'y')
		let g:loaded_global = 1
		LoadSession Global
	endif
endfunction

function! Sessions#ExitVim()
	if (g:loaded_global == 1)
		SaveSession! Global
	else
		echom 'Overwrite Global Session? (Y/n)'
		let l:confirm = getchar()
		
		if (nr2char(l:confirm) ==? 'y')
			SaveSession! Global
		endif
	endif
endfunction

function! Sessions#CreateSessionDir()
	let l:dir = expand('~') . '\.vim\sessions\'
	if !isdirectory(l:dir)
		call mkdir(l:dir)
	endif
endfunction

function! Sessions#SaveSession(SessionName, Bang)
	call Sessions#CreateSessionDir()
	let l:exists = Sessions#SessionExists(a:SessionName)
	let l:filename = Sessions#GetSessionFile(a:SessionName)
	if (l:exists !=# 'NULL' && a:Bang != '!')
		echom 'Session Already Exists, Overwrite? (Y/n)'
		let l:confirm = getchar()
		if (nr2char(l:confirm) !=? 'y')
			return
		endif
	endif
	
	execute 'mksession! ' . l:filename
    echom 'Created Session ' . a:SessionName
endfunction


"" Create our own session file
"" Our session file saves the state of each buffer in order
"" and stores it as a vimscript file which can just be sourced
function! Sessions#CreateSessionFile(SessionFile)

endfunction

function! Sessions#LoadSession(SessionName)
	let l:fn = Sessions#SessionExists(a:SessionName)
	if l:fn ==# 'NULL'
		echom 'Cannot load session ' . a:SessionName
	else
		NERDTreeClose
		execute 'source ' . l:fn
	endif
endfunction

function! Sessions#SessionExists(SessionName)
	let l:filename = Sessions#GetSessionFile(a:SessionName)
	if (filereadable(l:filename))
		return l:filename
	else
		return 'NULL'
	endif
endfunction

function! Sessions#GetSessionFile(SessionName)
    return expand('~') . '\.vim\sessions\' . a:SessionName . '.vimsession'
endfunction

command! -nargs=1 -bang SaveSession call Sessions#SaveSession('<args>', '<bang>')
command! -nargs=1 LoadSession call Sessions#LoadSession('<args>')

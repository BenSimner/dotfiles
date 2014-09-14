""
"" Sessions
""

function! Sessions#CreateSessionDir()
	let l:dir = expand('~') . '\.vim\sessions\'
	if !isdirectory(l:dir)
		call mkdir(l:dir)
	endif
endfunction

function! Sessions#SaveSession(SessionName, Bang)
	call Sessions#CreateSessionDir()
	let l:filename = Sessions#SessionExists(a:SessionName)
	
	NERDTreeClose
	
	if (l:filename != 'NULL' && a:Bang != '!')
		echom 'Session Already Exists, Overwrite? (Y/n)'
		let l:confirm = getchar()
		if (l:confirm !=? 'y')
			return
		endif
	endif
	execute 'mksession! ' . l:filename
endfunction

function! Sessions#LoadSession(SessionName)
	let l:fn = Sessions#SessionExists(a:SessionName)
	if l:fn == 'NULL'
		echom 'Cannot load session ' . a:SessionName
	else
		execute 'source ' . l:fn
	endif
endfunction

function! Sessions#SessionExists(SessionName)
	let l:filename = expand('~') . '\.vim\sessions\' . a:SessionName . '.vimsession'
	if (filereadable(l:filename))
		return l:filename
	else
		return 'NULL'
	endif
endfunction

command -nargs=1 -bang SaveSession call Sessions#SaveSession('<args>', '<bang>')
command -nargs=1 LoadSession call Sessions#LoadSession('<args>')

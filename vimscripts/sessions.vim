""
"" Sessions
""

let g:loaded_global = 0

function! Sessions_EnterVim()
	echom 'Load Global Session? (Y/n)'
	let l:confirm = getchar()
	
	if (nr2char(l:confirm) ==? 'y')
		let g:loaded_global = 1
		LoadSession Global
	endif
endfunction

function! Sessions_ExitVim()
	" Always save previous session on exit
	SaveSession! previous
	
	" Handle Global Session
	if (g:loaded_global == 1)
		SaveSession! Global
	endif
endfunction

function! Sessions_CreateSessionDir()
	let l:dir = expand('~') . '\.vim\sessions\'
	if !isdirectory(l:dir)
		call mkdir(l:dir)
	endif
endfunction

function! Sessions_SaveSession(SessionName, Bang)
	call Sessions_CreateSessionDir()
	let l:exists = Sessions_SessionExists(a:SessionName)
	let l:filename = Sessions_GetSessionFile(a:SessionName)
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

function! Sessions_LoadSession(SessionName)
	let l:fn = Sessions_SessionExists(a:SessionName)
	if l:fn ==# 'NULL'
		echom 'Cannot load session ' . a:SessionName
	else
		NERDTreeClose
		execute 'source ' . l:fn
	endif
endfunction

function! Sessions_SessionExists(SessionName)
	let l:filename = Sessions_GetSessionFile(a:SessionName)
	if (filereadable(l:filename))
		return l:filename
	else
		return 'NULL'
	endif
endfunction

function! Sessions_GetSessionFile(SessionName)
    return expand('~') . '\.vim\sessions\' . a:SessionName . '.vimsession'
endfunction

command! -nargs=1 -bang SaveSession call Sessions_SaveSession('<args>', '<bang>')
command! -nargs=1 LoadSession call Sessions_LoadSession('<args>')

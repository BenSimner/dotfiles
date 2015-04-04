" java.vim - Temporary java methods
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_java")
    finish
else
    let g:loaded_java = 1
endif

noremap <F9> :call java#import_under_cursor()<CR>

let g:jdk_classlist = 'C:\Program Files\Java\jdk1.8.0_40\jre\lib\classlist'

function java#import_under_cursor()
    if &ft != 'java'
        echom "Can only add imports in Java files"
        return
    endif

    let l:word_under = expand("<cword>")

    " search for word in classlist
    let l:classes = readfile(g:jdk_classlist)
    let l:linenr = match(l:classes, '.\+\/' . l:word_under . "$")

    if l:linenr < 0
        echom "Cannot find '" . l:word_under . "' in JDK library"
        return
    endif
    
    " convert that line's / into .
    " and insert into imports
    let l:import_name = substitute(l:classes[l:linenr], '/', ".", "g")
    let l:import_stmt = 'import ' . l:import_name .  ';'
    
    let l:import_line = s:get_import_start() + 1
    echom 'Adding import for ' . l:import_name ' on line ' . l:import_line
    call append(l:import_line, l:import_stmt)
endfunction

function s:get_import_start()
    let l:lines = getline(0, '$')
    let l:linenr = match(l:lines, 'import')

    if l:linenr < 0
        let l:linenr = match(l:lines, 'class')
        let l:linenr = l:linenr - 1
    endif

    return l:linenr
endfunction

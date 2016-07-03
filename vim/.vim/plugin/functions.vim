if exists("g:loaded_functions")
    finish
else
    let g:loaded_functions = 1
endif

" Pressing <Space> jumps to next empty line
noremap <Space> :call functions#jump_to_next_block()<CR>
noremap <NUL> :call functions#jump_to_last_block()<CR> 

" Jumps to the next blank line
function functions#jump_to_next_block()
    execute "normal! /^\\s*$\<CR>j0"
endfunction

function functions#jump_to_last_block()
    execute "normal! ?^\\s*$\<CR>k0"
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
    execute "edit " . a:new_file_name
    call delete(l:old_file_name)
endfunction

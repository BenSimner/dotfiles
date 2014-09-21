" 
" Vim ~.swp editing management

let s:save_cpo = &cpo
set cpo&vim

augroup swapmanage
    autocmd!
    autocmd SwapExists * call Handleswap(expand('<afile>:p'))
augroup END

function! Handleswap(swapfile)
    if getftime(v:swapname) < getftime(a:swapfile)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    else
        let v:swapchoice = 'o'
    endif
endfunction

let &cpo = s:save_cpo
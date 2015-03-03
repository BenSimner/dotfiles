" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 
" Luna Colourscheme by Ben Simner
"
"

""""""""""""""""""""""""""""""
"" Preamble {{{
""

set background=dark

highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "luna"
let s:c256 = 0

"" }}}

""""""""""""""""""""""""""""""
"" Assorted functions {{{
""
function! s:GUI(groupName, guifg, guibg)
    let guifg = 'guifg='
    if a:guifg == []
        let guifg = guifg . 'NONE'
    else
        let guifg = guifg . '#' . a:guifg[0] . ' ctermfg=' . a:guifg[1]
    endif

    let guibg = 'guibg='

    if a:guibg == []
        let guibg = guibg . 'NONE'
    else
        let guibg = guibg . '#' . a:guibg[0] . ' ctermbg=' . a:guibg[1]
    endif

    let high_string = 'hi ' . a:groupName . ' ' . guifg . ' ' . guibg
    execute high_string
endfunction
"" }}}
""""""""""""""""""""""""""""""
"" Color palette {{{
""

"" Each color is a list with [rgb, cterm] colour formats 
" for xterm 256
let s:white        = ['ffffff', '15']
let s:black        = ['000000', '0']
let s:gravel       = ['f8f8f2', '252']
let s:darkgravel   = ['272822', '234']
let s:blackgravel  = ['1c1b1a', '232']
let s:limegreen    = ['00ff00', '46']
let s:darkgreen    = ['00ba00', '34']
let s:darkgray     = ['3e3d32', '236']
let s:lightgray    = ['bcbcbc', '247']
let s:mediumgray   = ['9b9b9b', '241']
let s:darkred      = ['8D0303', '52']
let s:palered      = ['A85656', '167']
let s:heavygravel  = ['857f78', '239']
let s:mediumblue   = ['00AAEE', '32']
let s:lightblue    = ['8FBFDF', '74']
let s:mediumgold   = ['dcdc4b', '178']
let s:mediumpurple = ['bc55aa', '57']
let s:lightpurple  = ['c969b9', '164']

"" }}}
""""""""""""""""""""""""""""""
"" Colorscheme {{{
""

call s:GUI('Normal'          , s:gravel      , s:blackgravel)
call s:GUI('Comment'         , s:darkgreen   , [])
call s:GUI('LineNr'          , s:lightgray   , s:darkgray)
call s:GUI('CursorLine'      , []            , s:darkgravel)
call s:GUI('CursorLineNr'    , s:white       , s:darkgray)
call s:GUI('CursorColumn'    , []            , s:darkgravel)
call s:GUI('String'          , s:palered     , [])
call s:GUI('vimString'       , s:palered     , [])
call s:GUI('Statement'       , s:lightblue   , [])
call s:GUI('Define'          , s:heavygravel , [])
call s:GUI('Function'        , s:mediumgold  , [])
call s:GUI('Include'         , s:lightpurple , [])
call s:GUI('Error'           , s:lightpurple , [])
call s:GUI('BuiltInFunction' , s:lightpurple , [])
"" }}}

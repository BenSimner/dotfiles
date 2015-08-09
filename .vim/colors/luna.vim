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

let colors_name = "luna"

"" }}}

""""""""""""""""""""""""""""""
"" Assorted functions {{{
""

if !exists('g:set_hi_func')
    let g:set_hi_func = 0

    function s:set_hi(groupName, guifg, guibg)
        let guifg = 'guifg='
        if a:guifg == []
            let guifg = guifg . 'NONE'
        else
            let guifg = guifg . a:guifg[0] . ' ctermfg=' . a:guifg[1]
        endif

        let guibg = 'guibg='

        if a:guibg == []
            let guibg = guibg . 'NONE'
        else
            let guibg = guibg . a:guibg[0] . ' ctermbg=' . a:guibg[1]
        endif

        let high_string = 'hi ' . a:groupName . ' ' . guifg . ' ' . guibg
        execute high_string
    endfunction
endif

"" }}}
""""""""""""""""""""""""""""""
"" Color palette {{{
""

"" Each color is a list with [gui, cterm] colour formats 
let s:white        = ['#ffffff', '15']
let s:black        = ['#000000', '0']
let s:gravel       = ['#f8f8f2', '252']
let s:darkgravel   = ['#272822', '234']
let s:blackgravel  = ['#1c1b1a', '232']
let s:limegreen    = ['#00ff00', '46']
let s:darkgreen    = ['#00ba00', '34']
let s:darkgray     = ['#3e3d32', '236']
let s:lightgray    = ['#bcbcbc', '247']
let s:mediumgray   = ['#9b9b9b', '241']
let s:darkred      = ['#8D0303', '52']
let s:palered      = ['#A85656', '167']
let s:heavygravel  = ['#857f78', '239']
let s:mediumblue   = ['#00AAEE', '32']
let s:lightblue    = ['#8FBFDF', '74']
let s:mediumgold   = ['#dcdc4b', '178']
let s:mediumpurple = ['#bc55aa', '57']
let s:lightpurple  = ['#c969b9', '165']
let s:darkgrey     = ['grey15', '235']
let s:pastalgrey   = ['grey16', '236']
let s:grey27       = ['grey27', '238']
let s:grey35       = ['grey35', '240']
let s:grey40       = ['grey40', '7']
let s:grey50       = ['grey50', '3']
let s:khaki        = ['khaki', '106']
let s:brightred    = ['#ff0000', '1']

"" }}}
""""""""""""""""""""""""""""""
"" Colorscheme {{{
"" some inspiration taken from slate and some from molokai
""

call s:set_hi('Normal'          , s:gravel      , s:darkgrey)
call s:set_hi('Cursor'          , s:khaki       , s:grey50)
call s:set_hi('Comment'         , s:darkgreen   , [])
call s:set_hi('LineNr'          , s:lightgray   , s:grey27)
call s:set_hi('CursorLine'      , []            , s:grey27)
call s:set_hi('CursorColumn'    , []            , s:grey27)
call s:set_hi('CursorLineNr'    , s:white       , s:darkgray)
call s:set_hi('String'          , s:palered     , [])
call s:set_hi('Identifier'      , s:gravel      , [])
call s:set_hi('vimString'       , s:palered     , [])
call s:set_hi('Statement'       , s:lightblue   , [])
call s:set_hi('Function'        , s:mediumgold  , [])
call s:set_hi('Operator'        , s:lightblue   , [])
call s:set_hi('Define'          , s:lightpurple , [])
call s:set_hi('Include'         , s:lightpurple , [])
call s:set_hi('Error'           , s:white       , s:brightred)
call s:set_hi('BuiltInFunction' , s:lightpurple , [])
call s:set_hi('NonText'         , s:white       , s:darkgravel)
call s:set_hi('Ignore'          , s:grey40      , s:grey40)
call s:set_hi('TODO'            , s:white       , s:darkgrey)
"" }}}

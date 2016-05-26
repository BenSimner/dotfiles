" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 
" Sirius colorscheme
" Based of luna but with more standard white colors
"
"
""""""""""""""""""""""""""""""
"" Preamble {{{
""

set background=light

highlight clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "sirius"

"" }}}

""""""""""""""""""""""""""""""
"" Assorted functions {{{
""

if !exists('s:set_hi_func')
    let s:set_hi_func = 0

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
let s:palewhite        = ['#ffffff', '7']
let s:black        = ['#000000', '0']
let s:gravel       = ['#f8f8f2', '252']
let s:darkgravel   = ['#272822', '234'] 
let s:blackgravel  = ['#1c1b1a', '232']
let s:limegreen    = ['#00ff00', '46']
let s:darkgreen    = ['#00ba00', '34']
let s:deepgreen    = ['#00ba00', '22']
let s:darkgrey     = ['#3e3d32', '236']
let s:lightgrey    = ['#bcbcbc', '247']
let s:mediumgrey   = ['#9b9b9b', '241']
let s:darkred      = ['#8D0303', '52']
let s:palered      = ['#A85656', '167']
let s:heavygravel  = ['#857f78', '239']
let s:lightblue    = ['#8FBFDF', '74']
let s:mediumblue   = ['#00AAEE', '32']
let s:darkblue     = ['#00AAEE', '18']
let s:mediumgold   = ['#dcdc4b', '178']
let s:lightpurple  = ['#c969b9', '165']
let s:mediumpurple = ['#bc55aa', '57']
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
""

call s:set_hi('Normal'          , s:darkgrey     , s:white)
call s:set_hi('Constant'        , s:darkgrey     , s:white)
call s:set_hi('Type'            , s:black        , s:white)
call s:set_hi('Special'         , s:black        , s:white)
call s:set_hi('Number'          , s:darkgrey     , s:white)
call s:set_hi('Cursor'          , s:darkgrey     , s:white)
call s:set_hi('Comment'         , s:darkgrey, s:white)
call s:set_hi('LineNr'          , s:white        , s:lightgrey)
call s:set_hi('CursorLine'      , []             , s:gravel)
call s:set_hi('CursorLine'      , []             , s:gravel)
call s:set_hi('CursorColumn'    , []             , s:palewhite)
call s:set_hi('CursorLineNr'    , s:white        , s:darkgrey)
call s:set_hi('String'          , s:darkgrey, s:white)
call s:set_hi('Identifier'      , s:darkgrey, s:white)
call s:set_hi('vimString'       , s:darkgrey, s:white)
call s:set_hi('Statement'       , s:darkgrey, s:white)
call s:set_hi('Function'        , s:darkgrey, s:white)
call s:set_hi('Operator'        , s:darkgrey, s:white)
call s:set_hi('Define'          , s:darkgrey, s:white)
call s:set_hi('Include'         , s:darkgrey, s:white)
call s:set_hi('Error'           , s:darkred, s:white)
call s:set_hi('ErrorMsg'        , s:darkred, s:white)
call s:set_hi('BuiltInFunction' , s:lightgrey, s:white)
call s:set_hi('NonText'         , s:darkgrey, s:white)
call s:set_hi('Ignore'          , s:darkgrey, s:white)
call s:set_hi('TODO'            , s:darkgrey, s:white)
call s:set_hi('StatusLineNC'    , s:darkgrey, s:white)
call s:set_hi('StatusLine'      , s:darkgrey, s:white)
call s:set_hi('TabLineFill'     , s:darkgrey, s:white)
call s:set_hi('IncSearch'       , s:darkgrey, s:white)
call s:set_hi('VertSplit'       , s:darkgrey, s:white)

" Special formatting
hi Statement cterm=bold
hi Include cterm=bold
hi Special cterm=bold
hi Operator cterm=bold
hi Error cterm=italic
hi Constant cterm=bold
"" }}}

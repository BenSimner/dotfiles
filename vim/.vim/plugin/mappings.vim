" mappings.vim - Custom remappings
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_mapping")
    finish
else
    let g:loaded_mapping = 1
endif

" Swap semi-colon and colon characters around
" since : is used far more than ;
nnoremap ; :
nnoremap : ;

let mapleader = ","

"""""""""""""""""""""""""""""" "" File Navigation ""
" http://stackoverflow.com/questions/14367440/map-e-to-explore-in-command-mode
command! E Explore
cabbrev E Explore

" inserting newlines above and below current line
nnoremap <C-u> maO<Esc>`a
nnoremap <C-o> mao<Esc>`a

"nnoremap <C-f> <ESC>:call fzf#run({'dir': expand("%:h")})<CR>
nnoremap <C-f> <ESC>:execute 'FZF ' . expand("%:h")<CR>

" Control-R replaces current search string
nnoremap <C-r> :%s///g<Left><Left>

" Remaps Shift b and e to go to beginning and end
" of the current line
noremap B ^
noremap E $

" Map Arrow Keys to resizing splits
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>

" Remap visualblock mode to Shift+Q
nnoremap <S-q> <C-v>

""""""""""""""""""""""""""""""
"" Split and Tab Navigation
"" See: http://blog.chrisbe.st/articles/coding/two-years-of-vim
nnoremap <C-t> :tabnew<CR>
nnoremap <C-n> :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Map C-hjkl to moving around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap jk to g-jk
nnoremap j gj
nnoremap k gk

nnoremap <S-J> [m
nnoremap <S-K> ]m

""""""""""""""""""""""""""""""
"" Buffer Operations
""

" make new buffer in vsplit
nnoremap <C-v> :vsplit<CR>

""""""""""""""""""""""""""""""
"" File Operations
""

" maps <leader>w to save file
nnoremap <expr> <leader>w ":Save " . substitute(expand('%:p'), '/home/\w\+/', '~/', '')
nnoremap <expr> <leader>r ":Move " . substitute(expand('%:p'), '/home/\w\+/', '~/', '')
command -nargs=1 Move call functions#rewrite_current_file("<args>")
command -nargs=1 Save execute "sav <args>"

" Maps leader " to wrap current word in quotations
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <C-b> :Buffers<CR>

""""""""""""""""""""""""""""""
"" Leader Mappings
""

" Tabularise
nnoremap <leader>tt :Tab /
nnoremap <leader>te :Tab /=<CR>
nnoremap <leader>tv :Tab /¦<CR>
nnoremap <leader>tp :Tab /\|<CR>
nnoremap <leader>tc :Tab /,<CR>

" shortcut to edit and source myvimrc
nnoremap <leader>rc :tabnew $MYVIMRC<CR>
noremap <leader>sv <ESC>:source $MYVIMRC<CR>

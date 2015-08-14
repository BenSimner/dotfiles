" mappings.vim - Custom remappings
" Author:    Ben Simner
" Version:   1.0

if exists("g:loaded_mapping")
    finish
else
    let g:loaded_mapping = 1
endif

"" this file contains all mappings for my vim configuration
"" this file only contains standard vim mappings, it does not
"" contain any plugin-specific mappings


""""""""""""""""""""""""""""""
"" File Navigation
""

" maps f to search and Ctrl-f to backwards search
nnoremap f /
nnoremap <C-f> ?

" Control-R replaces current search string
nnoremap <C-r> :%s///g<Left><Left>

" Remaps Shift b and e to go to beginning and end
" of the current line
nnoremap B ^
nnoremap E $

" Map Arrow Keys to resizing splits
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>

" Jump-to-line
noremap gl Gzz
""""""""""""""""""""""""""""""
"" Split and Tab Navigation
"" See: http://blog.chrisbe.st/articles/coding/two-years-of-vim
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-w> :tabclose<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
inoremap <C-n> <Esc>:tabnext<CR>i
inoremap <C-w> <Esc>:tabclose<CR>i

" Map C-hjkl to moving around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""
"" Buffer Operations
""

" make new buffer in vsplit
nnoremap <C-v> :vnew<CR>

""""""""""""""""""""""""""""""
"" File Operations
""

" Map Control-S to saving the file
" as in every other program
nnoremap <c-s> <ESC>:w<CR>

" leader sv sources the .vimrc file
noremap <leader>sv :source $MYVIMRC<CR>

" Maps leader " to wrap current word in quotations
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

""""""""""""""""""""""""""""""
"" Leader Mappings
""

" Swap semi-colon and colon characters around
" since : is used far more than ;
nnoremap ; :
nnoremap : ;

" Tabularise
nnoremap <leader>tt :Tab /
nnoremap <leader>te :Tab /=<CR>
nnoremap <leader>tv :Tab /¦<CR>
nnoremap <leader>tp :Tab /\|<CR>
nnoremap <leader>tc :Tab /,<CR>

" shortcut to edit myvimrc
nnoremap <leader>ev :vspl $MYVIMRC<CR>

" Map ot and rt to open and run tests respectively.
nnoremap <leader>ot :call testing#open_current_test_file()<CR>
nnoremap <leader>rt :call testing#run_current_test_file()<CR>

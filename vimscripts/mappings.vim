""""""""""""""""""""""""""""""
"" Mappings File
""""""""""""""""""""""""""""""

"" this file contains all mappings for my vim configuration
"" this file only contains standard vim mappings, it deos not
"" contain any plugin-specific mappings

" set <leader> to be the comma key
let mapleader=","
let g:mapleader=","

""""""""""""""""""""""""""""""
"" File Navigation
""

" maps f to search
nnoremap f /

" Maps Shift-Q to jump to next and re-do
" using :normal <stuff><CR> allows a count
" to be used with the mapping
" see: http://vimcasts.org/episodes/creating-mappings-that-accept-a-count/
nnoremap Q :normal n.<CR>

" Maps go-to-line-beginning to go to the first non-whitespace character
" good for Python usage
noremap 0 ^

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Remap g to jump to line
" i.e. 50g will jump to line 50
" and centre on that line
noremap g Gzz


""""""""""""""""""""""""""""""
"" Split and Tab Navigation
""

" Better split navigation
nnoremap <C-J> <C-W><C-W>j
nnoremap <C-K> <C-W><C-W>k
nnoremap <C-L> <C-W><C-W>l
nnoremap <C-H> <C-W><C-W>h

""""""""""""""""""""""""""""""
"" Buffer Operations
""

" make C-W-V create a new buffer in a vsplit
nnoremap <C-W><C-V> :vnew<CR>

""""""""""""""""""""""""""""""
"" File Operations
""

" Map Control-S to saving the file
" as in every other program
nnoremap <c-s> <ESC>:w!<CR>

:noremap <leader>sv :source $MYVIMRC<CR>

" Maps leader " to wrap current word in quotations
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel





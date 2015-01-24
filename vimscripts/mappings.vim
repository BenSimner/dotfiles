""""""""""""""""""""""""""""""
"" Mappings File
""""""""""""""""""""""""""""""

"" this file contains all mappings for my vim configuration
"" this file only contains standard vim mappings, it deos not
"" contain any plugin-specific mappings

" set <leader> to be the my preferred key
let mapleader=" "
let g:mapleader=" "

""""""""""""""""""""""""""""""
"" File Navigation
""

" maps f to search and Ctrl-F to backwards search
nnoremap f /
nnoremap <C-f> ?

" Control-R replaces current search string
nnoremap <C-r> :%s///g<Left><Left>

" Maps Shift-Q to jump to next and re-do
" using :normal <stuff><CR> allows a count
" to be used with the mapping
" see: http://vimcasts.org/episodes/creating-mappings-that-accept-a-count/
nnoremap Q :normal n.<CR>

" Maps go-to-line-beginning to go to the first non-whitespace character
" good for Python usage where strict indents are required.
noremap 0 ^

" Map Arrow Keys to resizing splits
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>

" Remap jump to line
" i.e. 50' will jump to line 50
" and centre on that line
noremap ' Gzz
""""""""""""""""""""""""""""""
"" Split and Tab Navigation
"" See: http://blog.chrisbe.st/articles/coding/two-years-of-vim
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
inoremap <C-n> <Esc>:tabnext<CR>i

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
nnoremap <C-q> :q<CR>

""""""""""""""""""""""""""""""
"" File Operations
""

" Map Control-S to saving the file
" as in every other program
nnoremap <c-s> <ESC>:wa<CR>

" leader sv sources the .vimrc file
noremap <leader>sv :source $MYVIMRC<CR>

" Maps leader " to wrap current word in quotations
" (test)
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

""""""""""""""""""""""""""""""
"" Leader Mappings
""

" Swap semi-colon and colon characters around
" since : is used far more than ;
" (what does ; even do?)
nnoremap ; :
nnoremap : ;

" Tabularise
nnoremap <leader>tt :Tab /
nnoremap <leader>te :Tab /=<CR>
nnoremap <leader>tv :Tab /¦<CR>
nnoremap <leader>tp :Tab /\|<CR>
nnoremap <leader>tc :Tab /,<CR>

" shortcut to exit myvimrc
nnoremap <leader>ev :vspl $MYVIMRC<CR>

" Map leader ll and ss to load and save __global__ session
nnoremap <leader>ll :LoadSession __global__<CR>
nnoremap <leader>ss :SaveSession __global__<CR>

" Map leader lp to load the previous vim state
nnoremap <leader>lp :LoadSession previous<CR>

inoremap <expr>  <C-K>   BDG_GetDigraph()





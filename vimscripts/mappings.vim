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
" good for Python usage where strict indents are required.
noremap 0 ^

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Remap jump to line
" i.e. 50g will jump to line 50
" and centre on that line
noremap m Gzz


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
nnoremap <c-s> <ESC>:w<CR>

noremap <leader>sv :source $MYVIMRC<CR>

" Maps leader " to wrap current word in quotations
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

""""""""""""""""""""""""""""""
"" Leader Mappings
""

nnoremap ; :
nnoremap : ;

" Swap visual and block visual mode mappings about.
nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

" Tabularise
nnoremap <leader>tt :Tab /
nnoremap <leader>te :Tab /=<CR>
nnoremap <leader>tv :Tab /¦<CR>
nnoremap <leader>t, :Tab /,<CR>

nnoremap <leader>ev edit ~/.vim/vimrc

" Show syntax highlighting groups for word under cursor
" from http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc





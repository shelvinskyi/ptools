" --------------
" => some basics
" --------------
execute pathogen#infect()
execute pathogen#helptags()

let mapleader="\\"
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8


" ----------
" => visuals
" ----------
colorscheme peaksea
set number
" set relativenumber
set so=7

set expandtab
set shiftwidth=4
set tabstop=4

set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ Line:\ %l\ \ Column:\ %c

set splitbelow
set splitright

set wildmenu
set wildignore=*.o,*~,*.pyc

set ignorecase
set hlsearch
set incsearch


" --------
" => utils
" --------
map 0 ^
set history=500

" quick save
nmap <leader>w :w!<cr>
" sudo save
command W w !sudo tee % > /dev/null

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"set foldcolumn=1
set clipboard=unnamed

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" python identation PEP 8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" ---------
" => slimux
" ---------
map <leader>s :SlimuxREPLSendLine<CR>
vmap <leader>s :SlimuxREPLSendSelection<CR>
map <leader>b :SlimuxREPLSendBuffer<CR>
map <leader>a :SlimuxShellLast<CR>
map <leader>k :SlimuxSendKeysLast<CR>

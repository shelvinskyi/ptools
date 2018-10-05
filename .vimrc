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

nmap <leader>w :w!<cr>
set history=500
command W w !sudo tee % > /dev/null

"set foldcolumn=1


" ---------
" => slimux
" ---------
map <leader>s :SlimuxREPLSendLine<CR>
vmap <leader>s :SlimuxREPLSendSelection<CR>
map <leader>b :SlimuxREPLSendBuffer<CR>
map <leader>a :SlimuxShellLast<CR>
map <leader>k :SlimuxSendKeysLast<CR>

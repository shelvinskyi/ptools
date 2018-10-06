" => basics
" ---------

    execute pathogen#infect()
    execute pathogen#helptags()

    let mapleader="\\"
    set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8

" => visuals
" ----------

    set t_Co=256
    colorscheme peaksea
    set background=dark
    " highlight Normal ctermfg=black ctermbg=black
    " set number
    " set relativenumber
    set so=7

    set expandtab
    set shiftwidth=4
    set tabstop=4

    set laststatus=2

    set splitbelow
    set splitright

    set wildmenu

    set ignorecase
    set hlsearch
    set incsearch

    set statusline=%#LineNr#\ %=\ %F%m%r%h\ %w\ %l:%c\ %L

    " Add a bit extra margin to the left
    set foldcolumn=1

    set noeb vb t_vb=

" => utils
" --------

    map 0 ^
    set history=500
    " spell checker
    map <leader>ss :setlocal spell!<cr>

    " bash bindings
    cnoremap <C-A>		<Home>
    cnoremap <C-E>		<End>

    " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
    map <space> /
    map <m-space> ?

    " quick save
    nmap <leader>w :w!<cr>

    " configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " split navigations
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    " system buffer
    set clipboard=unnamed

" => plugins
" ----------

    " jedi
   
    

    " slimux
    map <leader>r :SlimuxREPLSendLine<cr>j
    vmap <leader>r :SlimuxREPLSendSelection<cr>j

    " bufexplorer
    let g:bufExplorerDefaultHelp=0
    let g:bufExplorerShowRelativePath=1
    map <leader>f \be

    " goyo
    map <leader>z :Goyo<cr>

    " NERDTree
    map <leader>nn :NERDTreeToggle<cr>
   

    " ale
    map <leader>xx :ALEEnable<cr>
    map <leader>x :ALEDisable<cr>

" => filetypes
" ------------

    " python whitespaces
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

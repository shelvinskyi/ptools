" => basics
" ---------

    " set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8

    " mouse support
    set mouse=nvi
    nmap , \

" => visuals
" ----------

    set t_Co=256

    set background=dark

    set so=7
    set number relativenumber
    map <leader>n :set number! relativenumber!<cr>
    set statusline=%#LineNr#\ %=\ %F%m%r%h\ %w\ %l:%c\ %L
    highlight LineNr ctermfg=green

    set expandtab
    set shiftwidth=4
    set tabstop=4

    set laststatus=2

    set splitbelow
    set splitright

    set ignorecase
    set hlsearch
    set incsearch

    " turn off error sound
    set noeb vb t_vb=

" => utils
" --------

    map 0 ^
    set history=1000
    " spell checker
    map <leader>x :setlocal spell!<cr>

    " bash bindings
    cnoremap <C-A>		<Home>
    cnoremap <C-E>		<End>

    " quick save
    nmap <leader>w :w!<cr>

    " configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " buffer fun
    nnoremap <leader>1 :1b<cr>
    nnoremap <leader>2 :2b<cr>
    nnoremap <leader>3 :3b<cr>
    nnoremap <leader>4 :4b<cr>
    nnoremap <leader>5 :5b<cr>

    " system clipboard
    set clipboard=unnamed

" => plugins
" ----------
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'preservim/nerdtree'
        Plug 'junegunn/goyo.vim'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-fugitive'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'dense-analysis/ale'
  
        Plug 'morhetz/gruvbox'

        " Plug 'git@github.com:kien/ctrlp.vim.git'
        " Plug 'esamattis/slimux'
    call plug#end()

    " coc
    set hidden
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

    " use <c-space>for trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    hi CocErrorFloat guifg=#000000 guibg=#000000
    hi CocWarningFloat guifg=#000000 guibg=#000000
    hi CocInfoFloat guifg=#000000 guibg=#000000

    " goyo
    map <leader>z :Goyo<cr>
    let g:goyo_width=90
    let g:goyo_height="85%"
    function! s:goyo_leave()
        set background=dark
    endfunction
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

    " ale
    let g:ale_linters_explicit=1
    let g:ale_linters={'python': ['flake8','mypy']}
    let g:ale_set_highlights=0
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign

    " fzf
    nnoremap <silent> <C-p> :Files<CR>
    nnoremap <leader> f :Buf<CR>

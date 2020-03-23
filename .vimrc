" => basics
" ---------

    execute pathogen#infect()
    execute pathogen#helptags()

    set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8

" => visuals
" ----------

    set t_Co=256

    set background=dark
    colorscheme peaksea_light

    set so=7
    map <leader>n :set number! relativenumber!<cr>
    set statusline=%#LineNr#\ %=\ %F%m%r%h\ %w\ %l:%c\ %L

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

    " turn off error sound
    set noeb vb t_vb=

" => utils
" --------

    map 0 ^
    set history=500
    map <leader>q :bdelete<cr>
    " spell checker
    map <leader>s :setlocal spell!<cr>

    " bash bindings
    cnoremap <C-A>		<Home>
    cnoremap <C-E>		<End>

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

    " buffer fun
    nnoremap <leader>] :bn<cr>
    nnoremap <leader>[ :bp<cr>

    nnoremap <leader>1 :1b<cr>
    nnoremap <leader>2 :2b<cr>
    nnoremap <leader>3 :3b<cr>
    nnoremap <leader>4 :4b<cr>
    nnoremap <leader>5 :5b<cr>

    " system clipboard
    set clipboard=unnamed

    " pytest binding
    nnoremap <leader>t :w \| !pytest %<cr>

" => plugins
" ----------

    " jedi
    let g:jedi#auto_vim_configuration=0
    let g:jedi#popup_on_dot=0
    let g:jedi#show_call_signatures="0"
    let g:jedi#goto_assignments_command="<leader>a"
    let g:jedi#goto_definitions_command="<leader>d"
    let g:jedi#rename_command = ""
    let g:jedi#documentation_command = "<leader>s"
    let g:jedi#usages_command = "<leader>e"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#popup_select_first=0
    set completeopt=menuone,longest

    " slimux
    map <leader>r :SlimuxREPLSendLine<cr>j
    vmap <leader>r :SlimuxREPLSendLine<cr>j

    " bufexplorer
    let g:bufExplorerDefaultHelp=0
    let g:bufExplorerShowRelativePath=1
    map <leader>f \be

    " goyo
    map <leader>z :Goyo<cr>
    let g:goyo_width=100
    let g:goyo_height="90%"

    " NERDTree
    map <leader>b :NERDTreeToggle<cr>

    " ale
    map <leader>x :ALEToggle<cr>
    let g:ale_linters_explicit=1
    let g:ale_linters={
        \ 'python': ['autopep8','flake8','mypy']}
    let g:ale_set_highlights=0
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign

    " ctrlp
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|__pycache__)$',
      \ 'file': '\v\.(exe|so|dll|html|css|pyc)$',
      \ }

    " argwrap
    nnoremap <leader>o :ArgWrap<CR>

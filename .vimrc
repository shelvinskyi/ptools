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
    colorscheme peaksea
    set background=dark
    set so=7
    map <leader>x :set invnumber<cr>
    set statusline=%#LineNr#\ %=\ %F%m%r%h\ %w\ %l:%c\ %L

    " highlight Normal ctermfg=black ctermbg=black

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

    " add a bit extra margin to the left
    set foldcolumn=1

    " turn off error sound
    set noeb vb t_vb=

    " show bad whitespaces
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :match ExtraWhitespace /\s\+$\| \+\ze\t/

" => utils
" --------

    map 0 ^
    set history=500
    " spell checker
    map <leader>ss :setlocal spell!<cr>

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

    " system buffer
    set clipboard=unnamed

" => plugins
" ----------

    " jedi
    let g:jedi#auto_vim_configuration=0
    let g:jedi#popup_on_dot=0
    let g:jedi#show_call_signatures="0"
    let g:jedi#goto_assignments_command="<leader>a"
    let g:jedi#goto_definitions_command="<leader>d"
    let g:jedi#rename_command = ""
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#popup_select_first=0
    set completeopt=noselect,menuone

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
    map <leader>xx :ALEToggle<cr>
    let g:ale_linters_explicit=1
    let g:ale_linters={
        \ 'python': ['autopep8','flake8','mypy']}
    let g:ale_set_highlights=0
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign

" => filetypes
" ------------

    " python


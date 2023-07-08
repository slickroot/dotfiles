" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

set encoding=utf8
filetype plugin indent on

" colors
syntax enable
colorscheme lena

" ui
set noshowmode
set noshowcmd
set wildmenu
set wildmode=longest:full,full

" behaviour
set backspace=2
set wrap
set linebreak
set viminfo=
set nobackup
set noswapfile
set clipboard=unnamedplus

" indentation
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set noexpandtab

" search
set nohlsearch
set ignorecase
set smartcase

" statusline
set laststatus=1

" leader
let mapleader = ","

" line numbers
set number relativenumber
highlight LineNr ctermfg=DarkGrey

" Scrolling
nnoremap J 5<c-e>
nnoremap K 5<c-y>

" Close current buffer
nnoremap <Leader>c :bd<CR>

" Marouane magic
source ~/.vim/marogic.vim
source ~/.vim/functions.vim

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
set tabstop=4
set shiftwidth=4
set expandtab

" search
set nohlsearch
set ignorecase
set smartcase

" statusline
set laststatus=1

" leader
let mapleader = ","

" line numbers
set relativenumber
highlight LineNr ctermfg=DarkGrey

" Scrolling
nnoremap J 2<c-e>
nnoremap K 2<c-y>

" Close current buffer
nnoremap <Leader>c :bd<CR>

" Marouane magic
source ~/.vim/marogic.vim

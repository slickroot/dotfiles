set nocompatible

set encoding=utf8
filetype plugin indent on

" colors
syntax off
colorscheme kanagawa

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

" indentation
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
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
set number relativenumber
highlight LineNr ctermfg=DarkGrey

" Scrolling
nnoremap J 5<c-e>
nnoremap K 5<c-y>

" Escape
inoremap jk <ESC>

" Close current buffer
nnoremap <Leader>c :bd<CR>

" Underline error
highlight CocErrorHighlight guisp=#FE5F55 gui=undercurl

" Marouane magic
" source ~/.vim/marogic.vim
" source ~/.vim/functions.vim
lua require('plugins')
lua require('marogic')

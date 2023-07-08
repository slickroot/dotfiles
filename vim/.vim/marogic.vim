" ALE
nmap <Leader>a :ALEFix<CR>

" Esc
imap jk <Esc>

" Black
nmap <Leader>b :Black<CR>
" autocmd BufWritePre *.py execute ':Black'

" limelight
let g:limelight_conceal_guifg = 'Gray'
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_default_coefficient = 0.1

" Goyo
nmap <Leader>g :Goyo<CR>
function! s:goyo_enter()
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Autocommands
" special treat, save xresources colors to kitty colors
autocmd BufWritePost ~/.Xresources.d/colors :silent exec "!xtokitty"

" map fuzzy search
command! LS call fzf#run({ 'source': 'git ls-files --others --cached --exclude-standard', 'options': '--preview "bat --color=always {}"', 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.8 } })
nnoremap <Leader>o :LS<CR>

" Vue
let g:vim_vue_plugin_load_full_syntax = 1

" fzf
set rtp+=~/.fzf

" coc
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" JSX and TSX
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

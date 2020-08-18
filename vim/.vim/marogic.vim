" limelight
let g:limelight_conceal_guifg = 'DarkBlue'
let g:limelight_conceal_ctermfg = 'DarkBlue'
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

" Vim hybrid
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid

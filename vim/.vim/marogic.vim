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

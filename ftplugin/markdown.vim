" configurações para vim-pandoc
set nofoldenable
let g:pandoc#formatting#mode = 'h'
let g:pandoc#formatting#textwidth = 80
let g:pandoc#spell#enabled = 0

" " bold
" vmap <Leader>bb c****<Esc><Left>gP<Right>
" nmap <Leader>bb ciw****<Esc><Left>gP<Right>
" emphasize
vmap <Leader>ii c**<Esc>gP
nmap <Leader>ii ysiw*E
" comment selection
vmap <Leader>C c<!----><Esc>2<Left>gP<Right>

" Indentação em arquivos TeX
au FileType context,initex,plaintex,tex setlocal sw=2 sts=2 ts=2

" View
au BufWinLeave *.tex mkview
au BufWinEnter *.tex silent loadview

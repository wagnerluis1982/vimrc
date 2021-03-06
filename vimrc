" Modo Vim ao invés do modo Vi (única forma eficiente de usar o Vim)
set nocompatible

" Opções copiadas do vimrc padrão do Ubuntu
source ~/.vim/ubuntu.vim

" Colorscheme
au GUIEnter * colorscheme desert

" Pathogen
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" NOTE: Copiada de debian.vim
set backspace=indent,eol,start

" Indentation
set autoindent

" Opções de tabulação
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Opções de pequisa e de padrões
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch

" Não faz backup, preserva o inode
set nobackup
set nowritebackup

" Histórico grande
set history=2000

" Parâmetros do split window
set splitright
set splitbelow

" NERDTree Explorer
let g:nerdtree_tabs_open_on_gui_startup = 0
au VimEnter * call add(NERDTreeIgnore, '\.pyc$')

" Remove espaços em branco à direita
let g:RightTrimIgnore = ['gitcommit', 'diff', 'fstab', 'vim']
function! RightTrim()
    if !(&binary) && index(g:RightTrimIgnore, &filetype) == -1
        let [line, column] = [line("."), virtcol(".")]
        silent! %s/\s\+$//ge
        execute line printf("normal %d|", column)
    endif
endfunction
au BufWritePre * call RightTrim()

" TODO: Tentar substituir para só salvar antes do :make
" Salva automaticamente antes de comandos tipo :next e :make
set autowrite

" Permite configurações para cada arquivo
set modeline

" Define o local da quebra de linha para 80, se não foi definido previamente
au BufNewFile,BufRead * if empty(&textwidth) | set textwidth=80 | endif

" Permite alternar o modo de exibir local da quebra de linha
function ToggleColorColumn()
    if !g:ColorColumn
        let g:ColorColumn = 1
    else
        let g:ColorColumn = 0
    endif
endfunction

" Inicia no modo exibir linha
let g:ColorColumn = 0
call ToggleColorColumn()

" Função que marca o local da quebra de linha
let g:FileTypeSkip = ['help', 'cucumber', 'netrw']
function SetColorColumn()
    if index(g:FileTypeSkip, &filetype) != -1
        setlocal colorcolumn=
    elseif g:ColorColumn
        set colorcolumn=+1
    else
        set colorcolumn=
    endif
endfunction

" Faz exibir o local da quebra de linha e auto-exibe a cada buffer visitado
call SetColorColumn()
au BufEnter * call SetColorColumn()

" Verificação Ortográfica definida para Português
set nospell spl=pt

" Entra no diretório do arquivo lido
"au BufRead * lcd %:h

" Atalhos
" Ctrl+Tab (Abre uma nova aba)
    nmap <C-Tab> :tabnew<cr>
" Ctrl+\ (Limpa destaque de pesquisa)
    nmap <C-\> :let @/ = ''<cr>
" F2 (Exibe explorer)
    nmap <F2> :NERDTreeTabsToggle<cr>
" Ctrl+Up (Rola a tela para cima)
    nmap <C-Up> <C-y>
    imap <C-Up> <C-o><C-y>
" Ctrl+Down (Rola a tela para baixo)
    nmap <C-Down> <C-e>
    imap <C-Down> <C-o><C-e>
" Ctrl+S (Salvar)
    nmap <C-s> :w<cr>
    imap <C-s> <C-o>:w<cr>

" Alt+[ (Ortografia Anterior)
    nmap <A-[> [s
    imap <A-[> <C-o>[s
" Alt+] (Ortografia Próxima)
    nmap <A-]> ]s
    imap <A-]> <C-o>]s
" Alt+= (Correção Ortográfica)
    nmap <A-=> z=
" Alt+. (Ignorar Palavra)
    nmap <A-.> zG
" Alt+, (Não Ignorar Palavra)
    nmap <A-,> zW

" Ctrl+Shift+Insert (Colar do clipboard)
    imap <C-S-Insert> <C-r>+
" Shift+Insert (Colar do clipboard bem indentado)
    imap <S-Insert> <C-o>"+P

" Configurações de https://wiki.documentfoundation.org/Development/Vim
"source ~/.vim/lodev.vim

" Outras configurações específicas
source ~/.vim/texrc.vim

" PyMode Lint
let g:pymode_lint_ignore = "E116,E128,E302,E701"

" PyMode Rope
let g:pymode_rope_completion = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0

function! NetReadFixup(method,line1,line2)
    let g:pymode_rope = 0
endfunction

" TableMode compatível com Pandoc
function TogglePandocTable()
    if g:table_mode_corner_corner == '|'
        let g:table_mode_corner_corner = '+'
        let g:table_mode_header_fillchar = '='
    else
        let g:table_mode_corner_corner = '|'
        let g:table_mode_header_fillchar = '-'
    endif
endfunction

" Removendo o menu, barra de ferramentas e barra lateral e inferior
set guioptions-=T guioptions-=m guioptions-=r guioptions-=R guioptions-=l guioptions-=L guioptions-=b

" Soft word wrap
set wrap linebreak nolist

" Ir para linha anterior/próxima com as setas <Left>/<Right> no início/final
set whichwrap=b,s,<,>,[,]

" Símbolo para indicar wrap
set showbreak=↳

" Full Screen support [superuser.com/questions/264693/how-can-i-open-gvim-in-full-screen-mode-in-gnome]
let g:FullScreen = 0
function ToggleFullScreen()
    if !g:FullScreen
        let g:FullScreen = 1
    else
        let g:FullScreen = 0
    endif
    call ToggleColorColumn()
    call SetColorColumn()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endfunction
map <silent> <F11> :call ToggleFullScreen()<CR>

" LanguageTool
let g:languagetool_jar='$HOME/Programs/LanguageTool-3.2/languagetool-commandline.jar'

" CriticMarkup question
function CriticMarkupQuestion()
    let choice = confirm("CriticMarkup", "&Accept\n&Reject", 1, "Q")
    if choice == 1
        Critic accept
    elseif choice == 2
        Critic reject
    endif
endfunction
nmap <Leader>c :call CriticMarkupQuestion()<cr>

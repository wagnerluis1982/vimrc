" Build the current module using :make
function GetModuleRoot()
    let mods = ":p:h"
    let dir = expand("%" . mods)
    while !filereadable(dir . "/Makefile") && !filereadable(dir . "/prj/build.lst") && dir != "/"
        let mods .= ":h"
        let dir = expand( "%" . mods )
    endwhile
    return dir
endfunction

if $SOLARENV != ""
    " Define the make tool
    let module = GetModuleRoot()
    if filereadable( module . "/Makefile" )
        set makeprg=make\ -sr\ -j10\ debug=t
    else
        set makeprg=build.pl\ debug=true\ -P10\ --\ -P10
    endif
endif


" Get the issue number under the cursor. An issue number is containing
" digits, lating letters and #. The # characters are removed from the result.
"
" Code heavily inspired from the words_tools.vim of Luc Hermitte
" http://hermitte.free.fr/vim/ressources/dollar_VIM/plugin/words_tools_vim.html
function! GetCurrentIssueText()
  let c = col ('.')-1
  let l = line('.')
  let ll = getline(l)
  let ll1 = strpart(ll,0,c)
  let ll1 = matchstr(ll1,'[0-9#a-zA-Z]*$')
  if strlen(ll1) == 0
    return ll1
  else
    let ll2 = strpart(ll,c,strlen(ll)-c+1)
    let ll2 = strpart(ll2,0,match(ll2,'$\|[^0-9#a-zA-Z]'))
    let text = ll1.ll2

    let text = substitute( text, "#", "", "g" )
    return text
  endif
endfunction

" Open IssueZilla / Bugzilla for the selected issue
function! OpenIssue( )

    let s:browser = "xdg-open"

    let s:issueText = GetCurrentIssueText( )
    let s:urlTemplate = ""
    let s:pattern = "\\(\\a\\+\\)\\(\\d\\+\\)"

    let s:prefix = substitute( s:issueText, s:pattern, "\\1", "" )
    let s:id = substitute( s:issueText, s:pattern, "\\2", "" )

    if s:prefix == "i"
        let s:urlTemplate = "https://issues.apache.org/ooo/show_bug.cgi?id=%"
    elseif s:prefix == "n"
        let s:urlTemplate = "https://bugzilla.novell.com/show_bug.cgi?id=%"
    elseif s:prefix == "fdo"
        let s:urlTemplate = "https://bugs.freedesktop.org/show_bug.cgi?id=%"
    elseif s:prefix == "bnc"
        let s:urlTemplate = "https://bugzilla.novell.com/show_bug.cgi?id=%"
    endif

    if s:urlTemplate != ""
        let s:url = substitute( s:urlTemplate, "%", s:id, "g" )
        let s:cmd = "silent !" . s:browser . " " . s:url . "&"
        execute s:cmd
    endif
endfunction
map <silent> <C-i> :call OpenIssue()<CR><C-l>


" Show the current function name
function! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfunction
map f :call ShowFuncName() <CR>

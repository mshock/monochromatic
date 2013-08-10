"
" blog.vim
"
"
" collection of functions, binding, etc... to automate blog editing and make it
" easier.
"

" insert current date preceded by &mdash at the end of the current line
fu! Date()
    norm mz
    exe append(line("."), "&mdash; ".strftime("%d %B, %Y"))
    norm 'zJ
endf
nmap <leader>d :call Date()<CR>

fu! EscapeHTML()
    silent! s/</\&lt;/g
    silent! s/>/\&gt;/g
    silent! s/"/\&quot;/g
endf

" love that...
ab -- &mdash;
ab < &lt;
ab > &gt;


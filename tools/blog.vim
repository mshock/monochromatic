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

fu! EscapeHTML()
    silent! s/</\&lt;/g
    silent! s/>/\&gt;/g
    silent! s/"/\&quot;/g
endf

fu! CodeHTML(newft)
    let oldft = &ft         " remember current filetype
    let ft = a:newft        " filetype to be used
    '<,'>TOhtml             " convert the selection to HTML
    /^<pre/+1,/^<\/pre>/-1d " get the code in between <pre> tags
    bd!                     " remove the HTML temporary buffer
    norm gvp                " copy that in place of the old text
    let ft = oldft          " recall the saved filetype
endf

" love that...
ab -- &mdash;
ab </  </<C-X><C-o>

nmap <leader>d :call Date()<CR>

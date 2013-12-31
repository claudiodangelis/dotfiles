:syntax on
set tabstop=4
set shiftwidth=4
set expandtab
map <F2> <Esc> :tabp <CR>
map <F12> <Esc> :tabn <CR>
autocmd FileType html :AcpDisable

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
fun! UpdateMatch()
    if &ft !~ '^\%(html\|xml\)$'
        match OverLength /\%81v.*/
    else
        match NONE
    endif
endfun
autocmd BufEnter,BufWinEnter * call UpdateMatch()
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <a-up> :call <SID>swap_up()<CR>
noremap <silent> <a-down> :call <SID>swap_down()<CR>


:syntax on
set t_Co=256
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
colorscheme monokai
execute pathogen#infect()
highlight clear SignColumn
set cc=81
highlight ColorColumn ctermbg=0
autocmd BufWritePre * call CleanWhitespaceEmptyLines()
map <C-K> :GitGutterPrevHunk<CR>
map <C-J> :GitGutterNextHunk<CR>
set nowrap
set term=xterm-256color
let g:dart_style_guide = 1
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/dart-vim-plugin
endif
filetype plugin indent on
function CleanWhitespaceEmptyLines()
    :%s/\s\+$//e
endfunction

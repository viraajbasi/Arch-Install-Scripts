syntax on
set smartindent
set nu
set smartcase
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set noerrorbells
colorscheme desert

call plug#begin('~/.vim/plugged')
Plug 'cespare/vim-toml', { 'branch': 'main' }
call plug#end()

syntax on
filetype plugin indent on
set smartindent
set nu
set smartcase
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set noerrorbells
set termguicolors
set expandtab
colorscheme industry

call plug#begin('~/.local/share/.vim/plugged')
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'dag/vim-fish'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'Omnisharp/omnisharp-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'jiangmiao/auto-pairs'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

lua require'colorizer'.setup()

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'

set guifont=FiraCode\ Nerd\ Font:h15

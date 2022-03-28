" vimrc

set background=dark

set nocompatible
filetype off

" If vim-plug is not found, install it and every plugin
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Plugins
call plug#begin('~/.vim/plugged')
    " styling
    Plug 'ConnorHolyday/vim-snazzy'
    Plug 'itchyny/lightline.vim'
    Plug 'machakann/vim-highlightedyank'
    " utilities
    Plug 'mileszs/ack.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating' " vim-orgmode won't shut up about this missing even if it's not required
    " language highlights
    Plug 'leafgarland/typescript-vim'
    Plug 'lifepillar/pgsql.vim'
    Plug 'LnL7/vim-nix'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


syntax on
set t_Co=256
colorscheme snazzy

let g:lightline = {
\ 'colorscheme': 'snazzy',
\ }

" Show airline
set laststatus=2

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Code readability
set number
"set colorcolumn=100

set termguicolors

set noshowmode

set shortmess=I

map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/vim/addons/syntax/clang-format.py<cr>

" I'm not sure that vim-orgmode sets this...
autocmd BufNewFile,BufRead *.org set filetype=org

" fuck kalpa
" autocmd Filetype c setlocal ts=3 sw=3 sts=3 expandtab
" autocmd Filetype cpp setlocal ts=3 sw=3 sts=3 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype make setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd Filetype org setlocal ts=4 sw=4 sts=4 noexpandtab

let g:ackprg = 'ag --nogroup --nocolor --column'
" Use Ack! as default Ack command (do not jump to first result)
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" set filetypes
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact



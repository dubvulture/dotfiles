" vimrc

set background=dark

set nocompatible
filetype off

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

" do not show intro message
set shortmess+=I
" show number of matches
set shortmess-=S

" disable folding (for plugins too)
" set nofoldenable

" from coc-nvim example
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Shut the fuck up please (enable with vim < 8.2)
" let g:coc_disable_startup_warning = 1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Keyboard is fine, but resizing panes with it is a mess, enable mouse thanks
set mouse=a

" Yank/Paste from/to system clipboard automatically
set clipboard=unnamedplus

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<S-Tab>" :
      \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
    Plug 'andymass/vim-matchup'
    Plug 'preservim/nerdtree'
    Plug 'mileszs/ack.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating' " vim-orgmode won't shut up about this missing even if it's not required
    " language highlights / utilities
    Plug 'leafgarland/typescript-vim'
    Plug 'cespare/vim-toml'
    Plug 'peterhoeg/vim-qml'
    Plug 'rust-lang/rust.vim'
    Plug 'ekalinin/Dockerfile.vim'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'
    " LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on
set t_Co=256
colorscheme snazzy

let g:lightline = {
\ 'colorscheme': 'snazzy',
\ }

map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/vim/addons/syntax/clang-format.py<cr>

" rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0

" I'm not sure that vim-orgmode sets this...
autocmd BufNewFile,BufRead *.org set filetype=org

" fuck kalpa
" autocmd Filetype c setlocal ts=3 sw=3 sts=3 expandtab
" autocmd Filetype cpp setlocal ts=3 sw=3 sts=3 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype make setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd Filetype org setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab

let g:ackprg = 'ag --nogroup --nocolor --column'
" Use Ack! as default Ack command (do not jump to first result)
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" set filetypes
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" coc extensions
let g:coc_global_extensions = [
            \'coc-html',
            \'coc-css',
            \'coc-json',
            \'coc-go',
            \'coc-cmake',
            \'coc-clangd',
            \'coc-rust-analyzer',
            \]

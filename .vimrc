" vimrc

set nocompatible
filetype off

set background=dark
set termguicolors

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

" show custom characters
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" already handled by statusline
set noshowmode

" incremental search yay (show match while typing)
set incsearch

" do not show intro message
set shortmess+=I
" show number of matches
set shortmess-=S
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" reload file automatically if it was not modified by vim
set autoread

" might be useful, who knows
set history=1000

" sensible.vim says that this is useful, I want to believe
set sessionoptions-=options
set viewoptions-=options

" disable folding (for plugins too)
" set nofoldenable

" from coc-nvim example
" TextEdit might fail if hidden is not set.
set hidden

" start scrolling even if N lines are still visible, tweak me! 
set scrolloff=5

" Some servers have issues with backup files, see #649.
set nobackup
set writebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Shut the fuck up please (enable with vim < 8.2)
" let g:coc_disable_startup_warning = 1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Keyboard is fine, but resizing panes with it is a mess, enable mouse thanks
set mouse=a

" Yank/Paste from/to system clipboard automatically
set clipboard=unnamedplus

set undofile
set undodir=~/.vim/undo/

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
    Plug 'dubvulture/vim-snazzy'
    Plug 'vim-airline/vim-airline'
    Plug 'machakann/vim-highlightedyank'
    " utilities
    Plug 'andymass/vim-matchup'
    Plug 'preservim/nerdtree'
    Plug 'mileszs/ack.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating' " vim-orgmode won't shut up about this missing even if it's not required
    Plug 'junegunn/fzf'
    " language highlights / utilities
    Plug 'leafgarland/typescript-vim'
    Plug 'cespare/vim-toml'
    Plug 'peterhoeg/vim-qml'
    Plug 'rust-lang/rust.vim'
    Plug 'ekalinin/Dockerfile.vim'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on
set t_Co=256
colorscheme snazzy

" do not load airline shit integrations
let g:airline_extensions = [
    \ 'branch',
    \ 'coc',
    \ 'tabline',
\ ]
let g:airline_theme='snazzy'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" redefine since I don't want fancy arrows
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
" redefine since I don't care about the number of lines
let g:airline#extensions#coc#stl_format_err = '%C'
let g:airline#extensions#coc#stl_format_warn = '%C'
" this can only be modified in this hacky way
function! CustomAirlineAfterInit()
    let g:airline_section_z = airline#section#create(['%p%% %L:%v'])
endfunction
au User AirlineAfterInit call CustomAirlineAfterInit()
" alternatively I could configure these
" let g:airline_symbols.maxlinenr = ' '
" let g:airline_symbols.linenr = ' '
" let g:airline_symbols.colnr = ' '

map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/vim/addons/syntax/clang-format.py<cr>

" Tab shortcuts. I use shift as a modifier
noremap ,t <Esc>:enew<CR>
noremap ,T <Esc>:%bd\|e#\|bd#<CR>
noremap ,Q <Esc>:bfirst<CR>
noremap ,q <Esc>:bprevious<CR>
noremap ,e <Esc>:bnext<CR>
noremap ,E <Esc>:blast<CR>
noremap ,w <Esc><C-W>k<CR>
noremap ,a <Esc><C-W>h<CR>
noremap ,s <Esc><C-W>j<CR>
noremap ,d <Esc><C-W>l<CR>

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

" Additional matches for C++
autocmd Filetype cpp syn match cppAttrOpen /\[\[/
autocmd Filetype cpp syn match cppAttrClose /\]\]/
autocmd Filetype cpp syn match cppNsDots /\:\:/
autocmd Filetype *   syn match doxyTag /@\w\+/ containedin=.*Comment,cCommentL
autocmd Filetype cpp hi def link cppAttrOpen Structure
autocmd Filetype cpp hi def link cppAttrClose Structure
autocmd Filetype cpp hi def link cppNsDots Structure
autocmd Filetype *   hi def link doxyTag Exception

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
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

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4 } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

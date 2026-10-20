" vimrc

set nocompatible
filetype off

set background=dark
set termguicolors

" You might have to force true color when using regular vim inside tmux as the
" colorscheme can appear to be grayscale with "termguicolors" option
" enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

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

" start scrolling even if N lines are still visible, tweak me! 
set scrolloff=5

" Keyboard is fine, but resizing panes with it is a mess, enable mouse thanks
set mouse=a

" Yank/Paste from/to system clipboard automatically
let g:clipboard = 'xsel'
set clipboard+=unnamedplus

set undofile

" unneeded providers
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" Coc suggested options
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Give more space for displaying messages.
set cmdheight=2
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Show coc.nvim status, including extension installation progress
set statusline^=%{coc#status()}
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" Trigger completion with Tab and navigate the completion menu
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Plugins
call plug#begin('~/.config/nvim/plugged')
    " styling
    Plug 'dubvulture/vim-snazzy'
    Plug 'vim-airline/vim-airline'
    Plug 'machakann/vim-highlightedyank'
    Plug 'blueyed/vim-diminactive'
    " utilities
    Plug 'andymass/vim-matchup'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-commentary'
    Plug 'kshenoy/vim-signature'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " keep this as last
    Plug 'ryanoasis/vim-devicons'
    Plug 'bryanmylee/vim-colorscheme-icons'
call plug#end()


syntax on
set t_Co=256
colorscheme snazzy

" coc extensions
let g:coc_global_extensions = [
            \'coc-html',
            \'coc-css',
            \'coc-json',
            \'coc-go',
            \'coc-cmake',
            \'coc-clangd',
            \'coc-rust-analyzer',
            \'coc-sh',
            \'@yaegassy/coc-ty',
            \'@yaegassy/coc-ruff',
            \]

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

noremap ,<Space> :NERDTreeToggle<CR>

" rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0

" set filetypes
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype make setlocal ts=4 sw=4 sts=4 noexpandtab
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

let g:NERDTreeWinSize = 50

" Coc Diagnostics and code navigation
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>fmt <Plug>(coc-format)
nmap <leader>ref <Plug>(coc-refactor)

" ag/rg current word
nnoremap <silent><Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent><Leader>rg :Rg <C-R><C-W><CR>

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

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

" DimInactive custom color
hi ColorColumn ctermbg=0 guibg=#252630
let g:diminactive_use_colorcolumn = 1
let g:diminactive_enable_focus = 1

lua require('init')

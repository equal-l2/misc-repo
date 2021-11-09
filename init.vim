" unset compatible mode
if &compatible
    set nocompatible
endif

if $COLORTERM != 'truecolor'
    set notermguicolors
else
    set termguicolors
endif

set runtimepath+=$HOME/git/novelang

call plug#begin()
" colorscheme
Plug 'gruvbox-community/gruvbox'

" improvements
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}

" project integration
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-signify'

call plug#end()

" config for colorscheme
if &termguicolors
    let g:gruvbox_invert_selection=0
    let g:gruvbox_italic=1

    colorscheme gruvbox

    let g:lightline = {
    \   'colorscheme': 'gruvbox',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'cocstatus', 'readonly', 'filename', 'modified' ]
    \     ]
    \   },
    \   'component_function': {
    \     'cocstatus': 'coc#status'
    \   },
    \ }
endif

" config for latex
let g:tex_flavor='latex'
let g:tex_conceal=''

" config for netrw
let g:netrw_cygwin=0

" config for coc
set shortmess+=c

" extensions
let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-tabnine',
    \ 'coc-toml',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
\ ]

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

command! -nargs=0 CRename :call CocActionAsync('rename')
command! -nargs=0 CFormat :call CocActionAsync('format')
command! -nargs=0 CRefactor :call CocActionAsync('refactor')
command! -nargs=0 CReference :call CocActionAsync('jumpReferences')
command! -nargs=0 CSignature :call CocActionAsync('doHover')
nmap <silent> gd <Plug>(coc-definition)

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" settings for nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indentation = { enable = true},
}
EOF

" use neovim's default configuration
set autoindent                 " enable autoindent
set autoread                   " automatically re-read the file when detecting a change by others
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set complete=.,w,b,u,t         " set complete types (excludes i for performance)
set display=lastline           " ??? show the whole line even for long one
set hlsearch                   " enable highlighting match
set incsearch                  " enable incremental search
set laststatus=2               " always show status bar
set listchars=tab:>\ ,trail:-,nbsp:+"
set mouse=a                    " enable mouse for all mode
set ruler                      " show number of line and column where the cursor is
set showcmd                    " show incomplete command (e.g. show 'y' when hit y key in command mode)
set smarttab                   " enable smart tab
set tags=./tags;,tags          " set tag file location
set ttyfast                    " assume fast terminal connection
set wildmenu                   " enable wildmenu
syntax on                      " enable syntax highlighting
filetype plugin indent on      " enable filetype detection

" preference
if has('nvim')
    set inccommand=nosplit     " show result for replacing incrementally
    set pumblend=5             " make popup transparent
    " enable esc in terminal
    tnoremap <silent> <ESC> <C-\><C-n>
endif

set background=dark
set breakindent                " apply indent to wrapped line (in case of wrap)
set completeopt="menu"
set conceallevel=0             " disable concealed text
set cursorline                 " hightlight the line where cursor is
set expandtab                  " don't use tab, but use space
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1
set foldmethod=indent
set foldlevel=15
set hidden                     " open another buffer even if unsaved changes exist
set ignorecase                 " search case-insensitively (overridden by smartcase)
set lazyredraw                 " performance improvement
set list                       " show invisible character like tabs or spaces
set matchpairs+=<:>            " match brackets
set nofixeol                   " do not add new line on the end of file
set noshowmode                 " lightline shows the mode, no need to show it by vim itself
set nowrap                     " do not wrap
set number                     " show line number
set omnifunc=syntaxcomplete#Complete
set shiftwidth=4               " set indent width
set signcolumn=yes             " always show signcolumn
set smartcase                  " search case-sensitively only given uppercase
set virtualedit=block
set wildmode=longest,full      " wildmenu settings

" better line handling for wrapped lines
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

autocmd CmdwinEnter [:\/\?=] setlocal nonumber
autocmd CmdwinEnter [:\/\?=] setlocal signcolumn=no

autocmd FileType go setlocal tabstop=4
autocmd FileType kotlin setlocal shiftwidth=4

autocmd FileType css setlocal shiftwidth=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType typescript setlocal shiftwidth=2
autocmd FileType typescriptreact setlocal shiftwidth=2
autocmd FileType vue setlocal shiftwidth=2
autocmd FileType yaml setlocal shiftwidth=2

autocmd BufNewFile,BufRead *.fxml set syntax=xml
autocmd BufNewFile,BufRead *.plt set syntax=gnuplot

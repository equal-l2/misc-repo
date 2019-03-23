" unset compatible mode
if &compatible
    set nocompatible
endif

" vim-plug initialization
call plug#begin()

" Plugins
" For vim improvement
Plug 'bling/vim-bufferline'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-peekaboo'
Plug 'itchyny/lightline.vim'

" For syntax highlighting
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'hail2u/vim-css3-syntax'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'leafgarland/typescript-vim'
Plug 'aklt/plantuml-syntax'
Plug 'dag/vim-fish'

" For misc. improvement
Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'

" Trying
Plug 'vim-jp/vital.vim'
Plug 'equal-l2/vim-base64'

" finalize plugin loading
call plug#end()

" ale settings
let g:ale_linters = {
            \'c'    : ['clang'],
            \'cpp'  : ['clang'],
            \'python'  : ['flake8'],
            \'ruby' : [],
            \}
let g:ale_lint_delay=3500
let s:clang_opts = '-Weverything -Wno-padded -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-covered-switch-default'
let g:ale_c_clang_options= '-std=c11 ' . s:clang_opts
let g:ale_cpp_clang_options='-std=c++2a ' . s:clang_opts . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'

" bufferline setting
let g:bufferline_echo=0

" peekaboo setting
let g:peekaboo_window='vert bo new'

if $COLORTERM != 'truecolor'
    set notermguicolors
else
    set termguicolors
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_invert_selection=0
    let g:lightline = {
                \    'colorscheme': 'gruvbox'
                \}
end

let g:tex_flavor='latex'
let g:tex_conceal=''

" use neovim's default configuration
set autoindent                 " enable autoindent
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set display=lastline           " show the whole line even for long one
set hlsearch                   " enable highlighting match
set incsearch                  " enable incremental search
set laststatus=2               " always show status bar
set listchars=tab:>\ ,trail:-,nbsp:+"
set mouse=a                    " enable mouse for all mode
set ruler                      " show number of line and column where the cursor is
set showcmd                    " show incomplete command (e.g. show 'y' when hit y key in command mode)
set smarttab                   " enable smart tab
set tags=./tags;,tags        " set tag file location
set ttyfast                    " assume fast terminal connection
set wildmenu                   " enable wildmenu
syntax on                      " enable syntax highlighting
filetype plugin indent on      " enable filetype detection

" preference
if has('nvim')
    set inccommand=nosplit     " show result for replacing incrementally
    tnoremap <silent> <ESC> <C-\><C-n>
endif

set background=dark
set breakindent                " apply indent to wrapped line (in case of wrap)
set conceallevel=0             " disable concealed text
set cursorline                 " hightlight the line where cursor is
set expandtab                  " don't use tab, but use space
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1
set foldmethod=indent
set foldlevel=100
set hidden                     " open another buffer even if unsaved changes exist
set list                       " show invisible character like tabs or spaces
set matchpairs+=<:>            " match brackets
set nofixeol                   " do not add new line on the end of file
set nowrap                     " do not wrap
set number                     " show line number
set omnifunc=syntaxcomplete#Complete
set shiftwidth=4               " set indent width
set wildmode=list:longest,full " wildmenu settings

autocmd FileType php setlocal autoindent
autocmd FileType kotlin setlocal shiftwidth=4
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal shiftwidth=2
autocmd BufNewFile,BufRead *.fxml set syntax=xml

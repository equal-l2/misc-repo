" unset compatible mode
if &compatible
    set nocompatible
endif

if $COLORTERM != 'truecolor'
    set notermguicolors
else
    set termguicolors
endif

call plug#begin()
" colorscheme
Plug 'morhetz/gruvbox'

" improvements
Plug 'bling/vim-bufferline'
Plug 'codota/tabnine-vim'
Plug 'itchyny/lightline.vim'
Plug 'unblevable/quick-scope'
Plug 'w0rp/ale'

" project integration
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-signify'

" syntax highlighting
Plug 'aklt/plantuml-syntax'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'hail2u/vim-css3-syntax'
Plug 'pest-parser/pest.vim'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'

" for vim-plugin development
Plug 'equal-l2/vim-base64'
Plug 'vim-jp/vital.vim'

call plug#end()

" quick-scope setting
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg=bg guibg=fg
augroup END

" ale settings
let s:clang_opts = '-Weverything -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-covered-switch-default'
let g:ale_c_clang_options= '-std=c11 ' . s:clang_opts
let g:ale_cpp_clang_options='-std=c++2a ' . s:clang_opts . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'
let g:ale_java_javac_executable = 'jfxc'
let g:ale_lint_delay=3500
let g:ale_linters = {
            \'c'    : ['clang'],
            \'cpp'  : ['clang'],
            \'go'  : ['gofmt', 'golangci-lint', 'golint', 'gotype', 'govet', 'staticcheck'],
            \'python'  : ['flake8', 'bandit', 'pylint'],
            \'ruby' : [],
            \}
let g:ale_python_bandit_options = '--skip B322'
let g:ale_python_flake8_options = '--ignore=E741,E241'
let g:ale_python_pylint_options = '--disable=C0111'
let g:ale_virtualtext_cursor = 1

" config for colorscheme
if &termguicolors
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_invert_selection=0
    let g:lightline = {
                \    'colorscheme': 'gruvbox'
                \}
endif

" config for latex
let g:tex_flavor='latex'
let g:tex_conceal=''

" use neovim's default configuration
set autoindent                 " enable autoindent
set autoread                   " automatically re-read the file when detecting a change by others
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set complete=".,w,b,u,t"       " set complete types (excludes i for performance)
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
set wildmode=list:longest,full " wildmenu settings

" better line handling for wrapped lines
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

autocmd CmdwinEnter [:\/\?=] setlocal nonumber
autocmd CmdwinEnter [:\/\?=] setlocal signcolumn=no

autocmd FileType kotlin setlocal shiftwidth=4
autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType go setlocal tabstop=4
autocmd BufNewFile,BufRead *.fxml set syntax=xml

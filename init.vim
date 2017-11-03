if &compatible
  set nocompatible
endif

" plugin initialization
call plug#begin()

" Plugins
" For vim improvement
Plug 'bling/vim-bufferline'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'

" For pretty statusline
Plug 'enricobacis/vim-airline-clock'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" For syntax highlighting
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'hail2u/vim-css3-syntax'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'

" For misc. improvement
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'racer-rust/vim-racer'
Plug 'valloric/YouCompleteMe',{'do': './install.py'}
Plug 'w0rp/ale'

call plug#end()

" airline setings
if $TERM != 'linux'
  colorscheme kalisi
  let g:airline_theme='kalisi'
end

" ale settings
let g:ale_linters = {
      \'ruby' : [],
      \'cpp'  : ['clang'],
      \'c'    : ['clang'],
      \'python'  : ['flake8']
      \}
let g:ale_lint_delay=1000
let s:clang_opts = '-Weverything -Wno-padded -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-covered-switch-default'
let g:ale_c_clang_options= '-std=c11 ' . s:clang_opts
let g:ale_cpp_clang_options='-std=c++1z ' . s:clang_opts . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'

" bufferline setting
let g:bufferline_echo=0

" peekaboo setting
let g:peekaboo_window='vert bo new'

" vim-racer settings
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" vimtex settings
let g:vimtex_compiler_method='latexrun'
let g:vimtex_compiler_latexrun = {
\ 'backend' : has('nvim') ? 'nvim'
\                         : v:version >= 800 ? 'jobs' : 'process',
\ 'background' : 1,
\ 'build_dir' : '',
\ 'options' : [
\   '--verbose-cmds',
\   '--latex-cmd=xelatex',
\ ],
\}

" YouCompleteMe settings
let g:ycm_python_binary_path='python3'

let g:tex_flavor='latex'
let g:tex_conceal=''

" return to neovim-default
set autoindent                 " enable autoindent
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set display=lastline           " show the whole line even for long one
set hlsearch                   " enable highlighting match
set incsearch                  " enable incremental search
set laststatus=2               " always show status bar
set mouse=a                    " enable mouse for all mode
set ruler                      " show number of line and column where the cursor is
set showcmd                    " show incomplete command (e.g. show 'y' when hit y key in command mode)
set smarttab                   " enable smart tab
set wildmenu                   " enable wildmenu
syntax on                      " enable syntax highlighting
filetype plugin indent on      " enable filetype detection

" preference
if has('nvim')
  set inccommand=nosplit
endif

set background=dark
set breakindent                " apply indent to wrapped line (in case of wrap)
set conceallevel=0             " disable concealed text
set expandtab                  " don't use tab, but use space
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1
set foldmethod=indent
set foldlevel=100
set hidden                     " open another buffer even if unsaved changes exist
set list                       " show invisible character e.g. tabs or spaces
set nofixeol                   " do not add new line on the end of file
set nowrap                     " do not wrap
set number                     " show line number
set omnifunc=syntaxcomplete#Complete
set shiftwidth=2               " set indent width
set wildmode=list:longest,full " wildmenu settings

autocmd FileType php setlocal autoindent
autocmd FileType kotlin setlocal shiftwidth=4
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

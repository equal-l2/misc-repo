if &compatible
  set nocompatible
endif

" plugin initialization
call plug#begin()

" Plugins
" For vim improvement
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-bufferline'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'

" For pretty statusline
Plug 'enricobacis/vim-airline-clock'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" For integration
Plug 'artur-shaik/vim-javacomplete2'
Plug 'cespare/vim-toml'
Plug 'hail2u/vim-css3-syntax'
Plug 'jreybert/vimagit'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'valloric/YouCompleteMe',{'do': './install.py --clang-completer'}
Plug 'w0rp/ale'

call plug#end()

" airline setings
if $TERM != 'linux'
  let g:airline_powerline_fonts=1
  colorscheme kalisi
  let g:airline_theme='kalisi'
end

" ale settings
let g:ale_linters = {
      \'ruby' : [],
      \'c'    : ['clang','cppcheck'],
      \'cpp'  : ['clang','cppcheck']
      \}
let g:ale_lint_delay=1000
let g:ale_c_cppcheck_options='--enable=all'
let g:ale_cpp_cppcheck_options='--enable=all'
let s:clang_opt = '-Weverything -Wno-padded -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-covered-switch-default'
let g:ale_c_clang_options= '-std=c11 ' . s:clang_opt
let g:ale_cpp_clang_options='-std=c++1z ' . s:clang_opt . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'

" bufferline setting
let g:bufferline_echo=0

" peekaboo setting
let g:peekaboo_window='vert bo new'

" vim-racer settings
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" vimtex settings
let g:vimtex_enabled=1
let g:vimtex_compiler_method='latexrun'
let g:vimtex_compiler_latexrun = {
      \ 'backend' : 'nvim',
      \ 'background' : 1,
      \ 'build_dir' : '',
      \ 'options' : [
      \   '--verbose-cmds',
      \   '--latex-cmd="xelatex"',
      \   '--latex-args="-synctex=1"',
      \ ],
      \}

" YouCompleteMe settings
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_python_binary_path='python3'

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:tex_flavor='latex'

" return to neovim-default
set autoindent                 " enable autoindent
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set display=lastline           " show whole line even for long one
set hlsearch                   " enable highlighting matchf
set incsearch                  " enable incremental search
set laststatus=2               " always show status bar
set mouse=a                    " enable mouse for all mode
set ruler                      " show line and column where the cursor is
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
set expandtab                  " don't use tab, but space
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1
set hidden                     " open another buffer even if unsaved changes exist
set list                       " show invisible character e.g. tabs or spaces
set nofixeol                   " do not add new line on the end of file
set nowrap                     " do not wrap
set number                     " show line number
set omnifunc=syntaxcomplete#Complete
set shiftwidth=2               " set indent width
set tabstop=2                  " set tab width
set wildmode=list:longest,full " wildmenu settings
autocmd FileType java setlocal omnifunc=javacomplete#Complete

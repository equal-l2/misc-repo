if &compatible
  set nocompatible
endif

" plugin initialization
call plug#begin()

Plug 'Yggdroot/indentLine'
Plug 'bling/vim-bufferline'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'hail2u/vim-css3-syntax'
Plug 'haya14busa/incsearch.vim'
Plug 'jreybert/vimagit'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'rust-lang/rust.vim'
Plug 'valloric/YouCompleteMe',{'do': './install.py --racer-completer --clang-completer'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

call plug#end()

" plugin setings
if $TERM != 'linux'
  let g:airline_powerline_fonts=1
  colorscheme kalisi
  let g:airline_theme='kalisi'
end

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

let g:bufferline_echo=0

let g:peekaboo_window='vert bo new'

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

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
set hidden                     " open another buffer even if unsaved changes exist
set list                       " show invisible character e.g. tabs or spaces
set nofixeol                   " do not add new line on the end of file
set nowrap                     " do not wrap
set number                     " show line number
set shiftwidth=2               " set indent width
set tabstop=2                  " set tab width
set wildmode=list:longest,full " wildmenu settings
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1

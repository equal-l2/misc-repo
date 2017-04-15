try
  " plugin initialization
  call plug#begin('~/.config/nvim/plugged')

  Plug 'Yggdroot/indentLine'
  Plug 'bling/vim-bufferline'
  Plug 'godlygeek/tabular'
  Plug 'haya14busa/incsearch.vim'
  Plug 'freeo/vim-kalisi'
  Plug 'majutsushi/tagbar'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'rust-lang/rust.vim'
  Plug 'w0rp/ale'

  call plug#end()

  " plugin setings
  if $TERM != 'linux'
    let g:airline_powerline_fonts=1
    colorscheme kalisi
    let g:airline_theme='kalisi'
  end
  let g:bufferline_echo=0

  let g:ale_linters = {
    \'ruby' : [],
    \'c'    : ['clang','cppcheck'],
    \'cpp'  : ['clang','cppcheck']
  \}
  let g:ale_lint_delay=1000
  let g:ale_c_cppcheck_options='--enable=all'
  let g:ale_cpp_cppcheck_options='--enable=all'
  let s:clang_opt = '-Weverything -Wno-padded -Wno-missing-prototypes -Wno-missing-variable-declarations'
  let g:ale_c_clang_options= '-std=c11 ' . s:clang_opt
  let g:ale_cpp_clang_options='-std=c++1z ' . s:clang_opt . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endtry

" return to neovim-default
set autoindent                 " enable autoindent
set backspace=indent,eol,start " set backspace behavior
set display=lastline           " show long line all
set hlsearch                   " enable highlighting matchf
set incsearch                  " enable incremental search
set laststatus=2               " always show status bar
set mouse=a                    " enable mouse for all mode
set smarttab                   " enable smart tab
set wildmenu                   " enable wildmenu
syntax on                          " enable syntax highlighting
filetype plugin indent on      " enable filetype detection

" preference
if has('nvim')
  set inccommand=nosplit
en

set background=dark
set breakindent                " apply indent to wrapped line (in case of wrap)
set conceallevel=0             " disable concealed text
set expandtab                  " don't use tab, but space
set hidden                     " open another buffer even if unsaved changes exist
set list                       " show invisible character e.g. tabs or spaces
set nowrap                     " don't wrap
set number                     " show line number
set ruler                      " show where line and column cursor is
set showcmd                    " show incomplete command (e.g. show 'y' when hit y key in command mode)
set shiftwidth=2               " set indent width
set tabstop=2                  " set tab width
set wildmode=list:longest,full " wildmenu settings
set nofixeol                   " don't add new line on the end of file

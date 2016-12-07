try
  " plugin initialization
  call plug#begin('~/.config/nvim/plugged')

  Plug 'vim-airline/vim-airline'
  Plug 'neomake/neomake'
  Plug 'tpope/vim-fugitive'
  Plug 'majutsushi/tagbar'
  Plug 'bling/vim-bufferline'
  Plug 'Yggdroot/indentLine'
  Plug 'easymotion/vim-easymotion'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'haya14busa/incsearch.vim'

  call plug#end()

  " plugin setings
  if $TERM != 'linux'
    let g:airline_powerline_fonts=1
  en
  let g:neomake_c_enable_markers = ['clang']
  let g:neomake_c_clang_args = ["-fsyntax-only", "-Weverything"]
  let g:neomake_cpp_enable_markers = ['clang']
  let g:neomake_cpp_clang_args = ["-fsyntax-only", "-std=c++1z", "-Weverything", "-Wno-padded", "-Wno-c++98-compat"]
  au! BufReadPost,BufWritePost *.c Neomake
  au! BufReadPost,BufWritePost *.cpp Neomake
  au VimEnter * RainbowParentheses

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endt

if has('nvim')
  se icm=nosplit
en

se list                  " show invisible character e.g. tabs or spaces
se et                    " don't use tab, but space
se sw=2                  " set indent width
se ts=2                  " set tab width
se nu                    " show line number
se ru                    " show where line and column cursor is
se wim=list:longest,full " wildmenu settings
se cole=0                " disable concealed text
se bri                   " apply indent to wrapped line
se hid                   " open another buffer even if unsaved changes are

if $TERM != 'linux'
  colorscheme pablo
endif

" return to neovim-default
se wmnu                   " enable wildmenu
se ai                     " enable autoindent
se hls                    " enable highlighting matchf
se is                     " enable incremental search
se ls=2                   " always show status bar
se sta                    " enable smart tab
se mouse=a                " enable mouse for all mode
sy on                     " enable syntax highlighting
filetype plugin indent on " enable filetype detection

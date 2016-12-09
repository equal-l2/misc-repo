try
  " plugin initialization
  call plug#begin('~/.config/nvim/plugged')

  Plug 'Yggdroot/indentLine'
  Plug 'bling/vim-bufferline'
  Plug 'easymotion/vim-easymotion'
  Plug 'godlygeek/tabular'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'majutsushi/tagbar'
  Plug 'neomake/neomake'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

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

se bri                   " apply indent to wrapped line (in case of wrap)
se cole=0                " disable concealed text
se et                    " don't use tab, but space
se hid                   " open another buffer even if unsaved changes exist
se list                  " show invisible character e.g. tabs or spaces
se nowrap                " don't wrap
se nu                    " show line number
se ru                    " show where line and column cursor is
se sc                    " show incomplete command (e.g. show 'y' when hit y key in command mode)
se sw=2                  " set indent width
se ts=2                  " set tab width
se wim=list:longest,full " wildmenu settings

if $TERM != 'linux'
  set tgc
  colorscheme solarized8_dark
  let g:airline_theme='solarized'
endif

" return to neovim-default
se ai                     " enable autoindent
se bs=indent,eol,start    " set backspace behavior
se dy=lastline            " show long line all
se hls                    " enable highlighting matchf
se is                     " enable incremental search
se ls=2                   " always show status bar
se mouse=a                " enable mouse for all mode
se sta                    " enable smart tab
se wmnu                   " enable wildmenu
sy on                     " enable syntax highlighting
filetype plugin indent on " enable filetype detection

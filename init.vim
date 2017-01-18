try
  " plugin initialization
  call plug#begin('~/.config/nvim/plugged')

  Plug 'Yggdroot/indentLine'
  Plug 'bling/vim-bufferline'
  Plug 'godlygeek/tabular'
  Plug 'haya14busa/incsearch.vim'
  Plug 'freeo/vim-kalisi'
  Plug 'majutsushi/tagbar'
  Plug 'neomake/neomake'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'rust-lang/rust.vim'
  Plug 'cespare/vim-toml'

  call plug#end()

  " plugin setings
  if $TERM != 'linux'
    let g:airline_powerline_fonts=1
    colorscheme kalisi
    let g:airline_theme='kalisi'
  en
  let g:bufferline_echo=0

  let g:neomake_c_clang_args = ['-fsyntax-only', '-std=c11', '-Weverything', '-Wno-padded','-Wno-missing-prototypes']
  let g:neomake_cpp_clang_args = ['-fsyntax-only', '-std=c++1z', '-Weverything', '-Wno-padded', '-Wno-c++98-compat', '-Wno-c++98-compat-pedantic','-Wno-missing-prototypes']
  let g:neomake_highlight_lines=1
  let g:neomake_ruby_enabled_makers=[]
  au! BufReadPost,BufWritePost * Neomake

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endt

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

" preference
if has('nvim')
  se icm=nosplit
en

se bg=dark
se bri                    " apply indent to wrapped line (in case of wrap)
se cole=0                 " disable concealed text
se et                     " don't use tab, but space
se hid                    " open another buffer even if unsaved changes exist
se list                   " show invisible character e.g. tabs or spaces
se nowrap                 " don't wrap
se nu                     " show line number
se ru                     " show where line and column cursor is
se sc                     " show incomplete command (e.g. show 'y' when hit y key in command mode)
se sw=2                   " set indent width
se ts=2                   " set tab width
se wim=list:longest,full  " wildmenu settings
se nofixeol               " don't add new line on the end of file


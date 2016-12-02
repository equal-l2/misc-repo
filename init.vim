if v:version >= 700
  try
    " plugin initialization
    set runtimepath+=/Users/hitoshi/.config/nvim/dein/repos/github.com/Shougo/dein.vim

    call dein#begin('/Users/hitoshi/.config/nvim/dein')

    call dein#add('Shougo/dein.vim')
    call dein#add('neomake/neomake')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('tpope/vim-fugitive')
    call dein#add('majutsushi/tagbar')
    call dein#add('bling/vim-bufferline')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('godlygeek/tabular')

    call dein#end()

    if dein#check_install()
      call dein#install()
    endif

    let g:airline_powerline_fonts=1
    let g:neomake_c_enable_markers=['clang']
    let g:neomake_c_clang_args = ["-fsyntax-only -Weverything"]
    let g:neomake_cpp_enable_markers=['clang']
    let g:neomake_cpp_clang_args = ["-fsyntax-only -std=c++1z", "-Weverything", "-Wno-padded", "-Wno-c++98-compat"]
    autocmd! BufReadPost,BufWritePost *.c Neomake
    autocmd! BufReadPost,BufWritePost *.cpp Neomake
  catch
  endtry
endif

set list                  " show invisible character e.g. tabs or spaces
set et                    " don't use tab, but space
set sw=2                  " set tab width
set nu                    " show line number
set ru                    " show where line and column cursor is
set wim=list:longest,full
set cole=0                " disable concealed text
set nowrap
colorscheme pablo

" return to neovim-default
set wmnu                  " enable wildmenu
set ai                    " enable autoindent
set hls                   " enable highlighting matchf
set is                    " enable incremental search
set ls=2                  " always show status bar
set sta                   " enable smart tab
set mouse=a               " enable mouse for all mode
sy on                     " enable syntax highlighting
filetype plugin indent on " enable filetype detection

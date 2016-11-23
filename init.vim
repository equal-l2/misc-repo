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
    call dein#end()

    filetype plugin indent on
    syntax enable

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

if !has('nvim')
  set autoindent
  set hlsearch
  set incsearch
  set laststatus=2
  set smarttab
  set mouse=a
  syntax on
  
endif

set list               " show invisible character e.g. tabs or spaces
set clipboard+=unnamed " integrate with system clipboard
set shiftwidth=2       " set tab width
set number             " show line number
colorscheme pablo

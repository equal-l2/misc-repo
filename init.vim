" unset compatible mode
if &compatible
    set nocompatible
endif

if $COLORTERM != 'truecolor'
    set notermguicolors
else
    set termguicolors
endif

silent! packadd minpac
if exists('*minpac#init')
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Plugins
    " For vim improvement
    call minpac#add('bling/vim-bufferline')
    call minpac#add('itchyny/lightline.vim')
    call minpac#add('junegunn/vim-peekaboo')
    call minpac#add('morhetz/gruvbox')
    call minpac#add('zxqfl/tabnine-vim')

    " For syntax highlighting
    call minpac#add('aklt/plantuml-syntax')
    call minpac#add('cespare/vim-toml')
    call minpac#add('hail2u/vim-css3-syntax')
    call minpac#add('leafgarland/typescript-vim')
    call minpac#add('rust-lang/rust.vim')

    " For misc. improvement
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('w0rp/ale')

    " For vim-plugin development
    call minpac#add('equal-l2/vim-base64')
    call minpac#add('vim-jp/vital.vim')

    packloadall

    " ale settings
    let g:ale_linters = {
                \'c'    : ['clang'],
                \'cpp'  : ['clang'],
                \'python'  : ['flake8', 'bandit', 'pylint'],
                \'ruby' : [],
                \}
    let g:ale_lint_delay=3500
    let s:clang_opts = '-Weverything -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-covered-switch-default'
    let g:ale_c_clang_options= '-std=c11 ' . s:clang_opts
    let g:ale_cpp_clang_options='-std=c++2a ' . s:clang_opts . ' -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-exit-time-destructors -Wno-global-constructors'
    let g:ale_python_flake8_options = '--ignore=E741,E241'
    let g:ale_python_pylint_options = '--disable=C0111'
    let g:ale_python_bandit_options = '--skip B322'
    let g:ale_java_javac_executable = 'jfxc'
    let g:ale_virtualtext_cursor = 1

    " peekaboo setting
    let g:peekaboo_window='vert bo new'

    let g:EditorConfig_core_mode='external_command'

    " config for jedi-vim
    let g:jedi#auto_initialization=0

    " config for colorscheme
    if &termguicolors
        colorscheme gruvbox
        let g:gruvbox_contrast_dark='hard'
        let g:gruvbox_invert_selection=0
        let g:lightline = {
                    \    'colorscheme': 'gruvbox'
                    \}
    endif
endif

" config for latex
let g:tex_flavor='latex'
let g:tex_conceal=''

" use neovim's default configuration
set autoindent                 " enable autoindent
set backspace=indent,eol,start " set backspace behavior
set belloff=all                " don't ring a bell
set display=lastline           " show the whole line even for long one
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
set smartcase                  " search case-sensitively only given uppercase
set virtualedit=block
set wildmode=list:longest,full " wildmenu settings

" better line handling for wrapped lines
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

autocmd FileType kotlin setlocal shiftwidth=4
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType ruby setlocal shiftwidth=2
autocmd BufNewFile,BufRead *.fxml set syntax=xml

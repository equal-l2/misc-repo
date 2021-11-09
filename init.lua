local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

opt.termguicolors = vim.env.COLORTERM == "truecolor"

opt.runtimepath:append("~/git/novalang")

fn["plug#begin"]()
    --  colorscheme
    cmd("Plug 'gruvbox-community/gruvbox'")

    --  improvements
    cmd("Plug 'itchyny/lightline.vim'")
    cmd("Plug 'neoclide/coc.nvim', {'branch': 'release'}")
    cmd("Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}")

    --  project integration
    cmd("Plug 'editorconfig/editorconfig-vim'")
    cmd("Plug 'mhinz/vim-signify'")
fn["plug#end"]()

--  config for colorscheme
if opt.termguicolors then
    g.gruvbox_invert_selection=0
    g.gruvbox_italic=1

    cmd("colorscheme gruvbox")

    g.lightline = {
        colorscheme = 'gruvbox',
        active = {
            left = {
                { 'mode', 'paste' },
                { 'cocstatus', 'readonly', 'filename', 'modified' }
            }
        },
        component_function = {
            cocstatus = 'coc#status'
        },
    }
end

--  config for latex
g.tex_flavor="latex"
g.tex_conceal=""

--  config for netrw
g.netrw_cygwin=0

--  config for coc
opt.shortmess:append("c")

--  extensions
g.coc_global_extensions = {
    "coc-clangd",
    "coc-go",
    "coc-html",
    "coc-json",
    "coc-pyright",
    "coc-rust-analyzer",
    "coc-tabnine",
    "coc-toml",
    "coc-tsserver",
    "coc-vimlsp",
}

cmd([[
    function! g:Check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
]])

cmd([[
    inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ g:Check_back_space() ? "\<TAB>" :
    \ coc#refresh()
]])

cmd("command! -nargs=0 CRename :call CocActionAsync('rename')")
cmd("command! -nargs=0 CFormat :call CocActionAsync('format')")
cmd("command! -nargs=0 CRefactor :call CocActionAsync('refactor')")
cmd("command! -nargs=0 CReference :call CocActionAsync('jumpReferences')")
cmd("command! -nargs=0 CSignature :call CocActionAsync('doHover')")
cmd("nmap <silent> gd <Plug>(coc-definition)")

--  Use autocmd to force lightline update.
cmd("autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()")

--  settings for nvim-treesitter
require"nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indentation = { enable = true },
}

--  preference
opt.inccommand="nosplit"        -- show result for replacing incrementally
opt.pumblend=5                  -- make popup transparent
-- enable esc in terminal
cmd([[tnoremap <silent> <ESC> <C-\><C-n>]])

opt.background="dark"
opt.breakindent=true           -- apply indent to wrapped line (in case of wrap)
opt.completeopt="menu"
opt.conceallevel=0             -- disable concealed text
opt.cursorline=true            -- hightlight the line where cursor is
opt.expandtab=true             -- don't use tab, but use space
opt.fileencodings="ucs-bom,utf-8,shift_jis,default,latin1"
opt.foldmethod="indent"
opt.foldlevel=15
opt.hidden=true                -- open another buffer even if unsaved changes exist
opt.ignorecase=true            -- search case-insensitively (overridden by smartcase)
opt.lazyredraw=true            -- performance improvement
opt.list=true                  -- show invisible character like tabs or spaces
opt.matchpairs:append("<:>")   -- match brackets
opt.fixeol=false               -- do not add new line on the end of file
opt.showmode=false             -- lightline shows the mode, no need to show it by vim itself
opt.wrap=false                 -- do not wrap
opt.number=true                -- show line number
opt.omnifunc="syntaxcomplete#Complete"
opt.shiftwidth=4               -- set indent width
opt.signcolumn="yes"           -- always show signcolumn
opt.smartcase=true             -- search case-sensitively only given uppercase
opt.virtualedit="block"
opt.wildmode="longest,full"    -- wildmenu settings

--  better line handling for wrapped lines
cmd("noremap j gj")
cmd("noremap k gk")
cmd("noremap <Down> gj")
cmd("noremap <Up> gk")

cmd("autocmd CmdwinEnter [:\\/\\?=] setlocal nonumber")
cmd("autocmd CmdwinEnter [:\\/\\?=] setlocal signcolumn=no")

cmd("autocmd FileType go setlocal tabstop=4")
cmd("autocmd FileType kotlin setlocal shiftwidth=4")

cmd("autocmd FileType css setlocal shiftwidth=2")
cmd("autocmd FileType javascript setlocal shiftwidth=2")
cmd("autocmd FileType ruby setlocal shiftwidth=2")
cmd("autocmd FileType typescript setlocal shiftwidth=2")
cmd("autocmd FileType typescriptreact setlocal shiftwidth=2")
cmd("autocmd FileType vue setlocal shiftwidth=2")
cmd("autocmd FileType yaml setlocal shiftwidth=2")

cmd("autocmd BufNewFile,BufRead *.fxml set syntax=xml")
cmd("autocmd BufNewFile,BufRead *.plt set syntax=gnuplot")

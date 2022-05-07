local g = vim.g
local opt = vim.opt

opt.termguicolors = vim.env.COLORTERM == "truecolor"

opt.runtimepath:append("~/git/novelang/")

require("packer").startup(function()
    use "wbthomason/packer.nvim"

    -- colorscheme
    use "gruvbox-community/gruvbox"

    -- improvements
    use "itchyny/lightline.vim"
    use { "neoclide/coc.nvim", branch="release" }
    use { "nvim-treesitter/nvim-treesitter", run=":TSUpdate" }

    -- project integration
    use "editorconfig/editorconfig-vim"
    use "mhinz/vim-signify"
end)

--  config for colorscheme
if opt.termguicolors then
    g.gruvbox_invert_selection=0
    g.gruvbox_italic=1

    vim.cmd("colorscheme gruvbox")

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

--  config for coc
opt.shortmess:append("c")

--  extensions
g.coc_global_extensions = {
    "coc-clangd",
    "coc-html",
    "coc-json",
    "coc-pyright",
    "coc-rust-analyzer",
    "coc-tabnine",
    "coc-toml",
    "coc-tsserver",
    "coc-vimlsp",
    "@yaegassy/coc-volar",
}

vim.cmd([[
    function! g:Check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
]])

vim.api.nvim_set_keymap(
    "i",
    "<TAB>",
    [[pumvisible() ? "\<C-n>" : g:Check_back_space() ? "\<TAB>" :coc#refresh()]],
    {
        expr = true,
        silent = true,
        noremap = true
    }
)

vim.cmd("command! -nargs=0 CRename :call CocActionAsync('rename')")
vim.cmd("command! -nargs=0 CFormat :call CocActionAsync('format')")
vim.cmd("command! -nargs=0 CRefactor :call CocActionAsync('refactor')")
vim.cmd("command! -nargs=0 CReference :call CocActionAsync('jumpReferences')")
vim.cmd("command! -nargs=0 CSignature :call CocActionAsync('doHover')")
vim.api.nvim_set_keymap(
    "n", "gd", "<Plug>(coc-definition)",
    {
        silent = true,
    }
)

--  Use autocmd to force lightline update.
vim.api.nvim_create_autocmd("User", { pattern = "CocStatusChange,CocDiagnosticChange", callback = "lightline#update()"})

--  settings for nvim-treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = {
      "lua",
      "rust",
  },
  highlight = { enable = true },
  indentation = { enable = true },
}

--  preference
opt.inccommand="nosplit"        -- show result for replacing incrementally
opt.pumblend=5                  -- make popup transparent
-- enable esc in terminal
vim.api.nvim_set_keymap(
    "t", "<ESC>", "<C-\\><C-n>",
    {
        silent = true,
        noremap = true
    }
)

opt.background="dark"
opt.breakindent=true           -- apply indent to wrapped line (in case of wrap)
opt.conceallevel=0             -- disable concealed text
opt.cursorline=true            -- hightlight the line where cursor is
opt.expandtab=true             -- use space instead of tab as indent
opt.fileencodings="ucs-bom,utf-8,shift_jis,default,latin1"
opt.fixeol=false               -- do not add new line on the end of file
opt.foldlevel=15
opt.foldmethod="indent"
opt.hidden=true                -- allow opening another buffer even if unsaved changes exist
opt.ignorecase=true            -- search case-insensitively (overridden by smartcase)
opt.laststatus=3               -- global statusline (i.e. not on each windows)
opt.lazyredraw=true            -- performance improvement
opt.list=true                  -- show invisible character like tabs or spaces
opt.matchpairs:append("<:>")   -- match brackets
opt.mouse="a"                  -- enable mouse on all mode
opt.number=true                -- show line number
opt.omnifunc="syntaxcomplete#Complete"
opt.shiftwidth=4               -- set indent width
opt.showmode=false             -- lightline shows the mode, no need to show it by vim itself
opt.signcolumn="yes"           -- always show signcolumn
opt.smartcase=true             -- search case-sensitively only given uppercase
opt.virtualedit="block"
opt.wildmode="longest,full"    -- wildmenu settings
opt.wrap=false                 -- do not wrap

--  better line handling for wrapped lines
vim.api.nvim_set_keymap("", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("", "<Down>", "gj", { noremap = true })
vim.api.nvim_set_keymap("", "<Up>", "gk", { noremap = true })

-- disable number and signcolumn on command-line window ("q:")
vim.api.nvim_create_autocmd("CmdwinEnter", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("CmdwinEnter", { command = "setlocal signcolumn=no" })

-- filetype-specific indent
vim.api.nvim_create_autocmd("FileType", { pattern = "go", command="setlocal tabstop=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "kotlin", command="setlocal shiftwidth=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "css", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "javascript", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "ruby", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "typescript", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "typescriptreact", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "vue", command="setlocal shiftwidth=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "yaml", command="setlocal shiftwidth=2" })

-- assign filetype for unsupported types by vim
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.fxml", command = "set syntax=xml" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.plt",  command = "set syntax=gnuplot" })

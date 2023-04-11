local api = vim.api
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt

opt.termguicolors = vim.env.COLORTERM == "truecolor"

-- config for colorscheme
if opt.termguicolors then
  g.gruvbox_invert_selection = 0
  g.gruvbox_italic = 1
  vim.cmd("colorscheme gruvbox")
end

--  config for latex
g.tex_flavor = "latex"
g.tex_conceal = ""

--  preference
opt.background = "dark"
opt.breakindent = true -- apply indent to wrapped line (in case of wrap)
opt.conceallevel = 0 -- disable concealed text
opt.cursorline = true -- hightlight the line where cursor is
opt.expandtab = true -- use space instead of tab as indent
opt.fileencodings = "ucs-bom,utf-8,shift_jis,default,latin1"
opt.fixeol = false -- do not add new line on the end of file
opt.foldlevel = 15
opt.foldmethod = "indent"
opt.ignorecase = true -- search case-insensitively (overridden by smartcase)
opt.inccommand = "nosplit" -- show result for replacing incrementally
opt.laststatus = 3 -- global statusline (i.e. not on each windows)
opt.lazyredraw = true -- performance improvement
opt.list = true -- show invisible character like tabs or spaces
opt.matchpairs:append("<:>") -- match brackets
opt.mouse = "a" -- enable mouse on all mode
opt.number = true -- show line number
opt.pumblend = 5 -- make popup transparent
opt.shiftwidth = 4 -- set indent width
opt.shortmess:append("c") -- don't show message about completions
opt.showmode = false -- I want the mode to be shown in the statusline
opt.signcolumn = "yes" -- always show signcolumn
opt.smartcase = true -- search case-sensitively only given uppercase
opt.virtualedit = "block"
opt.wildmode = "longest,full" -- wildmenu settings
opt.wrap = false -- do not wrap

-- enable esc in terminal
keymap.set("t", "<ESC>", "<C-\\><C-n>", {
  silent = true,
  noremap = true,
})

--  better line handling for wrapped lines
keymap.set("", "j", "gj", { noremap = true })
keymap.set("", "k", "gk", { noremap = true })
keymap.set("", "<Down>", "gj", { noremap = true })
keymap.set("", "<Up>", "gk", { noremap = true })

-- disable number and signcolumn on command-line window ("q:")
api.nvim_create_autocmd("CmdwinEnter", { command = "setlocal nonumber" })
api.nvim_create_autocmd("CmdwinEnter", { command = "setlocal signcolumn=no" })

-- filetype-specific indent
local function set_shiftwidth(lang, width)
  api.nvim_create_autocmd("FileType", { pattern = lang, command = "setlocal shiftwidth=" .. width })
end

set_shiftwidth("css", 2)
set_shiftwidth("graphql", 2)
set_shiftwidth("javascript", 2)
set_shiftwidth("kotlin", 4)
set_shiftwidth("lua", 2)
set_shiftwidth("proto", 2)
set_shiftwidth("ruby", 2)
set_shiftwidth("typescript", 2)
set_shiftwidth("typescriptreact", 2)
set_shiftwidth("vue", 2)
set_shiftwidth("yaml", 2)
api.nvim_create_autocmd("FileType", { pattern = "go", command = "setlocal tabstop=4" })
api.nvim_create_autocmd("FileType", { pattern = "tex", command = "setlocal wrap" })

-- assign filetype for unsupported types by vim
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.fxml", command = "setfiletype xml" })
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.plt", command = "setfiletype gnuplot" })

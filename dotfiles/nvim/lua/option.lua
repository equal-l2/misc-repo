vim.opt.termguicolors = vim.env.COLORTERM == "truecolor"

-- config for colorscheme
if vim.opt.termguicolors then
  vim.g.gruvbox_invert_selection = 0
  vim.g.gruvbox_italic = 1
  vim.cmd("colorscheme gruvbox")
end

--  config for latex
vim.g.tex_flavor = "latex"
vim.g.tex_conceal = ""

--  preference
vim.opt.background = "dark"
vim.opt.breakindent = true -- apply indent to wrapped line (in case of wrap)
vim.opt.conceallevel = 0 -- disable concealed text
vim.opt.cursorline = true -- hightlight the line where cursor is
vim.opt.expandtab = true -- use space instead of tab as indent
vim.opt.fileencodings = "ucs-bom,utf-8,shift_jis,default,latin1"
vim.opt.fixeol = false -- do not add new line on the end of file
vim.opt.foldlevel = 15
vim.opt.foldmethod = "indent"
vim.opt.ignorecase = true -- search case-insensitively (overridden by smartcase)
vim.opt.inccommand = "nosplit" -- show result for replacing incrementally
vim.opt.laststatus = 3 -- global statusline (i.e. not on each windows)
vim.opt.lazyredraw = true -- performance improvement
vim.opt.list = true -- show invisible character like tabs or spaces
vim.opt.matchpairs:append("<:>") -- match brackets
vim.opt.mouse = "a" -- enable mouse on all mode
vim.opt.number = true -- show line number
vim.opt.pumblend = 5 -- make popup transparent
vim.opt.shiftwidth = 4 -- set indent width
vim.opt.shortmess:append("c") -- don't show message about completions
vim.opt.showmode = false -- I want the mode to be shown in the statusline
vim.opt.signcolumn = "yes" -- always show signcolumn
vim.opt.smartcase = true -- search case-sensitively only given uppercase
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest,full" -- wildmenu settings
vim.opt.wrap = false -- do not wrap


-- enable esc in terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", {
  silent = true,
})

--  better line handling for wrapped lines
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")
vim.keymap.set("", "<Down>", "gj")
vim.keymap.set("", "<Up>", "gk")

local api = vim.api

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

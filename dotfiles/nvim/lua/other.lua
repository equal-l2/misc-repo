require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "python",
    "query",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
  },
  highlight = { enable = true },
  indentation = { enable = true },
})

require("indent_blankline").setup({
  show_current_context = true,
})

local function check_file_size()
  local cmd = vim.api.nvim_command
  local bytes = vim.fn.wordcount().bytes
  local thres = 1000 * 1000 -- 1 MB
  if bytes > thres then
    cmd("IndentBlanklineDisable")
    cmd("TSDisable hightlight")
  end
end

vim.api.nvim_create_autocmd({ "BufRead" }, { pattern = "*", callback = check_file_size })

-- Show lsp progress
require("fidget").setup()

-- Show git status in the sign column
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "!" },
    delete = { text = "_", show_count = true },
    topdelete = { text = "‾" },
    changedelete = { text = "!", show_count = true },
  },
})
vim.api.nvim_create_user_command("ShowGitDiff", "Gitsigns diffthis", {})

-- Show colors for color codes and color names
require("colorizer").setup()

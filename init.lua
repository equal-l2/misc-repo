local api = vim.api
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt

opt.termguicolors = vim.env.COLORTERM == "truecolor"

opt.runtimepath:append("~/git/novelang/")

require "packer".startup(function(use)
  -- package manager itself
  use "wbthomason/packer.nvim"

  -- lua library
  use "nvim-lua/plenary.nvim" -- dependency of crates.nvim

  -- colorscheme
  use "gruvbox-community/gruvbox"

  -- improvements
  use "itchyny/lightline.vim"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "antoinemadec/FixCursorHold.nvim" -- decouples updatetime from CusorHold

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "j-hui/fidget.nvim"
  use "onsails/diaglist.nvim" -- TODO: replace with trouble or nvim-lsputils for reference list
  use "L3MON4D3/LuaSnip"
  use "jose-elias-alvarez/null-ls.nvim"

  -- language-specific LSP extensions
  use "simrat39/rust-tools.nvim"
  use "saecki/crates.nvim"
  use "p00f/clangd_extensions.nvim"

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }

  -- project integration
  use "editorconfig/editorconfig-vim"
  use "mhinz/vim-signify" -- TODO: replace with lua

  -- TODO: telescope?
end)

--  config for colorscheme
if opt.termguicolors then
  g.gruvbox_invert_selection = 0
  g.gruvbox_italic = 1

  vim.cmd("colorscheme gruvbox")

  -- TODO: adjust lightline for LSP
  g.lightline = {
    colorscheme = "gruvbox",
    active = {
      left = {
        { "mode", "paste" },
        { "lspstatus", "readonly", "filename", "modified" }
      }
    },
    --[[
    component_function = {
      lspstatus = function()
        return vim.diagnostic.get(nil)
      end
    },
    ]]
  }
  --[=[
  --  Use autocmd to force lightline update.
  api.nvim_create_autocmd("User", { pattern = "CocStatusChange,CocDiagnosticChange", callback = "lightline#update()"})
  ]=]
end

--  config for latex
g.tex_flavor = "latex"
g.tex_conceal = ""

--  config for signify
g.signify_number_highlight = 1

--  settings for nvim-treesitter
require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "lua",
    "rust",
  },
  highlight = { enable = true },
  indentation = { enable = true },
}

-- settings for LSP
require "mason".setup {}
require "mason-lspconfig".setup {
  automatic_installation = true
}

local lspconfig = require "lspconfig"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  -- currently nop
end

local handlers = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
    }
  ),
}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  handlers = handlers,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      format = {
        enable = true,
        defaultConfig = {
          quote_style = "double",
        }
      }
    }
  },
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  handlers = handlers,
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        bindingHints = { enable = true },
        closureReturnTypeHints = { enable = true }
      },
      lens = {
        references = {
          adt = { enable = true },
          enumVariant = { enable = true },
          method = { enable = true },
          trait = { true }
        }
      },
      rustc = {
        source = "discover"
      }
    }
  }
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    analysis = { typeCheckingMode = "strict" }
  }
}

lspconfig.solargraph.setup {
  handlers = handlers,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

require "clangd_extensions".setup {
  server = { -- server setup args
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
  }
}

local function noarg(func)
  return function()
    func()
  end
end

-- define keymap and commands for LSP
api.nvim_create_user_command("LFormat", noarg(vim.lsp.buf.formatting), {})
-- TODO: fix LRename to show progress (by LSP handler?)
api.nvim_create_user_command("LRename", noarg(vim.lsp.buf.rename), {})
api.nvim_create_user_command("LAction", noarg(vim.lsp.buf.code_action), {})
api.nvim_create_user_command("LDiagnostic", noarg(require "diaglist".open_all_diagnostics), {})
-- TODO: fix LReference to show quickfix location source
api.nvim_create_user_command("LReference", noarg(vim.lsp.buf.references), {})
keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })

-- show popup for errors
api.nvim_create_autocmd("CursorHold", { callback = vim.diagnostic.open_float })

-- LSP extensions
require "null-ls".setup {}
require "diaglist".init {}
require "rust-tools".setup {}
require "crates".setup {
  null_ls = {
    enabled = true
  },
  text = {
    loading = "  Loading...",
    version = "  %s",
    prerelease = "  %s",
    yanked = "  %s yanked",
    nomatch = "  Not found",
    upgrade = "  %s",
    error = "  Error fetching crate",
  },
  popup = {
    text = {
      title = "# %s",
      pill_left = "",
      pill_right = "",
      created_label = "created        ",
      updated_label = "updated        ",
      downloads_label = "downloads      ",
      homepage_label = "homepage       ",
      repository_label = "repository     ",
      documentation_label = "documentation  ",
      crates_io_label = "crates.io      ",
      categories_label = "categories     ",
      keywords_label = "keywords       ",
      prerelease = "%s pre-release",
      yanked = "%s yanked",
      enabled = "* s",
      transitive = "~ s",
      optional = "? %s",
      loading = " ...",
    },
  },
  cmp = {
    text = {
      prerelease = " pre-release ",
      yanked = " yanked ",
    },
  },
}

-- nvim-cmp
g.cursorhold_updatetime = 300 -- time until CursorHold fires
local cmp = require "cmp"
local luasnip = require "luasnip"
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup {
  snippet = {
    expand = function(args)
      require "luasnip".lsp_expand(args.body)
    end,
  },
  view = {
    entries = "native"
  },
  sources = {
    { name = "buffer" },
    { name = "cmp_tabnine" },
    { name = "crates" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "luasnip" },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end),
    -- ["<right>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.confirm()
    --   else
    --     fallback() -- if you use vim-endwise, this fallback will behave the same as vim-endwise.
    --   end
    -- end,
    ["<left>"] = function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback() -- if you use vim-endwise, this fallback will behave the same as vim-endwise.
      end
    end,
  }
}

require "cmp_tabnine.config":setup {}
require "fidget".setup {}

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
opt.showmode = false -- lightline shows the mode, no need to show it by vim itself
opt.signcolumn = "yes" -- always show signcolumn
opt.smartcase = true -- search case-sensitively only given uppercase
opt.virtualedit = "block"
opt.wildmode = "longest,full" -- wildmenu settings
opt.wrap = false -- do not wrap

-- enable esc in terminal
keymap.set(
  "t", "<ESC>", "<C-\\><C-n>",
  {
    silent = true,
    noremap = true
  }
)

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

-- assign filetype for unsupported types by vim
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.fxml", command = "setfiletype xml" })
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.plt", command = "setfiletype gnuplot" })

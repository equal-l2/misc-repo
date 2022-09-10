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
  use "nvim-lua/plenary.nvim"

  -- colorscheme
  use "gruvbox-community/gruvbox"

  -- improvements
  use "nvim-lualine/lualine.nvim"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "antoinemadec/FixCursorHold.nvim" -- decouples updatetime from CusorHold
  use "lukas-reineke/indent-blankline.nvim" -- shows indent guides
  use "kyazdani42/nvim-tree.lua" -- filer

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "j-hui/fidget.nvim" -- show the progress of servers
  use "onsails/diaglist.nvim" -- TODO: replace with trouble or nvim-lsputils for reference list
  use "jose-elias-alvarez/null-ls.nvim" -- adaptor to use non-LSP tools as a LSP code action

  -- language-specific LSP extensions
  use "b0o/schemastore.nvim" -- schemas for JSON
  use "p00f/clangd_extensions.nvim"
  use "saecki/crates.nvim"
  use "simrat39/rust-tools.nvim"
  use "folke/lua-dev.nvim" -- enhanced LSP for neovim's Lua API

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"

  -- project integration
  use "editorconfig/editorconfig-vim"
  use "lewis6991/gitsigns.nvim"

  -- UI wrapper
  use "rcarriga/nvim-notify" -- vim.ui.notify
  use "stevearc/dressing.nvim" -- vim.ui.select and vim.ui.input

  use "dstein64/vim-startuptime"
  use "norcalli/nvim-colorizer.lua"
end)

--  config for colorscheme
if opt.termguicolors then
  g.gruvbox_invert_selection = 0
  g.gruvbox_italic = 1
  vim.cmd("colorscheme gruvbox")
end

local function paste()
  if vim.opt.paste:get() then
    return "PASTE"
  else
    return ""
  end
end

local function readonly()
  if vim.opt.readonly:get() then
    return "%R"
  else
    return ""
  end
end

local function modified()
  if vim.opt.modified:get() or not vim.opt.modifiable:get() then
    return "%M"
  else
    return ""
  end
end

require "lualine".setup {
  options = {
    icons_enabled = false,
    component_separators = "|",
    section_separators = "",
  },
  sections = {
    lualine_a = { "mode", paste },
    lualine_b = { "diagnostics" },
    lualine_c = {
      readonly,
      {
        "filename",
        file_status = false,
      },
      modified
    },
    lualine_x = { "fileformat", "encoding", "filetype" },
    lualine_y = { "%3p%%" },
    lualine_z = { "location" }
  },
  inactive_sections = {}
}

--  config for latex
g.tex_flavor = "latex"
g.tex_conceal = ""

--  settings for nvim-treesitter
require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "lua",
    "python",
    "rust",
    "typescript",
  },
  highlight = { enable = true },
  indentation = { enable = true },
}

-- settings for LSP
require "mason".setup {}
require "mason-lspconfig".setup {
  automatic_installation = true
}

-- this must be happen before Lua LSP setup
require "lua-dev".setup {}

local lspconfig = require "lspconfig"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local handlers = {}

local on_attach = function(client, bufnr)
  -- currently nop
end

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

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    javascript = {
      format = {
        enable = false
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = {
          enabled = true,
          suppressWhenArgumentMatchesName = false,
        },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = false,
        },
      }
    },
    typescript = {
      format = {
        enable = false
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = {
          enabled = true,
          suppressWhenArgumentMatchesName = false,
        },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = false,
        },
      }
    }
  }
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    analysis = { typeCheckingMode = "strict" }
  }
}

require "clangd_extensions".setup {
  server = { -- server setup args
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
  }
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    }
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
      luasnip.lsp_expand(args.body)
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
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Right>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() ~= nil and cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s" }),
  }
}

require "cmp_tabnine.config":setup {}

-- Others
require "fidget".setup {}
require "indent_blankline".setup {
  show_current_context = true,
}
require "nvim-tree".setup {
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
      },
      glyphs = {
        symlink = ""
      }
    }
  },
  diagnostics = {
    enable = true,
    debounce_delay = 100,
    show_on_dirs = true,
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    }
  }
}

require "gitsigns".setup {
  signs = {
    add          = { text = "+" },
    change       = { text = "!" },
    delete       = { text = "_", show_count = true },
    topdelete    = { text = "‾" },
    changedelete = { text = "!", show_count = true },
  }
}

require "colorizer".setup()

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

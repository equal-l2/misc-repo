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
  use { "tzachar/cmp-tabnine", run = "./install.sh" }
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

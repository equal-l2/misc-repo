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

-- settings for LSP
require "mason".setup {}
require "mason-lspconfig".setup {
  automatic_installation = true
}

-- this must be happen before Lua LSP setup
require "lua-dev".setup {}

local lspconfig = require "lspconfig"
local capabilities = require "cmp_nvim_lsp".update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
      schemas = require "schemastore".json.schemas(),
      validate = { enable = true },
    }
  }
}

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

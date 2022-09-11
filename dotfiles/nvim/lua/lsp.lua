-- settings for LSP
require "mason".setup {}
require "mason-lspconfig".setup {
  automatic_installation = true
}

-- this must be happen before Lua LSP setup
require "lua-dev".setup {}

local lspconfig = require "lspconfig"

local base_config = {
  capabilities = require "cmp_nvim_lsp".update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    -- no-op currently
  end,
  handlers = {},
}

local function lsp_setup(M, settings)
  local config = vim.tbl_extend("error", base_config, { settings = settings })
  M.setup(config)
end

lsp_setup(lspconfig.sumneko_lua, {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = { globals = { "vim" } },
    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    format = {
      enable = true,
      defaultConfig = { quote_style = "double" },
    }
  }
})

lsp_setup(lspconfig.rust_analyzer, {
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
})

local tsserver_settings = {
  format = { enable = false },
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

lsp_setup(lspconfig.tsserver, {
  javascript = tsserver_settings,
  typescript = tsserver_settings,
})

lsp_setup(lspconfig.pyright, {
  analysis = { typeCheckingMode = "strict" }
})

lsp_setup(lspconfig.jsonls, {
  json = {
    schemas = require "schemastore".json.schemas(),
    validate = { enable = true },
  }
})

lsp_setup(lspconfig.taplo)
lsp_setup(lspconfig.html)
lsp_setup(lspconfig.volar)

-- LSP extensions
require "clangd_extensions".setup {
  server = base_config
}

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

require "null-ls".setup {}
require "diaglist".init {}
require "rust-tools".setup {}

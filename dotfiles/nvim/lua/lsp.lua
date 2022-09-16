-- settings for LSP
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
})

-- this must be happen before Lua LSP setup
require("lua-dev").setup()

local lspconfig = require("lspconfig")

local base_config = {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    -- no-op currently
  end,
  handlers = {},
}

local function lsp_setup(M, settings)
  local config = vim.tbl_extend("error", base_config, { settings = settings })
  M.setup(config)
end

lspconfig.sumneko_lua.setup({
  capabilities = base_config.capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
  handlers = base_config.handlers,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})

lsp_setup(lspconfig.rust_analyzer, {
  ["rust-analyzer"] = {
    inlayHints = {
      bindingHints = { enable = true },
      closureReturnTypeHints = { enable = true },
    },
    lens = {
      references = {
        adt = { enable = true },
        enumVariant = { enable = true },
        method = { enable = true },
        trait = { true },
      },
    },
    rustc = {
      source = "discover",
    },
  },
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
  },
}

lsp_setup(lspconfig.tsserver, {
  javascript = tsserver_settings,
  typescript = tsserver_settings,
})

lsp_setup(lspconfig.pyright, {
  analysis = { typeCheckingMode = "strict" },
})

lsp_setup(lspconfig.jsonls, {
  json = {
    schemas = require("schemastore").json.schemas(),
    validate = { enable = true },
  },
})

lsp_setup(lspconfig.taplo)
lsp_setup(lspconfig.html)
lsp_setup(lspconfig.volar)

-- LSP extensions
require("clangd_extensions").setup({
  server = base_config,
})

require("crates").setup({
  null_ls = {
    enabled = true,
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
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
})

require("trouble").setup({
  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info",
    other = "other",
  },
  use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  auto_jump = { "lsp_definitions", "lsp_type_definitions" },
})
require("rust-tools").setup()

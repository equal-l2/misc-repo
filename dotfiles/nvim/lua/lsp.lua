-- settings for LSP
require("mason").setup()
require("mason-lspconfig").setup({
  -- automatic_installation = true,
})

-- this must be happen before Lua LSP setup
require("neodev").setup({})

vim.g.cursorhold_updatetime = 300 -- time until CursorHold fires

local base_on_attach = function(client, bufnr)
  local api = vim.api
  local keymap = vim.keymap

  local function noarg(func)
    return function()
      func()
    end
  end

  -- define keymap and commands for LSP
  api.nvim_buf_create_user_command(bufnr, "LFormat", noarg(vim.lsp.buf.format), {})
  api.nvim_buf_create_user_command(bufnr, "LRename", noarg(vim.lsp.buf.rename), {})
  api.nvim_buf_create_user_command(bufnr, "LAction", noarg(vim.lsp.buf.code_action), {})
  api.nvim_buf_create_user_command(bufnr, "LDiagnostic", "Trouble workspace_diagnostics", {})
  api.nvim_buf_create_user_command(bufnr, "LReference", "Trouble lsp_references", {})

  keymap.set("n", "gtd", "<cmd>Trouble lsp_type_definitions<cr>", { noremap = true, silent = true })
  keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })

  -- show popup for errors
  local groupname = "MyLspPopup" .. bufnr
  api.nvim_create_augroup(groupname, {})
  api.nvim_create_autocmd("CursorHold", {
    group = groupname,
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float({
        focus = false,
      })
    end,
  })

  api.nvim_create_autocmd("BufDelete", {
    group = groupname,
    buffer = bufnr,
    callback = function()
      api.nvim_del_augroup_by_name(groupname)
    end,
  })
end

local base_config = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = base_on_attach,
  handlers = {},
}

local function lsp_setup(M, settings, init_options)
  local config = vim.tbl_extend("error", base_config, { settings = settings, init_options = init_options })
  M.setup(config)
end

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  capabilities = base_config.capabilities,
  on_attach = function(client, bufnr)
    base_on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
  handlers = base_config.handlers,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
    },
  },
})

-- This will be done by rust-tools
-- lsp_setup(lspconfig.rust_analyzer, {
--   ["rust-analyzer"] = {
--     inlayHints = {
--       bindingHints = { enable = true },
--       closureReturnTypeHints = { enable = true },
--     },
--     lens = {
--       references = {
--         adt = { enable = true },
--         enumVariant = { enable = true },
--         method = { enable = true },
--         trait = { true },
--       },
--     },
--     rustc = {
--       source = "discover",
--     },
--   },
-- })

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
  python = {
    analysis = {
      typeCheckingMode = "strict",
      diagnosticSeverityOverrides = {
        reportUnknownVariableType = "information",
        reportUnknownMemberType = "information",
        reportUnknownArgumentType = "information",
      },
    },
  },
})

lsp_setup(lspconfig.jsonls, {
  json = {
    schemas = require("schemastore").json.schemas(),
    validate = { enable = true },
  },
})

local ruff_ignores = {
  "A003",
  "ANN101",
  "ANN401",
  "D",
  "E722",
  "ERA001",
  "FBT",
  "ICN001",
  "INP001",
  "PLR0913",
  "PLR0915",
  "PLR2004",
  "RET504",
  "RUF001",
  "RUF002",
  "RUF003",
  "S101",
  "S311",
  "SIM108",
  "T201",
}

lsp_setup(lspconfig.ruff_lsp, {}, {
  settings = {
    args = {
      "--select=ALL",
      "--ignore=" .. table.concat(ruff_ignores, ","),
    },
  },
})

lsp_setup(lspconfig.taplo)
lsp_setup(lspconfig.html)
lsp_setup(lspconfig.volar)
lsp_setup(lspconfig.svelte)

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
    null_ls.builtins.formatting.black,
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

-- TODO: use rust-tools specific api to implement commands and key bindings
require("rust-tools").setup({
  server = {
    capabilities = base_config.capabilities,
    on_attach = base_config.on_attach,
    handlers = base_config.handlers,
  },
})

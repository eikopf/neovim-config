-- configure LSP
-- this function runs when an LSP attaches to a buffer
local on_attach = function(_, bufnr) end

-- define enabled language servers
local servers = {
  jdtls = {},
  julials = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  },
  marksman = {},
  zls = {},
  pyright = {},
  -- rust_analyzer = {}, -- handled specifically
  jsonls = {},
}

-- broadcast nvim-cmp's additional capabilities to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- configure mason with specified servers
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,

  -- default handlers
  ["rust_analyzer"] = function()
    require("rust-tools").setup {}
  end,
}

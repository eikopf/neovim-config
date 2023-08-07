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

local rust_tools_config = {
  dap = function ()
    local install_root_dir = vim.fn.stdpath "data" .. "/mason"
	local extension_path = install_root_dir .. "/packages/codelldb/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

	return {
	  adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
	}
  end,

  hover_actions = {
    auto_focus = true,
  },
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
    local rt = require("rust-tools")
    rt.setup {
      tools = rust_tools_config,
      server = {
        on_attach = function (_, bufnr)
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        end
      }
    }
  end,
}

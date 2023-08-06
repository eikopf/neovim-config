require("core.lazy")
require("core.mappings")
require("core.options")

-- configure transparency
-- https://github.com/xiyaowong/transparent.nvim
require("transparent").setup({
	groups = {
		'Normal',
		'EndOfBuffer',
		'NormalNC',
	},
})

-- configure treesitter
-- see `:help nvim-treesitter`
-- large parts of this config are from tj devries' kickstart.nvim
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'python', 'rust', 'julia', 'java', 'zig', 'odin' },
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- configure LSP
-- this function runs when an LSP attaches to a buffer
local on_attach = function(_, bufnr)
  require("which-key").register {
    ["<leader>"] = {
      l = {
        name = "+lsp",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format Buffer" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        R = { "<cmd>LspRestart<cr>", "Restart Server" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
      },

    g = {
      name = "+goto",
      d = {"<cmd>lua vim.lsp.buf.definition<cr>", "Goto Definition"},
      D = {"<cmd>lua vim.lsp.buf.declaration<cr>", "Goto Declaration"},
      I = {"<cmd>lua vim.lsp.buf.implementation<cr>", "Goto Implementation"},
      r = {"<cmd>lua require('telescope.builtin').lsp_references<cr>", "Goto References"},
    },

    K = {"<cmd>lua vim.lsp.buf.hover<cr>", "Hover Documentation"},
    }
  }

end

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
  rust_analyzer = {},
  jsonls = {},
}

-- setup neovim-specific lua config
require('neodev').setup()

-- setup neoconf (MUST BE PRIOR TO LSP ACTIVATION)
require("neoconf").setup()

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
  end
}

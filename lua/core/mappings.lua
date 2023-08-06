require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar

-- which-key is the primary interface for mapping in this config
-- refer to the docs with <leader>sh
require("which-key").register({
  ["-"] = { "<cmd>Ex<cr>", "Open NetRW" },
  ["<leader>"] = {
    ["."] = { "<cmd>Telescope find_files<cr>", "Search Files" },
    [","] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
    f = { name = "+file" },

    g = { 
      name = "+git",
      g = { "<cmd>Git<cr>", "Status" },
      h = { "<cmd>Flog<cr>", "Show History" },
    },

    l = { 
      name = "+lsp",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format Buffer" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
      R = { "<cmd>LspRestart<cr>", "Restart Server" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Local Symbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    },

    m = {
      name = "+mason",
      o = { "<cmd>Mason<cr>", "Open" },
      u = { "<cmd>MasonUpdate<cr>", "Update" },
    },

    o = { 
      name = "+open",
      f = { "<cmd>Flog<cr>", "Flog" },
      g = { "<cmd>Git<cr>", "Fugitive" },
      l = { "<cmd>Lazy<cr>", "Lazy" },
      m = { "<cmd>Mason<cr>", "Mason" },
      p = { "<cmd>Telescope projects<cr>", "Projects" },
    },

    s = { 
      name = "+search",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep in CWD" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      p = { "<cmd>Telescope projects<cr>", "Projects" },
    },

    t = {
      name = "+terminal",
    },
  }
})

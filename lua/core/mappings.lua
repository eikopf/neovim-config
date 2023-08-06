require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar

-- which-key is the primary interface for mapping in this config
-- refer to the docs with <leader>sh
require("which-key").register({
  ["-"] = { "<cmd>Ex<cr>", "Open NetRW" },

  g = {
      name = "+goto",
      d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition"},
      D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration"},
      I = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation"},
      r = {"<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Goto References"},
  },

  K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation"},
  ["<leader>"] = {
    ["."] = { "<cmd>Telescope find_files<cr>", "Search Files" },
    [","] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
    b = {
      name = "+buffer",
    },

    f = { name = "+file", },

    g = {
      name = "+git",
      A = { "<cmd>Git add -A<cr>", "Stage All" },
      c = { "<cmd>Telescope git_branches<cr>", "Checkout" },
      C = { "<cmd>Git commit<cr>", "Commit" },
      d = { "<cmd>Git diff<cr>", "Diff" },
      g = { "<cmd>Git<cr>", "Status" },
      h = {
        name = "+hunk",
        n = { "<cmd>Gitsigns next_hunk<cr>", "Next" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous" },
        P = { "<cmd>Gitsigns preview_hunk<cr>", "Preview" },
      },
      l = { "<cmd>Git log<cr>", "Log" },
      o = { "<cmd>GBrowse<cr>", "Jump to Github" },
      p = { "<cmd>Git push<cr>", "Push" },
      r = { "<cmd>Git reset<cr>", "Reset" },
      t = { "<cmd>Flog<cr>", "Show Tree" },
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
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
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
      t = { "<cmd>terminal<cr>", "Terminal" },
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

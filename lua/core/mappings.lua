require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar

-- which-key is the primary interface for mapping in this config
-- refer to the docs with <leader>sh
require("which-key").register({
  ["-"] = { "<cmd>Ex<cr>", "Open NetRW" },
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

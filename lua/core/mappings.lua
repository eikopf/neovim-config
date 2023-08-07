require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar

-- which-key is the primary interface for mapping in this config
-- refer to the docs with <leader>sh
require("which-key").register({
  ["-"] = { "<cmd>lua require('oil').open()<cr>", "Oil" },

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
      s = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in Buffer"},
    },

    d = {
      name = "+debug",
      i = { "<cmd>DapStepInto<cr>", "Step Into" },
      k = { "<cmd>DapTerminate<cr>", "Kill Debugger" },
      o = { "<cmd>DapStepOver<cr>", "Step Over" },
      p = { "<cmd>DapStepOut<cr>", "Step Out" }, -- chosen because iop is continuous in QWERTY
      t = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
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
      H = { "<cmd>GBrowse<cr>", "Jump to Github" },
      l = { "<cmd>Flog<cr>", "Log" },
      p = { "<cmd>Git push<cr>", "Push" },
      r = { "<cmd>Git reset<cr>", "Reset" },
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

    n = {
      name = "+neorg",

      w = {
        name = "+workspaces",
        j = { "<cmd>Neorg workspace journal<cr>", "Goto ~/notes/journal" },
        n = { "<cmd>Neorg workspace notes<cr>", "Goto ~/notes" },
        p = { "<cmd>Neorg workspace projects<cr>", "Goto ~/notes/projects" },
      },

      j = {
        name = "+journal",
        o = { "<cmd>Neorg journal toc open", "Open Table of Contents" },
        t = { "<cmd>Neorg journal today<cr>", "Create/Open Today" },
        T = { "<cmd>Neorg journal tomorrow<cr>", "Create/Open Tomorrow" },
        u = { "<cmd>Neorg journal toc update", "Update Table of Contents" },
        y = { "<cmd>Neorg jounal yesterday<cr>", "Create/Open Yesterday" },
      },
    },

    o = {
      name = "+open",
      f = { "<cmd>Flog<cr>", "Flog" },
      g = { "<cmd>Git<cr>", "Fugitive" },
      l = { "<cmd>Lazy<cr>", "Lazy" },
      m = { "<cmd>Mason<cr>", "Mason" },
      O = { "<cmd>ObsidianOpen<cr>", "Obsidian" },
      p = { "<cmd>Telescope projects<cr>", "Projects" },
      t = { "<cmd>terminal<cr>", "Terminal" },
    },

    p = {
      name = "+preview",
      m = {
        name = "+markdown",
        g = {"<cmd>Glow<cr>", "Glow"},
      },
    },

    r = {
      name = "+repl",
      j = { "<cmd>IronFocus julia<cr>", "Julia" },
      l = { "<cmd>IronFocus lua<cr>", "Lua" },
      p = { "<cmd>IronFocus python<cr>", "Python" },
      r = { "<cmd>IronFocus r<cr>", "R" },
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
      o = { "<cmd>ObsidianSearch<cr>", "Obsidian" },
      p = { "<cmd>Telescope projects<cr>", "Projects" },
    },

    t = {
      name = "+terminal",
      f = { "<cmd>IronRepl fish<cr>", "Fish Split" },
      s = { "<cmd>IronRepl sh<cr>", "Sh Split" },
    },

    w = {
      name = "+window",
      f = { "<cmd>only<cr>", "Close Other Windows" },
      h = { "<cmd>wincmd h<cr>", "Go Left" },
      j = { "<cmd>wincmd j<cr>", "Go Down" },
      k = { "<cmd>wincmd k<cr>", "Go Up" },
      l = { "<cmd>wincmd l<cr>", "Go Right" },
      q = { "<cmd>q<cr>", "Quit" },
      s = { "<cmd>split<cr>", "Horizontal Split" },
      v = { "<cmd>vsplit<cr>", "Vertical Split" },
    },
  }
})

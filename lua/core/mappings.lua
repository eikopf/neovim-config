require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar
local wk = require('which-key')

-- which-key is the primary interface for mapping in this config
-- refer to the docs with <leader>sh
--
-- normal mode mappings
wk.register({
  ["-"] = { "<cmd>lua require('oil').open()<cr>", "Oil" },

  ["[["] = { "<cmd>bprevious<cr>", "Last Buffer" },
  ["]]"] = { "<cmd>bnext<cr>", "Next Buffer" },

  ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Window Left (Tmux)" },
  ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Window Down (Tmux)" },
  ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Window Up (Tmux)" },
  ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Window Right (Tmux)" },

  -- GOTO
  g = {
      name = "+goto",
      d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition"},
      D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration"},
      I = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation"},
      r = {"<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Goto References"},
  },

  -- LSP HOVER
  K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation"},

  -- LEADER BINDINGS
  ["<leader>"] = {
    ["."] = { "<cmd>Telescope find_files<cr>", "Search Files" },
    [","] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },

    -- BUFFER
    b = {
      name = "+buffer",
      s = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in Buffer"},
    },

    -- DEBUG
    d = {
      name = "+debug",
      i = { "<cmd>DapStepInto<cr>", "Step Into" },
      k = { "<cmd>DapTerminate<cr>", "Kill Debugger" },
      o = { "<cmd>DapStepOver<cr>", "Step Over" },
      p = { "<cmd>DapStepOut<cr>", "Step Out" }, -- chosen because iop is continuous in QWERTY
      t = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
    },

    -- FILE
    f = { name = "+file", },

    -- GIT
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

    -- IDRIS2
    -- idris gets its own keymap namespace because the actions associated with a dependently
    -- typed language are so different from other kinds of languages. in future, this could
    -- be generalised to use the same keymaps for other languages like Agda and Coq.
    i = {
      name = "+idris2",
      a = {
        name = "+action",
        a = {"<cmd>lua require('idris2.code_action').add_clause()<cr>", "Add Declaration Clause"},
        C = {"<cmd>lua require('idris2.code_action').make_case()<cr>", "Replace Metavar With Case Block"},
        f = {"<cmd>lua require('idris2.code_action').expr_search()<cr>", "Fill Metavar"},
        F = {"<cmd>lua require('idris2.code_action').intro()<cr>", "Fill Metavar With Valid Constructors"},
        G = {"<cmd>lua require('idris2.code_action').generate_def()<cr>", "Generate Definition"},
        L = {"<cmd>lua require('idris2.code_action').make_lemma()<cr>", "Replace Metavar With Lemma"},
        s = {"<cmd>lua require('idris2.code_action').case_split()<cr>", "Case Split on LHS"},
        r = {"<cmd>lua require('idris2.code_action').refine_hole()<cr>", "Refine Hole"},
        R = {"<cmd>lua require('idris2.code_action').expr_search_hints()<cr>", "Refine Hole With Names"},
        W = {"<cmd>lua require('idris2.code_action').make_with()<cr>", "Replace Metavar With With Block"},
      },
      b = {"<cmd>lua require('idris2.browse').browse()<cr>", "Browse Namespace"},
      C = {
        name = "+config",
        i = {"<cmd>lua require('idris2').show_implicits()<cr>", "Show Implicits In Hovers"},
        I = {"<cmd>lua require('idris2').hide_implicits()<cr>", "Hide Implicits In Hovers"},
        m = {"<cmd>lua require('idris2').show_machine_names()<cr>", "Show Machine Names In Hovers"},
        M = {"<cmd>lua require('idris2').hide_machine_names()<cr>", "Hide Machine Names In Hovers"},
        n = {"<cmd>lua require('idris2').full_namespace()<cr>", "Show Full Namespaces In Hovers"},
        N = {"<cmd>lua require('idris2').hide_namespace()<cr>", "Hide Full Namespaces In Hovers"},
      },
      e = {"<cmd>lua require('idris2.repl').evaluate()<cr>", "Evaluate Expression"},
      M = {"<cmd>lua require('idris2.metavars').request_all()<cr>", "List Metavars"},
      ["]"] = {"<cmd>lua require('idris2.metavars').goto_next()<cr>", "Next Metavar"},
      ["["] = {"<cmd>lua require('idris2.metavars').goto_prev()<cr>", "Previous Metavar"},
    },

    k = {
      name = "+keymaps",
      R = {"<cmd>source ~/.config/nvim/lua/core/mappings.lua<cr>", "Reload Keymaps"},
    },

    -- NOTES
    n = {
      name = "+notes",
      g = { "<cmd>NotesGrepAll<cr>", "Grep Over All Entries" },
      G = { "<cmd>NotesGrepWeeks<cr>", "Grep Over Weekly Entries" },
      s = { "<cmd>NotesSearchAll<cr>", "Search All Entries" },
      S = { "<cmd>NotesSearchWeeks<cr>", "Search Weekly Entries" },
      t = { "<cmd>NotesEditToday<cr>", "Open Today's Entry" },
      w = { "<cmd>NotesEditWeek<cr>", "Open Current Weekly Entry"},
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
      O = { "<cmd>ObsidianOpen<cr>", "Obsidian" },
      p = {
        name = "+preview",
        g = { "<cmd>Glow<cr>", "Glow" },
        q = { "<cmd>QuartoPreview<cr>", "Quarto" },
      },
      t = { "<cmd>:split | terminal<cr>i", "Terminal Split" },
      T = { "<cmd>terminal<cr>i", "Terminal" },
    },

    p = {
      name = "+projects",
      n = { "<cmd>NewProjectPrompt<cr>", "New" },
      s = { "<cmd>Telescope projects<cr>", "Search" },
    },

    q = {
      name = "+quarto",
      a = { "<cmd>QuartoActivate<cr>", "Activate" },
      e = { "<cmd><cmd>lua require('otter').export()<cr>", "Export" },
      E = { "<cmd>lua require('otter').export(true)<cr>", "Export & Overwrite" },
      p = { "<cmd>QuartoPreview<cr>", "Preview" },
      q = { "<cmd>lua require('quarto').quartoClosePreview()<cr>", "Close" },
      r = {
        name = "+run",
        a = { "<cmd>QuartoSendAll<cr>", "Run All" },
        r = { "<cmd>QuartoSendAbove<cr>", "Run to Cursor" }
      },
      s = { "<cmd>SlimeSend<cr>", "Send Code Chunk" },
    },

    r = {
      name = "+repl",
      f = { "<cmd>IronFocus fish<cr>i", "Fish" },
      j = { "<cmd>IronFocus julia<cr>i", "Julia" },
      l = { "<cmd>IronFocus lua<cr>i", "Lua" },
      m = { "<cmd>IronFocus matlab<cr>i", "Matlab" },
      p = { "<cmd>IronFocus python<cr>i", "Python" },
      r = { "<cmd>IronFocus r<cr>i", "R" },
    },

    s = {
      name = "+search",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      C = { "<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' } })<cr>", "Config" },
      d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep in CWD" },
      G = {
        name = "+github",
        i = { "<cmd>Octo issue list<cr>", "Issues" },
        p = { "<cmd>Octo pr list<cr>", "PRs" },
        r = { "<cmd>Octo repo list<cr>", "Repos" },
      },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      n = { "<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '~/notes' } })<cr>", "Neorg" },
      o = { "<cmd>ObsidianSearch<cr>", "Obsidian" },
      p = { "<cmd>Telescope projects<cr>", "Projects" },
      P = { "<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '~/projects' } })<cr>", "Project Files" },
    },

    t = {
      name = "+toggle",
      l = { "<cmd>set number!<cr>", "Line Numbers" },
      m = { "<cmd>MinimapToggle<cr>", "Minimap" },
      r = { "<cmd>set relativenumber!<cr>", "Relative Line Numbers" },
      t = { "<cmd>TransparentToggle<cr>", "Transparency" },
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

-- visual mode mappings
wk.register({
  ["<leader>"] = {
    q = {
      name = "+quarto",
      s = { "<cmd>SlimeRegionSend<cr>", "Send Code Region" },
    },
  },
}, { mode = "v" })

-- insert mode mappings
wk.register({
}, { mode = "i" })

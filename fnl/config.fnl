;; configuration entrypoint

(import-macros {: load!} :lib.macros)

;; plugin installation must precede plugin configuration, and both must
;; precede core.compat, which applies the colorscheme
(load! :core.pack)

;;; plugin configuration

(load! :plugins.alabaster)
(load! :plugins.autopairs)
(load! :plugins.catpuccin)
(load! :plugins.claudecode)
(load! :plugins.cmp)
(load! :plugins.conform)
(load! :plugins.conjure)
(load! :plugins.csvview)
(load! :plugins.everforest)
(load! :plugins.gitsigns)
(load! :plugins.grapple)
(load! :plugins.haskell-tools)
(load! :plugins.idris2)
(load! :plugins.lean)
(load! :plugins.lualine)
(load! :plugins.mason)
(load! :plugins.neotest)
(load! :plugins.octo)
(load! :plugins.oil)
(load! :plugins.rustaceanvim)
(load! :plugins.todo-comments)
(load! :plugins.toggleterm)
(load! :plugins.tracey)
(load! :plugins.treesitter)
(load! :plugins.trouble)
(load! :plugins.typst-preview)
(load! :plugins.which-key)
;; plugins.start-up (mini.starter) is currently disabled

;;; core configuration

(load! :core.filetype)
(load! :core.lsp)
(load! :core.options)
(load! :core.autocmds)
(load! :core.keymaps)
(load! :core.journal)
(load! :core.neovide)
(load! :core.compat)

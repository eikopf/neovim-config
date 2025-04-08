;; configuration entrypoint

;; TODO: refactor all core modules to provide setup functions
(require :core.filetype)
(require :core.options)
(require :core.autocmds)
(require :core.keymaps)
(require :core.journal)
(require :core.neovide)
(: (require :core.compat) :setup)

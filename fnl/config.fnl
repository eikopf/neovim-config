;; configuration entrypoint

(import-macros {: load!} :lib.macros)

(load! :core.filetype)
(load! :core.lsp)
(load! :core.options)
(load! :core.autocmds)
(load! :core.keymaps)
(load! :core.journal)
(load! :core.neovide)
(load! :core.compat)

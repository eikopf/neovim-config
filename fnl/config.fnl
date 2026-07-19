;; configuration entrypoint

(import-macros {: load!} :lib.macros)

;; core.pack installs and configures the plugins declared under
;; fnl/plugins/, and must run before the core modules below; in
;; particular core.compat applies the colorscheme
(load! :core.pack)
(load! :core.filetype)
(load! :core.lsp)
(load! :core.options)
(load! :core.autocmds)
(load! :core.keymaps)
(load! :core.journal)
(load! :core.neovide)
(load! :core.compat)

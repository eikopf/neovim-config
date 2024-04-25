;; configuration entrypoint
;; > invoked immediately after init.lua is run

;; core configuration
(require :core.options)
(require :core.keymaps)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)


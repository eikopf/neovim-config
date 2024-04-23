;; configuration entrypoint
;; > invoked immediately after init.lua is run

;; core configuration
(require :core.options)     ;; basic neovim settings, mostly using vim.opt
(require :core.keymaps)     ;; global (i.e. persistent) keymaps

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

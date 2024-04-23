;; configuration entrypoint
;; > invoked immediately after init.lua is run

;; core configuration
(require :core.options)     ;; basic neovim settings, mostly using vim.opt
(require :core.keymaps)     ;; all global keymaps (plugin-specific mappings are defined by their respective files)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

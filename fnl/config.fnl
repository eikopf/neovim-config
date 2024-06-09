;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

;; todos
;; TODO: update README
;; TODO: add a plugin for resolving merge conflicts
;; TODO: try out stevearc/overseer.nvim
;; TODO: try out karb94/neoscroll.nvim


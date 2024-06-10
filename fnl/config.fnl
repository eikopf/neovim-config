;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

;; todos
;; TODO: update README
;; TODO: try out karb94/neoscroll.nvim


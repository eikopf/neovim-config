;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)


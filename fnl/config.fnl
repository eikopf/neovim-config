;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(_G.vim.cmd.colorscheme :catppuccin-macchiato)

;; start completion engine (silently)
(_G.vim.cmd "COQnow --shut-up")


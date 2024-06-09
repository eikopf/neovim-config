;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

;; todos
;; TODO: add nvim-orgmode/orgmode
;; TODO: update README
;; TODO: finish configuring rustaceanvim (i.e. DAP + keybindings)
;; TODO: add plugin support for haskell (haskell-tools.nvim?)
;; TODO: add a plugin for resolving merge conflicts
;; TODO: try out stevearc/overseer.nvim
;; TODO: try out karb94/neoscroll.nvim


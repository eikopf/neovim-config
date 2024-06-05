;; configuration entrypoint

;; core configuration
(require :core.options)
(require :core.keymaps)
(require :core.lsp)

;; load colorscheme
(vim.cmd.colorscheme :catppuccin-macchiato)

;; todos
;; TODO: profile nvim-cmp and make it load faster
;; TODO: add nvim-orgmode/orgmode
;; TODO: update README
;; TODO: finish configuring rustaceanvim (i.e. DAP + keybindings)
;; TODO: add plugin support for haskell


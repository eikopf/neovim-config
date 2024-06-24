;; configuration entrypoint

(local {: TERM 
        : get-term 
        : running-in-neovide} (require :util.term))

;; core configuration
(require :core.filetype)
(require :core.options)
(require :core.autocmds)
(require :core.keymaps)
(require :core.lsp)
(if (running-in-neovide) (require :core.neovide))

;; load colorscheme
(vim.cmd.colorscheme 
  (match (get-term)
    TERM.WEZTERM :catppuccin-macchiato
    TERM.NEOVIDE :everforest
    _            :catppuccin-latte))

;; todos
;; TODO: update README
;; TODO: try out chomosuke/typst-preview.nvim
;; TODO: add keybindings for octo
;; TODO: get nvim-dap to lazy-load (by modifying rustaceanvim config)
;; TODO: get dressing.nvim to lazy-load, or remove it
;; TODO: get gitsigns.nvim to lazy-load, or replace it


;; configuration entrypoint

(local {: OS : get-os : hostname-prefix} (require :util.system))

(local {: TERM 
        : get-term 
        : running-in-neovide} (require :util.term))

;; core configuration
(require :core.filetype)
(require :core.options)
(require :core.autocmds)
(require :core.keymaps)
(require :core.lsp)
(if (running-in-neovide)    (require :core.neovide))
(if (= (get-os) OS.WINDOWS) (require :core.windows))

(if (= (hostname-prefix) :pilatus) (require :core.jabber))

;; load colorscheme
(vim.cmd.colorscheme 
  (match (get-term)
    TERM.WEZTERM :catppuccin-macchiato
    TERM.GHOSTTY :catppuccin-macchiato
    TERM.NEOVIDE :everforest
    _            :catppuccin-latte))


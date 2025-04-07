;; configuration entrypoint

(local {: OS : get-os : hostname-prefix} (require :lib.system))
(local {: TERM : get-term : running-in-neovide} (require :lib.term))

;; core configuration
(require :core.filetype)
(require :core.options)
(require :core.autocmds)
(require :core.keymaps)
(require :core.journal)
(if (running-in-neovide) (require :core.neovide))
(if (= (get-os) OS.WINDOWS) (require :core.windows))

;; conditionally enable jabber; this causes plugins.treesitter to load
;; core.jabber when treesitter is loaded
(tset vim.g :__jabber_enabled (= (hostname-prefix) :pilatus))

;; load colorscheme
(vim.cmd.colorscheme (match (get-term)
                       TERM.WEZTERM :catppuccin-macchiato
                       TERM.GHOSTTY :catppuccin-macchiato
                       TERM.NEOVIDE :everforest
                       _ :catppuccin-latte))

;; configuration entrypoint

(local {: OS : get-os : hostname-prefix} (require :util.system))
(local {: TERM : get-term : running-in-neovide} (require :util.term))

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

;; HACK: patch for neovim/neovim#30985
;; a neovim patch should fix this in 0.11 (in prerelease as of 2025-02-26)
(each [_ method (ipairs [:textDocument/diagnostic :workspace/diagnostic])]
  (local default-diagnostic-handler (. vim.lsp.handlers method))
  (tset vim.lsp.handlers method
        (fn [err result context config]
          (if (not= (?. err :code) -32802)
              (default-diagnostic-handler err result context config)))))

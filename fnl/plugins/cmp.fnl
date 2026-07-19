;; saghen/blink.cmp --- a faster cmp.nvim

(fn enabled []
  "Determines whether `blink.cmp` should currently be enabled."
  (or (?. vim.g :blink-cmp-enable) false))

(fn expand [snippet]
  "Expansion behaviour for snippets."
  (vim.snippet.expand snippet)
  (vim.snippet.stop))

;; keymaps
(local keymap {:preset :default :<Tab> [:fallback] :<S-Tab> [:fallback]})

;; per-provider configurations
(local providers {:latex_symbols {:name :latex_symbols
                                  :module :blink.compat.source
                                  :opts {:strategy 0}}})

;; configuration
(local opts {: keymap
             : enabled
             :appearance {:nerd_font_variant :mono}
             :completion {:documentation {:auto_show true}}
             :snippets {: expand}
             :sources {:default [:lsp :path :snippets :buffer :latex_symbols]
                       : providers}})

(fn setup [_self]
  (set vim.g.blink-cmp-enable true)
  (let [compat (require :blink.compat)
        blink (require :blink.cmp)]
    ;; blink.compat bridges the nvim-cmp sources (e.g. latex_symbols)
    (compat.setup {})
    (blink.setup opts)))

{: setup}

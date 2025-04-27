;; saghen/blink.cmp --- a faster cmp.nvim

;; semver(ish?) release tag
(local version :1.*)

;; completion sources
(local dependencies
       [:rafamadriz/friendly-snippets
        :kdheepak/cmp-latex-symbols
        {1 :saghen/blink.compat :lazy true :opts {} :version "*"}])

(fn enabled []
  "Determines whether `blink.cmp` should currently be enabled."
  (or (?. vim.g :blink-cmp-enable) false))

(fn init []
  (set vim.g.blink-cmp-enable true))

;; per-provider configurations
(local providers {:latex_symbols {:name :latex_symbols
                                  :module :blink.compat.source
                                  :opts {:strategy 0}}})

;; configuration
(local opts {:keymap {:preset :default}
             : enabled
             :appearance {:nerd_font_variant :mono}
             :completion {:documentation {:auto_show true}}
             :sources {:default [:lsp :path :snippets :buffer :latex_symbols]
                       : providers}})

(local opts_extend [:sources.default])

{1 :saghen/blink.cmp : version : dependencies : init : opts : opts_extend}

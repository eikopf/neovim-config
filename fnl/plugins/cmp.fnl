;; saghen/blink.cmp --- a faster cmp.nvim

;; semver(ish?) release tag
(local version :1.*)

;; completion sources
(local dependencies
       [:rafamadriz/friendly-snippets
        :kdheepak/cmp-latex-symbols
        {1 :saghen/blink.compat :lazy true :opts {} :version "*"}])

;; configuration
(local opts
       {:keymap {:preset :default}
        :appearance {:nerd_font_variant :mono}
        :completion {:documentation {:auto_show true}}
        :sources {:default [:lsp :path :snippets :buffer :latex_symbols]
                  :providers {:latex_symbols {:name :latex_symbols
                                              :module :blink.compat.source
                                              :opts {:strategy 0}}}}})

{1 :saghen/blink.cmp
 : version
 : dependencies
 : opts
 :opts_extend [:sources.default]}

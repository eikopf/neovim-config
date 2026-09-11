;; saghen/blink.cmp --- a faster cmp.nvim

;; semver(ish?) release tag
(local version :1.*)

;; completion sources
(local dependencies
       [:rafamadriz/friendly-snippets
        :erooke/blink-cmp-latex])

(fn enabled []
  "Determines whether `blink.cmp` should currently be enabled."
  (or (?. vim.g :blink-cmp-enable) false))

(fn init []
  (set vim.g.blink-cmp-enable true))

(fn expand [snippet]
  "Expansion behaviour for snippets."
  (vim.snippet.expand snippet)
  (vim.snippet.stop))

;; keymaps
(local keymap {:preset :default :<Tab> [:fallback] :<S-Tab> [:fallback]})

;; per-provider configurations
;; Native Unicode completion; the symbol table loads on the first backslash.
(local providers {:latex_symbols {:name :Unicode
                                  :module :blink-cmp-latex
                                  :opts {:insert_command false}}})

;; configuration
(local opts {: keymap
             : enabled
             :appearance {:nerd_font_variant :mono}
             :completion {:documentation {:auto_show true}}
             :snippets {: expand}
             :sources {:default [:lsp :path :snippets :buffer]
                       :per_filetype {:julia {1 :latex_symbols :inherit_defaults true}}
                       : providers}})

(local opts_extend [:sources.default])

{1 :saghen/blink.cmp : version : dependencies : init : opts : opts_extend}

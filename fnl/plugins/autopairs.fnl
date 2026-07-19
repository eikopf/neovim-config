;; nvim-autopairs -- multicharacter bracket completion

{:src :windwp/nvim-autopairs
 ;; lisps are ignored in favor of using nvim-parinfer
 :opts {:disable_filetype [:TelescopePrompt
                           :clojure
                           :scheme
                           :lisp
                           :racket
                           :hy
                           :fennel
                           :janet
                           :carp
                           :wast
                           :yuck]}}

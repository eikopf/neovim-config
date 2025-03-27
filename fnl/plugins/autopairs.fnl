;; nvim-autopairs -- multicharacter bracket completion

{1 :windwp/nvim-autopairs
 :event :InsertEnter
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

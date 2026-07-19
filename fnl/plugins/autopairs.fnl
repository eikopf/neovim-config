;; nvim-autopairs -- multicharacter bracket completion

;; lisps are ignored in favor of using nvim-parinfer
(local opts {:disable_filetype [:TelescopePrompt
                                :clojure
                                :scheme
                                :lisp
                                :racket
                                :hy
                                :fennel
                                :janet
                                :carp
                                :wast
                                :yuck]})

(fn setup [_self]
  (let [autopairs (require :nvim-autopairs)]
    (autopairs.setup opts)))

{: setup}

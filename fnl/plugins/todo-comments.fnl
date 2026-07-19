;; todo-comments.nvim -- functionality for ALLCAPS-style comment prefixes

(fn setup [_self]
  (let [todo-comments (require :todo-comments)]
    (todo-comments.setup {:signs false})))

{: setup}

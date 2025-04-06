;; functional utilities

(λ const [x]
  "Returns a constant unary function of `x`."
  #x)

(λ id [x]
  "The identity function."
  x)

(λ run! [?f]
  "Runs the given function (usually for side-effects) if it is non-nil."
  (when ?f (?f)))

(λ ignore [?f]
  "Runs the given function if it is `non-nil` and returns `nil`."
  (run! ?f)
  nil)

{: const : id : ignore : run!}

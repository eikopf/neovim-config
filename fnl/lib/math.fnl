;; custom mathematical utilities

(λ div [x y]
  "Performs integer division of `x` by `y`."
  (math.floor (/ x y)))

(λ ln [x]
  "Returns the natural logarithm (base e) of `x`."
  (math.log x))

{: div : ln}

;; some custom string utilities

(λ split-at [str sep]
  "Splits `str` at the first `sep`, returning the prefix and suffix as
  multiple values, or `nil` if `sep` doesn't occur."
  (let [index (string.find str sep 1 :plain)]
    (when index
      (values (string.sub str 1 (- index 1))
              (string.sub str (+ index (length sep)))))))

(λ prefix [str sep]
  "Returns the prefix of `str` before `sep`, or `str` if `sep` doesn't occur."
  (or (split-at str sep) str))

(λ suffix [str sep]
  "Returns the suffix of `str` after `sep`, or `nil` if `sep` doesn't occur."
  (let [(_ suf) (split-at str sep)]
    suf))

{: split-at : prefix : suffix}

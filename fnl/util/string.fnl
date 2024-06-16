;; some custom string utilities

(λ split-str-at [str sep]
   "Splits `str` at the first `sep`, returning the `prefix` and `suffix`."
   (let [index (string.find str sep 1 :plain)]
        (if (= nil index) nil
            {:prefix (string.sub str 1 (- index 1)) 
             : sep 
             :suffix (string.sub str (+ index (length sep)))})))

(λ prefix [str sep]
  "Returns the prefix of `str` before `sep`, or `str` if `sep` doesn't occur."
  (or (?. (split-str-at str sep) :prefix) str))

(λ suffix [str sep]
  "Returns the suffix of `str` after `sep`, or `nil` if `sep` doesn't occur."
  (?. (split-str-at str sep) :suffix))

{: split-str-at
 : prefix
 : suffix}

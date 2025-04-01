;; some custom table utilities

(λ first [items]
  "Indexes `items` with the key `1`."
  (when items (. items 1)))

(λ last [items]
  "Indexes `items` with its length."
  (when items (. items (length items))))

{: first : last}

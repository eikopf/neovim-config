;; time and date utilities

(λ now []
   "Returns a table describing the current date. See `:help os.date` for details."
   (os.date :*t))

(λ now-utc []
   "Returns a table describing the current UTC date. See `:help os.date` for details."
   (os.date :!*t))

{: now
 : now-utc}
 

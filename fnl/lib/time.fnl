;; time and date utilities

(local {: div} (require :lib.math))

(λ round-month-to-quarter [month]
  "Rounds `month` to a quarter number."
  (math.ceil (/ month 3)))

(λ weeks-in-year [year]
  "Returns the number of weeks in `year` (either 52 or 53)."
  (let [p (fn [y]
            (math.fmod (+ y (div y 4) (- (div y 100)) (div y 400)) 7))]
    (if (or (= (p year) 4) (= (p (- year 1)) 3))
        53
        52)))

(λ quarter [date]
  "Returns the quarter number of `date`."
  (round-month-to-quarter (. date :month)))

(λ week [date]
  "Returns the ISO week number of `date`."
  (let [y (. date :year)
        w (math.floor (/ (+ 10 (. date :yday) (. date :wday)) 7))]
    (if (< w 1) (weeks-in-year (- y 1))
        (> w (weeks-in-year y)) 1
        w)))

(λ now []
  "Returns a table describing the current date. See `:help os.date` for details."
  (os.date :*t))

(λ now-utc []
  "Returns a table describing the current UTC date. See `:help os.date` for details."
  (os.date :!*t))

{: round-month-to-quarter : weeks-in-year : quarter : week : now : now-utc}

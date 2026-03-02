;; local version of eikopf/tracey.nvim

(local system (require :lib.system))

(λ open-quickfix []
  (let [trouble (require :trouble)]
    (trouble.open :qflist)))

(local P {:opts {:web_port 3010
                 :query_layout {:height 20}
                 :open_quickfix open-quickfix}})

;; set source based on the system
(case (system.hostname)
  :pilatus (set P.dir "~/projects/tracey.nvim")
  _ (set P.1 :eikopf/tracey.nvim))

P

;; eikopf/tracey.nvim (a local checkout on pilatus)

(local system (require :lib.system))

(λ open-quickfix []
  (let [trouble (require :trouble)]
    (trouble.open :qflist)))

(local spec {:opts {:web_port 3010
                    :query_layout {:height 20}
                    :open_quickfix open-quickfix}})

;; set source based on the system
(case (system.hostname-prefix)
  :pilatus (set spec.dir "~/projects/tracey.nvim")
  _ (set spec.src :eikopf/tracey.nvim))

spec

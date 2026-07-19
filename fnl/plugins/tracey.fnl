;; eikopf/tracey.nvim (a local checkout on pilatus; see core/pack.fnl)

(λ open-quickfix []
  (let [trouble (require :trouble)]
    (trouble.open :qflist)))

(fn setup [_self]
  (let [tracey (require :tracey)]
    (tracey.setup {:web_port 3010
                   :query_layout {:height 20}
                   :open_quickfix open-quickfix})))

{: setup}

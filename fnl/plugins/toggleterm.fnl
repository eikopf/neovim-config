;; akinsho/toggleterm.nvim -- persistent, configurable terminal panes

(fn setup [_self]
  (let [toggleterm (require :toggleterm)]
    (toggleterm.setup {:shade_terminals false})))

{: setup}

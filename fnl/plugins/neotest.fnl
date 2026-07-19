;; neotest - a general purpose test runner for neovim

(fn setup [_self]
  (let [neotest (require :neotest)]
    (neotest.setup {:adapters [(require :rustaceanvim.neotest)]})))

{: setup}

;; folke/which-key.nvim --- keymap hints

(fn setup [_self]
  (set vim.o.timeout true)
  (set vim.o.timeoutlen 300)
  (let [which-key (require :which-key)]
    (which-key.setup {:win {:border :none} :icons {:mappings false}})))

{: setup}

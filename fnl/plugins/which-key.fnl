;; folke/which-key.nvim --- keymap hints

{:src :folke/which-key.nvim
 :setup (fn []
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 300)
          ((. (require :which-key) :setup) {:win {:border :none}
                                            :icons {:mappings false}}))}

;; which-key configuration, effectively just a returned table

{1 :folke/which-key.nvim
 :event :VeryLazy
 :init (fn []
         (set vim.o.timeout true)
         (set vim.o.timeoutlen 300))
 :opts {:window {:border :double}}}


;; which-key configuration, effectively just a returned table

{1 :folke/which-key.nvim
 :event :VeryLazy
 :init (fn []
         (set _G.vim.o.timeout true)
         (set _G.vim.o.timeoutlen 300))
 :opts {:window {:border :double}}}


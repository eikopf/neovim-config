;; which-key configuration, effectively just a returned table

{1 :folke/which-key.nvim
 :lazy false
 ;; for keymaps to work, which-key needs to load as early as possible
 :priority 1000
 :init (fn []
         (set vim.o.timeout true)
         (set vim.o.timeoutlen 300))
 :opts {:win {:border :none} :icons {:mappings false}}}

;; p00f/alabaster.nvim --- a neovim port of tonsky's alabaster theme

{1 :p00f/alabaster.nvim
 :lazy false
 :priority 1000
 :init (fn [_]
         (set vim.opt.bg :light)
         (set vim.g.alabaster_dim_comments false))
 :config (fn [] (vim.cmd.colorscheme :alabaster))}

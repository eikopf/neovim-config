;; PLUGIN -- the onedark colorscheme

(fn config []
  (_G.vim.cmd.colorscheme :onedark))

{1 :navarasu/onedark.nvim
 ;; :config config         ;; uncommenting this line would cause onedark to be loaded by default
 :priority 1000}


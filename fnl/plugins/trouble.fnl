;; trouble.nvim -- a nicer quickfix list (v3, tracking branch main)

;; trouble provides the single command :Trouble [mode], where the standard
;; modes are diagnostics, lsp_references, qflist, loclist, symbols, and todo;
;; refer to :help trouble.nvim for details

{:src :folke/trouble.nvim
 :deps [:nvim-tree/nvim-web-devicons]
 :opts {:auto_close true}}

;; trouble.nvim -- a nicer quickfix list (v3, tracking branch main)

;; trouble provides the single command :Trouble [mode], where the standard
;; modes are diagnostics, lsp_references, qflist, loclist, symbols, and todo;
;; refer to :help trouble.nvim for details

(fn setup [_self]
  (let [trouble (require :trouble)]
    (trouble.setup {:auto_close true})))

{: setup}

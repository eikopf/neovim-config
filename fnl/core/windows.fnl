;; this file runs iff neovim starts in Windows

;; make treesitter use zig to compile parsers
(let [ts-install (require :nvim-treesitter.install)]
  (tset ts-install :compilers [:zig]))

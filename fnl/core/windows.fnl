;; this file runs iff neovim starts in Windows

;; make neovim use the forward-slash
(vim.cmd.set :shellslash)

;; make treesitter use zig to compile parsers
(let [ts-install (require :nvim-treesitter.install)]
  (tset ts-install :compilers [ :zig]))

(set vim.opt.guifont "BerkeleyMono:h14")

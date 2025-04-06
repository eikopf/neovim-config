;; custom autocommands and autogroups

(local {: autocmd} (require :lib.autocmd))
(import-macros {: def-autogroup} :lib.macros)

;; terminal autocommands
(def-autogroup :terminal :clear
  (autocmd :TermOpen "*" "setlocal nonumber"))

;; markdown autocommands
(def-autogroup :markdown :clear
  (autocmd :FileType :markdown "setlocal linebreak"))

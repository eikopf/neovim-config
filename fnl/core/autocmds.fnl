;; custom autocommands and autogroups

(local {: autocmd} (require :lib.autocmd))
(import-macros {: augroup!} :lib.macros)

;; terminal autocommands
(augroup! :terminal :clear (autocmd :TermOpen "*" "setlocal nonumber"))

;; markdown autocommands
(augroup! :markdown :clear (autocmd :FileType :markdown "setlocal linebreak"))

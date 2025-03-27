;; custom autocommands and autogroups

(local {: autocmd} (require :util.autocmd))
(import-macros {: augroup!} :util.macros)

;; terminal autocommands
(augroup! :terminal :clear (autocmd :TermOpen "*" "setlocal nonumber"))

;; markdown autocommands
(augroup! :markdown :clear (autocmd :FileType :markdown "setlocal linebreak"))

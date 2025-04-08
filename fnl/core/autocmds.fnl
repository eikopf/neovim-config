;; custom autocommands and autogroups

(import-macros {: def-autogroup} :lib.macros)

(fn setup [_self]
  (let [{: autocmd} (require :lib.autocmd)]
    ;; terminal autocommands
    (def-autogroup :terminal :clear
      (autocmd :TermOpen "*" "setlocal nonumber"))
    ;; markdown autocommands
    (def-autogroup :markdown :clear
      (autocmd :FileType :markdown "setlocal linebreak"))))

{: setup}

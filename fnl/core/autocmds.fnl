;; custom autocommands and autogroups

(local {: autocmd : make-augroup} (require :util.autocmd))

;; hacky macro to make autogroup declarations prettier
;; this relies on autocmd returning the passed group id
(macro augroup! [name clear & tail]
  `(->> (make-augroup ,name ,clear) ,(unpack tail)))


;; terminal autocommands
(augroup! :terminal :clear
          (autocmd :TermOpen :* "setlocal nonumber"))

;; markdown autocommands
(augroup! :markdown :clear
          (autocmd :FileType :markdown "setlocal linebreak"))

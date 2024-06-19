;; custom autocommands and autogroups

(local {: autocmd : make-augroup} (require :util.autocmd))

;; hacky macro to make autogroup declarations prettier
;; this relies on autocmd returning the passed group id
(macro augroup! [name clear & tail]
  `(->> (make-augroup ,name ,clear) ,(unpack tail)))

;; this is a broken version of augroup! that doesn't
;; rely on autocmd returning the group id
(comment (macro augroup! [name clear & cmds]
           `(let [group# (make-augroup ,name ,clear)]
              (do ,(unpack (icollect [_ cmd (ipairs cmds)]
                            `(table.insert ,cmd group#))) nil))))

(augroup! :terminal :clear
          (autocmd :TermOpen :* "setlocal nonumber"))


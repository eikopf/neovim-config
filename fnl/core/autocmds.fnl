;; custom autocommands and autogroups

(fn setup [_self]
  (let [autocmd (require :lib.autocmd)]
    ;; terminal autocommands
    (-> (autocmd.group :terminal :clear)
        (: :on :TermOpen "*" "setlocal nonumber"))
    ;; markdown autocommands
    (-> (autocmd.group :markdown :clear)
        (: :on :FileType :markdown "setlocal linebreak"))
    (-> (autocmd.group :icalendar :clear)
        (: :on [:BufRead :BufNewFile] :*.ics "set fileformat=dos"))
    (-> (autocmd.group :pollen :clear)
        (: :on :FileType :pollen "setlocal linebreak"))))

{: setup}

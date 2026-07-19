;;; cbochs/grapple.nvim --- a scoped tag navigation system

(fn setup [_self]
  (let [grapple (require :grapple)]
    (grapple.setup {:quick_select :1234567890})))

{: setup}

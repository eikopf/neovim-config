;; pwntester/octo.nvim -- github integration for issues and pull requests

(local autocmd (require :lib.autocmd))

;; WARN: octo takes ~30ms to set up, so unlike most plugins its setup is
;; deferred until after the UI has loaded
(fn setup [_self]
  (-> (autocmd.group :octo-setup :clear)
      (: :on-once :UIEnter "*"
         #(vim.schedule #(let [octo (require :octo)] (octo.setup))))))

{: setup}

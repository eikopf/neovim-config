;; Olical/conjure.nvim -- interactive evaluation within neovim

;; callback for evaluating fennel expressions in the commandline
(fn eval-fennel-in-commandline [tbl]
  (let [eval (require :conjure.eval)
        client (require :conjure.client)]
    (client.with-filetype :fennel
      eval.eval-str
      {:origin tbl.name
       :passive? true
       :code tbl.args
       :on-result (fn [res]
                    (print res))})))

;; create user command for evaluating fennel expressions
(vim.api.nvim_create_user_command :FnlEval eval-fennel-in-commandline
                                  {:nargs "?"})

{1 :Olical/conjure
 :ft [:fennel]
 :config (fn []
           (let [main (require :conjure.main)
                 mapping (require :conjure.mapping)]
             (do
               (main.main)
               (mapping:on-filetype))))
 :init (fn []
         (tset vim.g "conjure#debug" true)
         (tset vim.g "conjure#mapping#doc_word" false)
         (tset vim.g "conjure#log#hud#enabled" false))}


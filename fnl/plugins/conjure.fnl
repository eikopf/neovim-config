;; Olical/conjure.nvim -- interactive evaluation within neovim

(fn eval-fennel-in-commandline [tbl]
  "Evaluates the Fennel expression passed as `tbl.args`, 
   and prints the result to the commandline."
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
 :ft [:fennel :scheme]
 :config (fn []
           (let [main (require :conjure.main)
                 mapping (require :conjure.mapping)]
             (do
               (main.main)
               (mapping:on-filetype))))
 :init (fn []
         ;; general config
         (tset vim.g "conjure#debug" true)
         (tset vim.g "conjure#mapping#doc_word" false)
         (tset vim.g "conjure#log#hud#enabled" false)
         ;; scheme config -- change chez to petite if it starts to slow down
         (tset vim.g "conjure#client#scheme#stdio#command" :chez)
         (tset vim.g "conjure#client#scheme#stdio#prompt_pattern" "> $?")
         (tset vim.g "conjure#client#scheme#stdio#value_prefix_pattern" false))}


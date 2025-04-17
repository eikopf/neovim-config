;; Olical/conjure.nvim -- interactive evaluation within neovim

(fn eval-fennel-in-cmd [tbl]
  "Evaluates the Fennel expression passed as `tbl.args`, 
   and prints the result to the commandline."
  (let [eval (require :conjure.eval)
        client (require :conjure.client)]
    (client.with-filetype :fennel
      eval.eval-str
      {:origin tbl.name
       :passive? true
       :code tbl.args
       :on-result (. (require :nfnl.notify) :info)})))

;; create user command for evaluating fennel expressions
(vim.api.nvim_create_user_command :Fnl eval-fennel-in-cmd {:nargs "?"})

{1 :Olical/conjure
 :ft [:clojure :fennel :racket :scheme :janet]
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
         ;; scheme config
         (tset vim.g "conjure#client#scheme#stdio#command" :scheme)
         (tset vim.g "conjure#client#scheme#stdio#prompt_pattern" "> $?")
         (tset vim.g "conjure#client#scheme#stdio#value_prefix_pattern" false)
         ;; janet config
         (tset vim.g "conjure#filetype#janet" :conjure.client.janet.stdio))}

;; Olical/conjure -- interactive evaluation within neovim

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

;; conjure bootstraps itself from its own plugin/ files, so setup only has
;; to provide the vim.g configuration before those are sourced
{:src :Olical/conjure
 :setup (fn []
          ;; general config
          (tset vim.g "conjure#debug" true)
          (tset vim.g "conjure#mapping#doc_word" false)
          (tset vim.g "conjure#log#hud#enabled" false)
          ;; scheme config
          (tset vim.g "conjure#client#scheme#stdio#command" :scheme)
          (tset vim.g "conjure#client#scheme#stdio#prompt_pattern" "> $?")
          (tset vim.g "conjure#client#scheme#stdio#value_prefix_pattern" false)
          ;; janet config
          (tset vim.g "conjure#filetype#janet" :conjure.client.janet.stdio)
          ;; user command for evaluating fennel expressions
          (vim.api.nvim_create_user_command :Fnl eval-fennel-in-cmd
                                            {:nargs "?"}))}

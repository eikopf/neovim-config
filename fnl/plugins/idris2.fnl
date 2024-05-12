;; ShinKage/idris2-nvim -- config for Neovim + LSP + Idris2

;; callback invoked when the idris2 LSP attaches to a buffer
(fn on_attach [_client]
  (let [wk (require :which-key)
        bufnr (_G.vim.api.nvim_get_current_buf)
        action (require :idris2.code_action)
        repl (require :idris2.repl)
        metavar (require :idris2.metavars)]
    (wk.register {:name :+proof
                  :d [action.add_clause "Add Declaration Clause"]
                  :e [repl.evaluate "Evaluate Expression"]
                  :g [action.generate_def "Generate Definition"]
                  :m {:name :+metavar
                      :c [action.make_case "Replace Metavar With Case Block"]
                      :f [action.expr_search "Fill Metavar"]
                      :F [action.intro "Fill Metavar With Valid Constructors"]
                      :l [action.make_lemma "Replace Metavar With Lemma Block"]
                      :m [metavar.request_all "Show Metavars"]
                      :w [action.make_with "Replace Metavar With With Block"]}
                  :r [action.refine_hole "Refine Hole"]
                  :R [action.expr_search_hints "Refine Hole With Names"]
                  :s [action.case_split "Case Split"]
                  "]" [metavar.goto_next "Next Metavar"]
                  "[" [metavar.goto_prev "Previous Metavar"]}
                 {:mode :n :prefix :<leader>p :buffer bufnr})))

(local opts {:autostart_semantic true
             ;; immediately write the buffer after LSP actions
             :code_action_post_hook (fn [] (_G.vim.cmd "silent write"))
             :server {: on_attach}})

{1 :ShinKage/idris2-nvim
 :dependencies [:neovim/nvim-lspconfig :MunifTanjim/nui.nvim]
 ;; this plugin HAS to be lazy-loaded, because it's extremely slow to start
 :ft [:idris2 :ipkg]
 ;; this is wrapped in a function to avoid early loading
 :config (fn []
           (let [idris2 (require :idris2)]
             (idris2.setup opts)))}


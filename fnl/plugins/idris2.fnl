;; ShinKage/idris2-nvim -- config for Neovim + LSP + Idris2

(local autocmd (require :lib.autocmd))

;; callback invoked when the idris2 LSP attaches to a buffer
(fn on_attach [_client]
  (let [{: map : group} (require :lib.keymap)
        bufnr (vim.api.nvim_get_current_buf)
        action (require :idris2.code_action)
        repl (require :idris2.repl)
        metavar (require :idris2.metavars)]
    ;; primary bindings
    (group :<leader>p :+proof bufnr)
    (map :<leader>pd action.add_clause "Add declaration clause" :n bufnr)
    (map :<leader>pe repl.evaluate "Evaluate expression" :n bufnr)
    (map :<leader>pg action.generate_def "Generate definition" :n bufnr)
    (map :<leader>pr action.refine_hole "Refine hole" :n bufnr)
    (map :<leader>pR action.expr_search_hints "Refine hole with names" :n bufnr)
    (map :<leader>ps action.case_split "Case split" :n bufnr)
    (map "<leader>p]" metavar.goto_next "Next metavar" :n bufnr)
    (map "<leader>p[" metavar.goto_prev "Previous metavar" :n bufnr)
    ;; metavariable bindings
    (group :<leader>pm :+metavar bufnr)
    (map :<leader>pmc action.make_case "Replace metavar with case block" :n
         bufnr)
    (map :<leader>pmf action.expr_search "Fill metavar" :n bufnr)
    (map :<leader>pmF action.intro "Fill metavar with constructors" :n bufnr)
    (map :<leader>pml action.make_lemma "Replace metavar with lemma block" :n
         bufnr)
    (map :<leader>pmm metavar.request_all "Show metavars" :n bufnr)
    (map :<leader>pmw action.make_with "Replace metavar with with block" :n
         bufnr)))

(local opts {:autostart_semantic true
             ;; immediately write to the buffer after LSP actions
             :code_action_post_hook (fn [] (vim.cmd "silent write"))
             :server {: on_attach}})

(λ setup-idris2 [ev]
  (let [idris2 (require :idris2)]
    (idris2.setup opts))
  ;; re-fire the filetype event so that the freshly-registered server
  ;; config attaches to the triggering buffer
  (vim.api.nvim_buf_call ev.buf #(set vim.bo.filetype vim.bo.filetype)))

;; NOTE: idris2-nvim is extremely slow to set up, so unlike most plugins
;; its setup is deferred until the first idris buffer is opened
(fn setup [_self]
  (-> (autocmd.group :idris2-setup :clear)
      (: :on-once :FileType [:idris2 :ipkg] setup-idris2)))

{: setup}

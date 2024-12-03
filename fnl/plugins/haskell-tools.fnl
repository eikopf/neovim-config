;; mrcjkb/haskell-tools.nvim -- a batteries-included haskell configuration

(fn make-local-bindings [bufnr ht]
  (let [{: map : group} (require :util.keymap)]
    ;; primary bindings
    (map :<leader>cl vim.lsp.codelens.run "Run code lens" :n bufnr)
    (map :<leader>cs ht.hoogle.hoogle_signature "Hoogle signature search" :n bufnr)
    (map :<leader>ce ht.lsp.buf_eval_all "Evaluate all snippets" :n bufnr)
    ;; repl bindings
    (group :<leader>r :+repl bufnr)
    (map :<leader>rt ht.repl.toggle "Toggle GHCi REPL" :n bufnr)
    (map :<leader>rq ht.repl.quit "Quit GHCi REPL" :n bufnr)))
    
(set vim.g.haskell_tools
     {:hls {:on_attach (fn [_ bufnr ht]
                         (make-local-bindings bufnr ht))}
      :tools {:repl {:handler :builtin}}})

{1 :mrcjkb/haskell-tools.nvim 
 :version :^3 
 :lazy false}
 
 


;; mrcjkb/haskell-tools.nvim -- a batteries-included haskell configuration

(fn make-local-bindings [bufnr ht]
  (let [wk (require :which-key)]
    (wk.add {1 :<leader>cl 
             2 vim.lsp.codelens.run
             :buffer bufnr
             :desc "Run code lens"})
    (wk.add {1 :<leader>cs 
             2 ht.hoogle.hoogle_signature 
             :buffer bufnr
             :desc "Search Hoogle for matching signatures"})
    (wk.add {1 :<leader>ce 
             2 ht.lsp.buf_eval_all 
             :buffer bufnr
             :desc "Evaluate all snippets"})
    (wk.add {1 :<leader>r :group "+repl" :buffer bufnr}) ;; define group name
    (wk.add {1 :<leader>rt 
             2 ht.repl.toggle 
             :buffer bufnr
             :desc "Toggle GHCi REPL"})
    (wk.add {1 :<leader>rq 
             2 ht.repl.quit
             :buffer bufnr
             :desc "Quit GHCi REPL"})))

(set vim.g.haskell_tools
     {:hls {:on_attach (fn [_ bufnr ht]
                         (make-local-bindings bufnr ht))}
      :tools {:repl {:handler :builtin}}})

{1 :mrcjkb/haskell-tools.nvim :version :^3 :lazy false}


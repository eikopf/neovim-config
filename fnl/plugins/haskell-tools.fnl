;; mrcjkb/haskell-tools.nvim -- a batteries-included haskell configuration

(fn make-local-bindings [bufnr ht]
  (let [wk (require :which-key)]
    (wk.register {:l [vim.lsp.codelens.run "Run Code Lens"]
                  :s [ht.hoogle.hoogle_signature
                      "Search Hoogle for Matching Signatures"]
                  :e [ht.lsp.buf_eval_all "Evaluate All Snippets"]
                  :r {1 :+repl
                      :t [ht.repl.toggle "Toggle GHCi REPL"]
                      :q [ht.repl.quit "Quit GHCi REPL"]}}
                 {:mode :n :prefix :<leader>c :buffer bufnr})))

(set vim.g.haskell_tools
     {:hls {:on_attach (fn [_ bufnr ht]
                         (make-local-bindings bufnr ht))}
      :tools {:repl {:handler :builtin}}})

{1 :mrcjkb/haskell-tools.nvim :version :^3 :lazy false}


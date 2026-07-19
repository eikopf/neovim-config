;; mrcjkb/haskell-tools.nvim --- hls (+ extra) integration for neovim

(λ make-bindings [_client bufnr ht]
  (let [{: map*} (require :lib.keymap)
        opts (fn [desc] {:noremap true :silent true :buffer bufnr : desc})]
    (map* :n :<leader>cl vim.lsp.codelens.run (opts "Run codelens"))
    (map* :n :<leader>cS ht.hoogle.hoogle_signature
          (opts "Search hoogle for signature"))
    (map* :n :<leader>cE ht.lsp.buf_eval_all (opts "Evaluate code snippets"))
    (map* :n :<leader>tR ht.repl.toggle (opts "Toggle GHCi"))))

;; the plugin configures itself from vim.g.haskell_tools when it loads
{:src :mrcjkb/haskell-tools.nvim
 :version (vim.version.range :^6)
 :setup (fn []
          (set vim.g.haskell_tools (fn [] {:hls {:on_attach make-bindings}})))}

;; Julian/lean.nvim -- lean4 VSCode-style support

;; the plugin configures itself from vim.g.lean_config when it loads
(fn setup [_self]
  (set vim.g.lean_config {:lsp {} :mappings true}))

{: setup}

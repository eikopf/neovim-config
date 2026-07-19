;; mason-org/mason.nvim --- package manager for language tooling

(local system (require :lib.system))

;; mason is only installed and configured on windows (see core/pack.fnl)
(fn setup [_self]
  (when (system.windows?)
    (let [mason (require :mason)
          mason-lspconfig (require :mason-lspconfig)]
      (mason.setup {})
      (mason-lspconfig.setup {}))))

{: setup}

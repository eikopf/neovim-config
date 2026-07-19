;; mason-org/mason.nvim --- package manager for language tooling

{:src :mason-org/mason-lspconfig.nvim
 :deps [:mason-org/mason.nvim :neovim/nvim-lspconfig]
 :enabled #((. (require :lib.system) :windows?))
 :setup (fn []
          ((. (require :mason) :setup) {})
          ((. (require :mason-lspconfig) :setup) {}))}

;; LSP configuration

;; other non-LSP tools to install with mason
(local tools [:codelldb :jq :ruff :sql-formatter :typstfmt])

{1 :neovim/nvim-lspconfig
 :dependencies [;; mason manages installs of the different language servers
                {1 :williamboman/mason.nvim :config true}
                ;; mason-lspconfig integrates mason with nvim-lspconfig
                {1 :williamboman/mason-lspconfig.nvim :lazy true}
                ;; fidget adds a small ui element with lsp status info
                {1 :j-hui/fidget.nvim :tag :legacy :opts {}}]}


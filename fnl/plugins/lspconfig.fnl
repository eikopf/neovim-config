;; LSP configuration

;; other non-LSP tools to install with mason
(local _tools [:codelldb :jq :ruff :sql-formatter :typstfmt])

{1 :neovim/nvim-lspconfig
 :dependencies [;; mason manages installs of the different language servers
                {1 :williamboman/mason.nvim :config true}
                ;; mason-lspconfig integrates mason with nvim-lspconfig
                {1 :williamboman/mason-lspconfig.nvim :lazy true}]}


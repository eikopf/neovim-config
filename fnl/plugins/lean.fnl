;; Julian/lean.nvim -- lean4 VSCode-style support

;; the plugin configures itself from vim.g.lean_config when it loads
{:src :Julian/lean.nvim
 :deps [:neovim/nvim-lspconfig
        :nvim-lua/plenary.nvim
        :nvim-telescope/telescope.nvim]
 :setup (fn []
          (set vim.g.lean_config {:lsp {} :mappings true}))}

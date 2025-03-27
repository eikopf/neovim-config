;; Julian/lean.nvim -- lean4 VSCode-style support

{1 :Julian/lean.nvim
 :event ["BufReadPre *.lean" "BufNewFile *.lean"]
 :dependencies [:neovim/nvim-lspconfig
                :nvim-lua/plenary.nvim
                :hrsh7th/nvim-cmp
                :hrsh7th/cmp-nvim-lsp
                :nvim-telescope/telescope.nvim]
 :opts {:lsp {} :mappings true}}

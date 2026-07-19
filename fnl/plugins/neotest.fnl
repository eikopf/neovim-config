;; neotest - a general purpose test runner for neovim

{:src :nvim-neotest/neotest
 :deps [:nvim-neotest/nvim-nio
        :nvim-lua/plenary.nvim
        :antoinemadec/FixCursorHold.nvim
        :nvim-treesitter/nvim-treesitter
        :mrcjkb/rustaceanvim]
 :opts (fn []
         {:adapters [(require :rustaceanvim.neotest)]})}

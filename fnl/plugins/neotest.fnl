;; neotest - a general purpose test runner for neovim

(fn opts []
  {:adapters [(require :rustaceanvim.neotest)]})

{1 :nvim-neotest/neotest
 :dependencies [:nvim-neotest/nvim-nio
                :nvim-lua/plenary.nvim
                :antoinemadec/FixCursorHold.nvim
                :nvim-treesitter/nvim-treesitter
                :rustaceanvim]
 : opts
 :lazy true}

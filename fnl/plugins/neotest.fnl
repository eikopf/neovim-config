;; neotest - a general purpose test runner for neovim

(fn opts []
  {:adapters [(require :rustaceanvim.neotest)]})

{1 :nvim-neotest/neotest
 :dependencies [:nvim-neotest/nvim-nio
                :nvim-lua/plenary.nvim
                :antoinemadec/FixCursorHold.nvim
                :nvim-treesitter/nvim-treesitter
                ;; naming rustaceanvim ensures that rustaceanvim.fnl is already required
                :rustaceanvim]
 : opts}


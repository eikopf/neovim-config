return { 
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
  },

  {
    'saecki/crates.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    config = function ()
      require("crates").setup()
    end
  },
}

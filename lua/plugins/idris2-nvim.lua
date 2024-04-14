local opts = {
  -- reference the options on github
  -- https://github.com/ShinKage/idris2-nvim
  autostart_semantic = true,
}

return {
  "ShinKage/idris2-nvim",

  dependencies = {
    "neovim/nvim-lspconfig",
    -- nui.nvim is an optional ui feature,
    -- but seems to be required for some of
    -- the LSP hover functionality
    "MunifTanjim/nui.nvim",
  },

  -- defines filetypes to load plugin for
  ft = {
    "idris2",
    "ipkg",
  },

  -- callback at load
  config = function (_, _)
    -- this DOES NOT load the idris2-nvim plugin
    -- itself, but instead sets up behaviour largely
    -- related to the LSP
    require("idris2").setup(opts)
    print("loaded idris2-nvim and invoked LSP")
  end
}

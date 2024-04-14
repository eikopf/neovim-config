
-- this file should only contain plugins with no configuration details

return {
  "nvim-neotest/nvim-nio",
  "folke/neodev.nvim",
  'xiyaowong/transparent.nvim',
  'tpope/vim-rhubarb',
  {'chrisgrieser/nvim-genghis', dependencies = "stevearc/dressing.nvim"},
  'Vigemus/iron.nvim', -- repl handler, expects various repls to be installed
  'wfxr/minimap.vim', -- requires code-minimap to be installed via cargo
  { 'christoomey/vim-tmux-navigator', -- for tmux integration
    lazy = false },
  "ChrisWellsWood/roc.vim",
}

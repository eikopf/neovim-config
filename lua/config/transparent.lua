-- configure transparency
-- https://github.com/xiyaowong/transparent.nvim

-- the groups in question are "highlight groups,"
-- so in particular see :h highlight-groups.
require("transparent").setup({
  groups = {
    'Normal',
    'EndOfBuffer',
    'NormalNC',
    'NonText',
    'LineNr',
    'SignColumn',
    'Comment',
  },

  extra_groups = {
    "WhichKeyBorder",
    "FloatBorder",
    "WinSeparator",
    "Folded",
    "FoldColumn",
  },

  exclude_groups = { "WhichKeyGroup", }, -- :h which-key.nvim-which-key-colors
})

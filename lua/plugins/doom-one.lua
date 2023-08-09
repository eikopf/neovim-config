return {
  'NTBBloodbath/doom-one.nvim',
  setup = function ()
    vim.g.doom_one_cursor_coloring = false
    vim.g.doom_one_terminal_colors = true
    vim.g.doom_one_italic_comments = false
    vim.g.doom_one_enable_treesitter = true
    vim.g.doom_one_diagnostics_text_color = false
    vim.g.doom_one_transparent_background = vim.g.transparent_enabled
    vim.g.doom_one_pumblend_enable = false
    vim.g.doom_one_pumblend_transparency = 20

    -- plugin integrations
    vim.g.doom_one_plugin_neorg = false
    vim.g.doom_one_plugin_barbar = false
    vim.g.doom_one_plugin_telescope = true
    vim.g.doom_one_plugin_neogit = false
    vim.g.doom_one_plugin_nvim_tree = false
    vim.g.doom_one_plugin_dashboard = false
    vim.g.doom_one_plugin_startify = true
    vim.g.doom_one_plugin_whichkey = true
  end,

  config = function ()
    vim.cmd("colorscheme doom-one")
  end,
}

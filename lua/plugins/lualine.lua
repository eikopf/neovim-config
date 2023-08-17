local function pwd()
  -- returns path relative to home dir
  return vim.fn.expand("%:~:h")
end

local battery = require("battery")
battery.setup({})

local nvimbattery = {
  function()
    return battery.get_status_line()
  end,

  icon = nil,
}

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename', pwd },
      lualine_x = { nvimbattery },
      lualine_y = { 'encoding', 'filetype' },
      lualine_z = { 'location' },
    },
  },
}

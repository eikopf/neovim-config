
-- font options
vim.o.guifont = "FiraCode Nerd Font:h13"

-- window options
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end

vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.79
vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.floating_blur_amount_x = 2.0
vim.g.floating_blur_amount_y = 2.0

-- cursor
vim.g.neovide_cursor_trail_size = 0.2

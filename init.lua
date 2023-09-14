-- core components
require("core.lazy")
require("core.mappings")
require("core.options")

-- enable neovide settings when running in neovide
if vim.g.neovide then
  require("core.neovide")
end

-- plugin configurations
-- this can't really be abbreviated to 'require(config)',
-- since the specific order matters
require("config.neodev")
require("config.oneliners")
require("config.obsidian")
require("config.treesitter")
require("config.mason")
require("config.cmp")
require("config.dap")
require("config.iron")
require("config.glow")
require("config.octo")
require("config.transparent")

-- custom components
require("custom.projects")
require("custom.journal")

-- fix terminal mode by making <Esc> work again
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- choose colorscheme at startup
if vim.g.neovide then
  vim.cmd("colorscheme onedark")
else
  vim.cmd("colorscheme doom-one")
end

-- core components
require("core.lazy")
require("core.mappings")
require("core.options")

-- plugin configurations
-- this can't really be abbreviate to 'require(config)',
-- since the specific order matters
require("config.neodev")
require("config.oneliners")
require("config.transparent")
require("config.obsidian")
require("config.treesitter")
require("config.mason")
require("config.cmp")
require("config.dap")
require("config.iron")
require("config.headlines")
require("config.glow")

-- custom components
require("custom.projects")

-- fix terminal mode by making <Esc> work again
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- choose colorscheme at startup
vim.cmd("colorscheme doom-one")

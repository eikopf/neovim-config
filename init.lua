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

-- fix terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- modeline
-- vim: ts=2 sts=2 sw=2 et

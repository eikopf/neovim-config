-- define leader keys (otherwise plugins will use the default leader key)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- bootstrap lazy.nvim
local lazy_prefix = vim.fn.stdpath("data") .. "/lazy"
local lazy_path = lazy_prefix .. "/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazy_path,
	})
end

-- bootstrap hotpot.nvim
local hotpot_path = lazy_prefix .. "/hotpot.nvim"
if not vim.loop.fs_stat(hotpot_path) then
	vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/rktjmp/hotpot.nvim.git",
		hotpot_path,
	})
end

-- prepend lazy and hotpot to the runtime path
vim.opt.rtp:prepend(lazy_path)
vim.opt.rtp:prepend(hotpot_path)

-- enable bytecode caching
vim.loader.enable()

-- refer to https://github.com/rktjmp/hotpot.nvim/issues/97
local plugins = { "rktjmp/hotpot.nvim" }

-- configure hotpot
require("hotpot").setup({
	provide_require_fennel = true,
})

-- manually glob files from plugin dir
local plugin_dir = vim.fn.stdpath("config") .. "/fnl/plugins"
if vim.loop.fs_stat(plugin_dir) then
	for file in vim.fs.dir(plugin_dir) do
		file = file:match("^(.*)%.fnl$")
		plugins[#plugins + 1] = require("plugins." .. file)
	end
end

-- load lazy
require("lazy").setup(plugins, {
	change_detection = {
		notify = false, -- this disables the "Config Change Detected..." messages
	},
})

-- bootstrapping is complete, so control passes to fnl/config.fnl
require("config")

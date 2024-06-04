-- define leader keys (otherwise plugins will use the default leader key)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- bootstrap lazy.nvim
local lazy_prefix = vim.fn.stdpath("data") .. "/lazy"
local lazy_install_path = lazy_prefix .. "/lazy.nvim"
if not vim.loop.fs_stat(lazy_install_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazy_install_path,
	})
end

-- bootstrap hotpot.nvim (fennel compiler plugin)
local hotpot_path = lazy_prefix .. "/hotpot.nvim"
if not vim.loop.fs_stat(hotpot_path) then
	vim.notify("bootstrapping hotpot.nvim...", vim.log.levels.INFO)
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"--branch=v0.12.0",
		"https://github.com/rktjmp/hotpot.nvim.git",
		hotpot_path,
	})
end

-- prepend lazy and hotpot to the runtime path
vim.opt.rtp:prepend({ hotpot_path, lazy_install_path })

-- enable jit compilation
vim.loader.enable()

-- load hotpot
require("hotpot").setup({
	provide_require_fennel = true,
})

local plugin_spec = { {
	{
		{ import = "plugins" },
		{ "rktjmp/hotpot.nvim" },
	},
} }

-- finally, we invoke lazy by passing the plugin spec and some options
require("lazy").setup(plugin_spec, {
	change_detection = {
		notify = false, -- this disables the "Config Change Detected..." messages
	},
})

-- bootstrapping is complete, so control passes to fnl/config.fnl
require("config")

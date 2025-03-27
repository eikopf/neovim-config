-- this file was derived in part from https://github.com/rafaeldelboni/cajus-nfnl/tree/main

-- define leader keys (otherwise plugins will use the default leader key)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- installation prefix for lazy.nvim
local lazy_prefix = vim.fn.stdpath("data") .. "/lazy"

-- installation directory for lazy.nvim itself
local lazy_install_path = lazy_prefix .. "/lazy.nvim"

-- if lazy isn't installed, then install the latest stable version
if not (vim.uv or vim.loop).fs_stat(lazy_install_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazy_install_path,
  })
end

-- prepend lazy.nvim's install path to the runtime path
vim.opt.rtp:prepend(lazy_install_path)

-- enable jit compilation
vim.loader.enable()

-- the plugin spec defines the set of plugins that lazy.nvim loads.
-- in this case, all files under the plugin module are merged
-- into a plugin spec, and nfnl is explicitly added
local plugin_spec = { {
  {
    { import = "plugins" },
    { "Olical/nfnl" },
  },
} }

-- finally, we invoke lazy by passing the plugin spec and some options
require("lazy").setup(plugin_spec, {
  change_detection = {
    notify = false, -- this disables the "Config Change Detected..." messages
  },
})

-- at this point, it's possible that the lua/ directory does not exist,
-- typically because the repo has just been cloned
local target_dir = vim.fn.stdpath("config") .. "/lua"
if vim.fn.glob(target_dir) == "" then
  -- we do the dumbest possible thing here: compile the .fnl files and immediately exit;
  -- then the next time the user opens neovim, it should just behave as normal
  require("nfnl.api")["compile-all-files"](target_dir)
  os.exit()
end

-- bootstrapping is complete, so control passes to fnl/config.fnl
require("config")

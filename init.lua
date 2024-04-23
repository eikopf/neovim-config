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

-- TODO: lazy seems to ignore this directive
-- additional lazy configuration
local opts = {
  change_detection = {
    enabled = true, -- make lazy reload config when any config files change
    notify = false, -- don't explicitly notify the user about config changes
  },
}

-- invoke lazy by pulling all plugin specs from the plugins module,
-- loading nfnl beforehand to compile .fnl files as necessary
--
-- NOTE: on a fresh installation, nfnl will be the only plugin loaded
require("lazy").setup({
  spec = {
    { 
      { import = "plugins" }, 
      { "Olical/nfnl", ft = "fennel" },
    }
  }
}, opts)

-- bootstrapping is complete, so control passes to fnl/config.fnl
require("config")

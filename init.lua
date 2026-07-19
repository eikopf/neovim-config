-- this file was derived in part from https://github.com/rafaeldelboni/cajus-nfnl/tree/main

-- define leader keys (otherwise plugins will use the default leader key)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- enable jit compilation
vim.loader.enable()

-- fail early and clearly on neovim versions without the builtin package
-- manager, e.g. distro-packaged releases
if vim.fn.has("nvim-0.12") == 0 then
  error("this configuration requires vim.pack, and hence neovim 0.12+")
end

-- install nfnl with the builtin package manager (see :help vim.pack); the
-- remaining plugins are handled in fnl/core/pack.fnl, which can only run
-- once the fennel sources have been compiled
vim.pack.add({ "https://github.com/Olical/nfnl" }, { confirm = false })

-- at this point, it's possible that the lua/ directory does not exist,
-- typically because the repo has just been cloned
local target_dir = vim.fn.stdpath("config") .. "/lua"
if vim.fn.glob(target_dir) == "" then
  -- we do the dumbest possible thing here: compile the .fnl files and immediately exit;
  -- then the next time the user opens neovim, it should just behave as normal
  require("nfnl.api")["compile-all-files"](target_dir)
  print("compiled fennel sources to lua/; please restart neovim")
  os.exit()
end

-- bootstrapping is complete, so control passes to fnl/config.fnl
require("config")

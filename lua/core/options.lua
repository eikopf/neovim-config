--
-- OPTIONS
--

-- some details from https://gitlab.com/oinak/dot_config_nvim/-/blob/main/lua/core/options.lua

-- sensible defaults from https://www.youtube.com/watch?v=J9yqSdvAKXY
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true -- save the file before leaving if changed
vim.opt.autoread = true -- auto load file changes occured outside vim
-- use spaces for tabs and whatnot
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- round indent to sw compatible
vim.opt.expandtab = true

-- Decrease update time
vim.opt.timeoutlen = 500
-- vim.opt.updatetime = 200
vim.opt.updatetime = 50 -- primeagen value

-- Number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- Better editor UI
vim.opt.number = true
-- vim.opt.numberwidth = 3
vim.opt.relativenumber = false

-- Makes neovim and host OS clipboard play nicely with each other
vim.opt.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.hlsearch = true

-- Undo and backup options
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.directory = vim.fn.stdpath('data') .. 'tmp'
vim.opt.undodir = vim.fn.stdpath('data') .. 'undo'

-- Remember 1000 items in commandline history
vim.opt.history = 1000

-- window options
vim.opt.splitbelow = true
vim.opt.splitright = true

-- folding options: recommended by nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

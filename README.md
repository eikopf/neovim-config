> my potions are too strong for you, traveller; you can't handle my potions!

This repository contains my personal Neovim configuration, written in Fennel and configured to compile itself using [`nfnl`](https://github.com/Olical/nfnl). It's the replacement for an older configuration written in Lua, which in turn was originally derived from [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim/tree/master).

# Compilation
If you intend to use this configuration (and really, you shouldn't be), the first launch handles compilation automatically. `init.lua` bootstraps `lazy.nvim` and `nfnl`, compiles all Fennel sources to `lua/`, prints a message, and exits; the next time you start Neovim everything loads normally.

> my potions are too strong for you, traveller; you can't handle my potions!

This repository contains my personal Neovim configuration, written in Fennel and configured to compile itself using [`nfnl`](https://github.com/Olical/nfnl). It's the replacement for an older configuration written in Lua, which in turn was originally derived from [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim/tree/master).

# Compilation
If you intend to use this configuration (and really, you shouldn't be), the first launch handles compilation automatically. `init.lua` bootstraps `lazy.nvim` and `nfnl`, compiles all Fennel sources to `lua/`, prints a message, and exits; the next time you start Neovim everything loads normally.

You can also trigger compilation manually by opening any `.fnl` file and running `:NfnlCompileAllFiles` — useful if you have deleted the `lua/` directory and don't want to restart.

# Licensing
This configuration is provided under the UNLICENSE, so there are no restrictions or obligations associated with copying or otherwise using portions of it. If you believe I have accidentally included or retained portions of code that are not licensed under the UNLICENSE, then please open an issue so that it can be replaced as quickly as possible.

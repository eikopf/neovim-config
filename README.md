> my potions are too strong for you, traveller; you can't handle my potions!

This repository contains my personal Neovim configuration, written in Fennel and configured to compile itself using [`nfnl`](https://github.com/Olical/nfnl). It's the replacement for an older configuration written in Lua, which in turn was originally derived from [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim/tree/master).

# Compilation
If you intend to use this configuration (and really, you shouldn't be), then you're likely to run into some awful error messages the first time you open Neovim. This is due to a bug (that I'll probably get around to fixing eventually) that prevents `nfnl` from compiling the Fennel files before `init.lua` tries to source them.

The solution is to open `fnl/config.fnl` (or any other `.fnl` file) and run `:NfnlCompileAllFiles`. After that, you'll just need to restart Neovim to load everything properly.

# Licensing
This configuration is provided under the UNLICENSE, so there are no restrictions or obligations associated with copying or otherwise using portions of it. If you believe I have accidentally included or retained portions of code that are not licensed under the UNLICENSE, then please open an issue so that it can be replaced as quickly as possible.

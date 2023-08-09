# Neovim Config
This repository is for my own personal Neovim configuration: *use it at your peril!*

## Plugins
> This list is probably incomplete; check `lazy-lock.json` for an accurate version.

- `which-key.nvim`: as a keybinding API and familiarity tool.
- `telescope.nvim`: basically essential for searching.
- `projects.nvim`: a replacement for Emacs' `projectile`.
- `obsidian.nvim`: for interfacing with notes.
- `cmp.nvim`: a better completions engine.
- `vim-fugitive`: git integration.
- `oil.nvim`: because NetRW and Ranger both suck.
- `rust-tools.nvim`: better Rust integration.
- `lazy.nvim`: at least it isn't Packer.
- `mason.nvim`: basically essential for LSP integration.
- `cmp-latex-symbols`: Julia-style latex-unicode substitutions.

## TODOs
- Set Julia to use a precompiled LanguageServer.jl binary
- Make more keybindings
    - Set `<leader>q*` bindings to quit operations
    - Set `<leader>
- Add specific run commands for different languages

## Notes
- I want to add Typst support, but typst.nvim seems to be dead :(
- The devil is real, and his name is vimscript.

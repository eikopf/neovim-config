;; kevinhwang91/nvim-ufo --- ultrafolding in neovim

(set vim.o.foldcolumn :1)
(set vim.o.foldlevel 99)
(set vim.o.foldlevelstart 99)
(set vim.o.foldenable true)

(local opts {:provider_selector #[:treesitter :indent]})

{1 :kevinhwang91/nvim-ufo :dependencies [:kevinhwang91/promise-async] : opts}


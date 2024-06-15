;; kevinhwang91/nvim-ufo --- ultrafolding in neovim

;; BUG: sometimes large folds will reopen after writing to file?
;; this seems to affect fennel in particular, but i haven't done
;; enough testing with other filetypes to be sure

(set vim.o.foldcolumn :0)

;; use :1 for column symbols
(set vim.o.foldlevel 99)
(set vim.o.foldlevelstart 99)
(set vim.o.foldenable true)

(local filetype-providers {:git ""})
(local default-providers [:treesitter :indent])

(fn provider-selector [_bufnr filetype _buftype]
  "
  Looks up and returns the value of `filetype` in 
  `filetype-providers`, or `default-providers` if
  `filetype` is unmapped.
  "
  (or (?. filetype-providers filetype) default-providers))

(local opts {:provider_selector provider-selector})

{1 :kevinhwang91/nvim-ufo :dependencies [:kevinhwang91/promise-async] : opts}


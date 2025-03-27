;; catppuccin/nvim (colorscheme)

(local integrations {:gitsigns true
                     :treesitter true
                     :nvim-ufo true
                     :octo true
                     :telescope {:enabled true}
                     ;; trouble.nvim
                     :lsp_trouble true})

{1 :catppuccin/nvim :priority 1000 :name :catpuccin : integrations}

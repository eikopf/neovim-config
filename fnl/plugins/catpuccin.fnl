;; catppuccin/nvim (colorscheme)

(local integrations {:gitsigns true
                     :treesitter true
                     :nvim-ufo true
                     :octo true
                     :telescope {:enabled true}
                     ;; trouble.nvim
                     :lsp_trouble true})

;; :main is needed because the :name above (note the typo) doesn't match the
;; plugin's actual lua module, so it can't be resolved automatically
{1 :catppuccin/nvim
 :name :catpuccin
 :main :catppuccin
 :opts {: integrations}}

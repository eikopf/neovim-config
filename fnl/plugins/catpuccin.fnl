;; catppuccin/nvim (colorscheme)

(local integrations {:gitsigns true
                     :treesitter true
                     :nvim-ufo true
                     :octo true
                     :telescope {:enabled true}
                     ;; trouble.nvim
                     :lsp_trouble true})

;; NOTE: the plugin is installed under the (typo'd) name "catpuccin", but
;; its lua module is spelled correctly
(fn setup [_self]
  (let [catppuccin (require :catppuccin)]
    (catppuccin.setup {: integrations})))

{: setup}

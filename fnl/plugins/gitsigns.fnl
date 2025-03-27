;; gitsigns.nvim -- git status symbols in the gutter

;; refer to :help gitsigns.txt
(local signs {:add {:text "┃"}
              :change {:text "┃"}
              :delete {:text "_"}
              :topdelete {:text "‾"}
              :changedelete {:text "┆"}})

{1 :lewis6991/gitsigns.nvim :opts {: signs}}

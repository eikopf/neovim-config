;; gitsigns.nvim -- git status symbols in the gutter

;; refer to :help gitsigns.txt
(local signs {:add {:text "┃"}
              :change {:text "┃"}
              :delete {:text "_"}
              :topdelete {:text "‾"}
              :changedelete {:text "┆"}})

(fn setup [_self]
  (let [gitsigns (require :gitsigns)]
    (gitsigns.setup {: signs})))

{: setup}

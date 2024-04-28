;; nvim-autopairs -- multicharacter bracket completion

;; the README for nvim-autopairs lists some config details
;; for coq_nvim users -- refer to this if coq and autopairs
;; interactly weirdly

{1 :windwp/nvim-autopairs
 :event :InsertEnter
 :opts {:disable_filetype [:TelescopePrompt :vim]}}


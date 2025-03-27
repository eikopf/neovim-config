;; trouble.nvim -- a nicer quickfix list
;; INFO: running version 2; set branch = "dev" to use the version 3 beta

;; trouble provides the following commands:
;; - Trouble [mode]
;; - TroubleClose [mode]
;; - TroubleToggle [mode]
;; - TroubleRefresh
;; refer to :help trouble.nvim-trouble-v2-usage for details

;; further details here: https://github.com/folke/trouble.nvim

{1 :folke/trouble.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :opts {:auto_close true}
 :cmd [:Trouble :TroubleClose :TroubleToggle :TroubleRefresh :TodoTrouble]
 :lazy true}

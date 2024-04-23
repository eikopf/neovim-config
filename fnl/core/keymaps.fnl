;; GLOBAL KEYMAPS

;; simple helper function for defining keybindings
;; mode => string or list of strings
;; binding => string
;; command => string or function
;; opts => a table (refer to :help nvim_set_keymap for keys)
(lambda map [mode binding command ?opts]
  "Calls vim.keymap.set with the given arguments."
  (let [bind _G.vim.keymap.set]
    (bind mode binding command opts)))

;; basic navigation
(map :n "-" "<cmd>Oil<cr>" { :desc "Open parent directory" })

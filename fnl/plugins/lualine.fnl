;; lualine.nvim -- fast statusbar written in lua

(fn pwd []
  "
  Returns current path relative to user's home directory.
  "
  (vim.fn.expand "%:~:h"))

;; refer to :help lualine.txt for all options
(local options {:icons_enabled true
                :theme :auto
                :component_separators "|"
                :section_separators ""})

;; define the elements of the statusbar
(local sections {:lualine_a [:mode]
                 :lualine_b [:branch :diff :diagnostics]
                 :lualine_c [:filename pwd]
                 :lualine_x []
                 :lualine_y [:encoding :filetype]
                 :lualine_z [:location]})

{1 :nvim-lualine/lualine.nvim :opts {: options : sections} :event :UiEnter}

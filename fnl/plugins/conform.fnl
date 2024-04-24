;; conform.nvim -- code formatting plugin

(local opts {})

{ 1      :stevearc/conform.nvim
  :event [ :BufWritePre ]
  :cmd   [ :ConformInfo ]
  :keys  [ :<leader>lf  ]   ;; defined in core/keymaps.fnl
  : opts }

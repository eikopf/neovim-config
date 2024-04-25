;; conform.nvim -- code formatting plugin

(local formatters { :lua          [ :stylua ]
                    :python         [ :ruff ]
                    :javascript [ :prettier ]
                    :rust        [ :rustfmt ] })

(local opts { :formatters_by_ft formatters
              :format_on_save { :timeout_ms 500 :lsp_fallback true }})

{ 1      :stevearc/conform.nvim
  :event [ :BufWritePre ]
  :cmd   [ :ConformInfo ]
  :keys  [ :<leader>lf  ]   ;; defined in core/keymaps.fnl
  : opts }

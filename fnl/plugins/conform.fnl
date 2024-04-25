;; conform.nvim -- code formatting plugin

(local formatters {:fennel [:fnlfmt]
                   :javascript [:prettier]
                   :lua [:stylua]
                   :python [:ruff]
                   :rust [:rustfmt]})

(local opts {:formatters_by_ft formatters
             :format_on_save {:timeout_ms 500 :lsp_fallback true}})

{1 :stevearc/conform.nvim
 :event [:BufWritePre]
 :cmd [:ConformInfo]
 :keys [:<leader>lf]
 ;; defined in core/keymaps.fnl
 : opts}


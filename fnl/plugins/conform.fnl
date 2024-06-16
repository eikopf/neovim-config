;; conform.nvim -- code formatting plugin

(local formatters {:clojure      [:cljfmt]
                   :javascript [:prettier]
                   :lua          [:stylua]
                   :python         [:ruff]
                   :rust        [:rustfmt]})

(local opts {:formatters_by_ft formatters
             :format_on_save {:timeout_ms 500 :lsp_fallback true}})

{1 :stevearc/conform.nvim
 :event [:BufWritePre]
 :cmd [:ConformInfo]
 ;; defined in core/keymaps.fnl
 :keys [:<leader>cf]
 : opts}


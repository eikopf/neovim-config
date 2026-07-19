;; conform.nvim -- code formatting plugin

(import-macros {: toggle} :lib.macros)

(local formatters {:clojure [:cljfmt]
                   :fennel [:fnlfmt]
                   :javascript [:prettierd]
                   :lua [:stylua]
                   :nix [:nixfmt]
                   :ocaml [:ocamlformat]
                   :python [:ruff]
                   :rust [:rustfmt]
                   :typst [:typstyle]})

(λ format-on-save [bufnr]
  (if (not (or (?. vim.g :disable_autoformat)
               (?. vim.b bufnr :disable_autoformat)))
      {:timeout_ms 500 :lsp_fallback true}))

(λ make-user-commands []
  (local make #(vim.api.nvim_create_user_command $1 $3 $2))
  (make :FormatDisable {:desc "Disable format-on-save" :bang true}
        (fn [args]
          (if args.bang (set vim.b.disable_autoformat true)
              (set vim.g.disable_autoformat true))))
  (make :FormatEnable {:desc "Enable format-on-save"}
        (fn []
          (set vim.b.disable_autoformat false)
          (set vim.g.disable_autoformat false)))
  (make :FormatToggle {:desc "Toggle format-on-save" :bang true}
        (fn [args]
          (if args.bang (toggle vim.b.disable_autoformat)
              (toggle vim.g.disable_autoformat)))))

(local opts {:formatters_by_ft formatters
             :format_on_save format-on-save
             :formatters {:rustfmt {:options {:nightly true}}}})

{:src :stevearc/conform.nvim
 :setup (fn []
          (make-user-commands)
          ((. (require :conform) :setup) opts))}

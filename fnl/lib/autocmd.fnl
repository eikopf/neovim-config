;; autocommand utilities

(λ group [name ?clear]
  "Creates (or returns) an autocommand group called `name`."
  (vim.api.nvim_create_augroup name
                               {:clear (case ?clear
                                         :clear true
                                         :noclear false
                                         _ nil)}))

(λ create [event pattern action ?group]
  "Registers an autocommand for `event` and returns `?group`."
  (vim.api.nvim_create_autocmd event
                               {: pattern
                                :group ?group
                                (case (type action)
                                   :string :command
                                   :function :callback) action})
  ?group)

(λ create-once [event pattern action ?group]
  "Registers an autocommand for `event` with the `once` option and returns `?group`."
  (vim.api.nvim_create_autocmd event
                               {: pattern
                                :group ?group
                                :once true
                                (case (type action)
                                   :string :command
                                   :function :callback) action})
  ?group)

{: group : create : create-once}

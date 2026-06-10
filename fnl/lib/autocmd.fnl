;; autocommand utilities, built around a reified `Group` type
;;
;; a `Group` wraps an augroup id and registers autocommands in itself via
;; its `on` and `on-once` methods, which return `self` for chaining.

(local Group {})
(set Group.__index Group)

(λ create [event pattern action ?opts]
  "Registers an autocommand for `event` and returns its id; `?opts` may set
  `:group` and `:once`."
  (vim.api.nvim_create_autocmd event
                               {: pattern
                                :group (?. ?opts :group)
                                :once (?. ?opts :once)
                                (case (type action)
                                  :string :command
                                  :function :callback) action}))

(λ group [name ?clear]
  "Creates (or returns) an autocommand group called `name` as a `Group`."
  (setmetatable {: name
                 :id (vim.api.nvim_create_augroup name
                                                  {:clear (case ?clear
                                                            :clear true
                                                            :noclear false
                                                            _ nil)})}
                Group))

(λ Group.on [self event pattern action]
  "Registers an autocommand for `event` in this group."
  (create event pattern action {:group self.id})
  self)

(λ Group.on-once [self event pattern action]
  "Registers a once-only autocommand for `event` in this group."
  (create event pattern action {:group self.id :once true})
  self)

{: Group : group : create}

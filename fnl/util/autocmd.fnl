;; autocommand utilities

(λ make-augroup [name ?clear]
   "Creates (or returns) an autocommand group called `name`."
   (vim.api.nvim_create_augroup name {:clear (case ?clear
                                              :clear   true
                                              :noclear false
                                              _        nil)}))

(λ autocmd [event pattern action ?group]
   "Registers an autocommand for `event` and returns `?group`."
   (vim.api.nvim_create_autocmd event
                                {: pattern
                                 :group ?group
                                 (case (type action)
                                   :string   :command
                                   :function :callback) action})
   ?group)


;; return (runtime) public interface
{: make-augroup
 : autocmd}
 
 

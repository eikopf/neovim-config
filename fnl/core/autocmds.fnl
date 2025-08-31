;; custom autocommands and autogroups

(import-macros {: def-autogroup} :lib.macros)

(fn make-startup-bindings []
  "Hacky way to insert key bindings into startup buffer."
  (vim.keymap.set :n "-" :<Cmd>Oil<CR> {:buffer true :nowait true :silent true})
  (vim.keymap.set :n :<C-l> "<Cmd>lua MiniStarter.eval_current_item()<CR>"
                  {:buffer true :nowait true :silent true})
  (vim.keymap.set :n :<C-j>
                  "<Cmd>lua MiniStarter.update_current_item('next')<CR>"
                  {:buffer true :nowait true :silent true})
  (vim.keymap.set :n :<C-k>
                  "<Cmd>lua MiniStarter.update_current_item('prev')<CR>"
                  {:buffer true :nowait true :silent true}))

(fn setup [_self]
  (let [autocmd (require :lib.autocmd)]
    ;; terminal autocommands
    (def-autogroup :terminal :clear
      (autocmd.create :TermOpen "*" "setlocal nonumber"))
    ;; markdown autocommands
    (def-autogroup :markdown :clear
      (autocmd.create :FileType :markdown "setlocal linebreak"))
    (def-autogroup :icalendar :clear
      (autocmd.create [:BufRead :BufNewFile] :*.ics "set fileformat=dos"))
    (def-autogroup :pollen :clear
      (autocmd.create :FileType :pollen "setlocal linebreak"))
    (def-autogroup :startup-extras
      :clear
      ;; hacky solution for getting the value of lazy.stats.startuptime to render
      (autocmd.create-once :User :MiniStarterOpened "lua MiniStarter.refresh()")
      (autocmd.create :User :MiniStarterOpened make-startup-bindings))))

{: setup}

;;; configuration for the default buffer at start-up

(local autocmd (require :lib.autocmd))

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

(fn init []
  ;; the once-autocmd makes lazy.stats().startuptime render correctly,
  ;; since it must be refreshed after the UIEnter event has fired
  (-> (autocmd.group :startup-extras :clear)
      (: :on-once :User :MiniStarterOpened "lua MiniStarter.refresh()")
      (: :on :User :MiniStarterOpened make-startup-bindings)))

;; NOTE: we're currently using mini.nvim#starter for the dashboard, which must
;; be refreshed immediately when it is first shown to make sure that the
;; lazy.stats().startuptime value has been calculated (the UIEnter event must
;; have run for this). it seems like snacks.nvim#dashboard doesn't have this
;; problem, so perhaps switching to it might be better at some point in the
;; future

(fn lazy-stats []
  (let [{: stats} (require :lazy)]
    (stats)))

(fn header []
  (let [{: count : loaded : startuptime} (lazy-stats)]
    (string.format "loaded %d/%d plugins in %.3fms" loaded count startuptime)))

(fn footer []
  "")

(fn open-items []
  (let [{: goto-dir-and-edit : open-scratch-buffer : open-short-term} (require :core.keymaps)
        item (fn [name action] {: name : action :section :open})]
    [(item :projects #(goto-dir-and-edit "~/projects"))
     (item :journal :JournalOpen)
     (item :config #(goto-dir-and-edit (vim.fn.stdpath :config)))
     (item :lazy :Lazy)
     (item :terminal open-short-term)
     (item "scratch buffer" open-scratch-buffer)]))

(fn journal-items []
  (let [item (fn [name action] {: name : action :section :journal})]
    [(item :todo :JournalTodo)
     (item :daily :JournalDaily)
     (item :weekly :JournalWeekly)
     (item :quarterly :JournalQuarterly)]))

(fn recent-files []
  (let [starter (require :mini.starter)
        items ((starter.sections.recent_files 15))]
    (icollect [_ {: name : action} (ipairs items)]
      {: name : action :section "recent files"})))

(fn actions []
  (let [item (fn [name action] {: name : action :section :actions})]
    [(item :quit :q)]))

(fn items []
  [open-items journal-items recent-files actions])

(λ opts [_plugin _opts]
  (let [items (items)
        footer (footer)]
    {: header : items : footer :silent true}))

{1 :nvim-mini/mini.starter :version "*" : init : opts :enabled false}

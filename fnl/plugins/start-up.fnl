;;; configuration for the default buffer at start-up
;;;
;;; NOTE: currently disabled --- this module is not loaded in config.fnl,
;;; and nvim-mini/mini.starter is not listed in core/pack.fnl

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

(fn header []
  (let [plugins (vim.pack.get nil {:info false})
        active (icollect [_ plugin (ipairs plugins)]
                 (if plugin.active plugin))]
    (string.format "loaded %d/%d plugins" (length active) (length plugins))))

(fn footer []
  "")

(fn open-items []
  (let [{: goto-dir-and-edit : open-scratch-buffer : open-short-term} (require :core.keymaps)
        item (fn [name action] {: name : action :section :open})]
    [(item :projects #(goto-dir-and-edit "~/projects"))
     (item :journal :JournalOpen)
     (item :config #(goto-dir-and-edit (vim.fn.stdpath :config)))
     (item :plugins #(vim.pack.update))
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

(fn setup [_self]
  (-> (autocmd.group :startup-extras :clear)
      (: :on :User :MiniStarterOpened make-startup-bindings))
  (let [starter (require :mini.starter)]
    (starter.setup {: header :items (items) :footer (footer) :silent true})))

{: setup}

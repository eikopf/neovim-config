;; configuration for the default buffer at start-up

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

(fn recent-files []
  (let [starter (require :mini.starter)
        items ((starter.sections.recent_files 10))]
    (icollect [_ {: name : action} (ipairs items)]
      {: name : action :section "recent files"})))

(fn actions []
  (let [item (fn [name action] {: name : action :section :actions})]
    [(item "open or create daily journal entry" :JournalToday) (item :quit :q)]))

(fn items []
  [open-items recent-files actions])

(λ opts [_plugin _opts]
  (let [items (items)
        footer (footer)]
    {: header : items : footer :silent true}))

{1 :nvim-mini/mini.starter :version "*" : opts}

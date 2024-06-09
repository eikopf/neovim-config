;; nvim-orgmode/orgmode -- an orgmode clone for neovim

(fn org-root []
  "Returns the root org directory."
  (vim.fn.expand "~/Documents/org"))

(fn opts []
  (let [root (org-root)]
    {:org_agenda_files (.. root "/**/*")
     :org_default_notes_file (.. root :/refile.org)
     :org_todo_keywords [:TODO :WAITING "|" :DONE :DELEGATED]
     :org_startup_folded :content}))

{1 :nvim-orgmode/orgmode :event :VeryLazy :ft [:org] : opts}


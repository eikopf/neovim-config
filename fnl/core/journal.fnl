;; personal journal setup

(local {: hostname-prefix} (require :util.system))
(local {: now} (require :util.time))

(λ journal-dir-path []
  "Returns the path to the journal directory, or `nil` if it is unknown."
  (case (hostname-prefix)
    :pilatus "~/Documents/Journal"
    _ nil))

(λ entry-filename-on [{: year : month : day}]
  "Returns the filename of the journal entry for the given date."
  (.. (string.format "%04d" year) (string.format "%02d" month)
      (string.format "%02d" day) :.md))

(λ entry-filename-today []
  "Returns the filename of the journal entry for today."
  (entry-filename-on (now)))

;; defining user commands with associated callbacks

(fn open-journal []
  (vim.cmd.edit (journal-dir-path)))

(fn edit-journal-today []
  (vim.cmd.edit (vim.fs.joinpath (journal-dir-path) (entry-filename-today))))

(vim.api.nvim_create_user_command :JournalOpen open-journal {})
(vim.api.nvim_create_user_command :JournalToday edit-journal-today {})

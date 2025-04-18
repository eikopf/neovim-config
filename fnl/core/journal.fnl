;; personal journal setup

(local system (require :lib.system))
(local time (require :lib.time))

(λ journal-dir-path []
  "Returns the path to the journal directory, or `nil` if it is unknown."
  (case (system.hostname-prefix)
    :pilatus "~/Documents/Journal"
    _ nil))

(λ entry-filename-on [{: year : month : day}]
  "Returns the filename of the journal entry for the given date."
  (.. (string.format "%04d" year) (string.format "%02d" month)
      (string.format "%02d" day) :.md))

(λ entry-filename-today []
  "Returns the filename of the journal entry for today."
  (entry-filename-on (time.now)))

(fn open-journal []
  (vim.cmd.edit (journal-dir-path)))

(fn edit-journal-today []
  (vim.cmd.edit (vim.fs.joinpath (journal-dir-path) (entry-filename-today))))

(fn setup [_self]
  (vim.api.nvim_create_user_command :JournalOpen open-journal {})
  (vim.api.nvim_create_user_command :JournalToday edit-journal-today {}))

{: journal-dir-path
 : entry-filename-on
 : entry-filename-today
 : open-journal
 : edit-journal-today
 : setup}

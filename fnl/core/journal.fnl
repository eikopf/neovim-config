;; personal journal setup

(local system (require :lib.system))
(local time (require :lib.time))

(local ext :.md)

(λ journal-dir-path []
  "Returns the path to the journal directory, or `nil` if it is unknown."
  (case (system.hostname-prefix)
    :pilatus "~/Documents/Journal"
    :RIGI "~/iCloudDrive/Documents/Journal"
    _ nil))

(λ daily-entry-filename-on [{: year : month : day}]
  "Returns the filename of the daily journal entry for the given date."
  (.. (string.format "%04d" year) (string.format "%02d" month)
      (string.format "%02d" day) ext))

(λ weekly-entry-filename-on [{: year &as date}]
  "Returns the filename of the weekly journal entry for the given date."
  (let [week (time.week date)]
    (.. (string.format "%04d" year) :W (string.format "%02d" week) ext)))

(λ quarterly-entry-filename-on [{: year &as date}]
  "Returns the filename of the quarterly journal entry for the given date."
  (let [quarter (time.quarter date)]
    (.. (string.format "%04d" year) :Q (string.format "%01d" quarter) ext)))

(fn open-journal []
  (vim.cmd.edit (journal-dir-path)))

(fn edit-journal [filename]
  (vim.cmd.edit (vim.fs.joinpath (journal-dir-path) filename)))

(fn edit-journal-today-daily []
  (edit-journal (daily-entry-filename-on (time.now))))

(fn edit-journal-today-weekly []
  (edit-journal (weekly-entry-filename-on (time.now))))

(fn edit-journal-today-quarterly []
  (edit-journal (quarterly-entry-filename-on (time.now))))

(fn setup [_self]
  (vim.api.nvim_create_user_command :JournalOpen open-journal {})
  (vim.api.nvim_create_user_command :JournalToday edit-journal-today-daily {})
  (vim.api.nvim_create_user_command :JournalDaily edit-journal-today-daily {})
  (vim.api.nvim_create_user_command :JournalWeekly edit-journal-today-weekly {})
  (vim.api.nvim_create_user_command :JournalQuarterly
                                    edit-journal-today-quarterly {}))

{: journal-dir-path
 : daily-entry-filename-on
 : weekly-entry-filename-on
 : quarterly-entry-filename-on
 : open-journal
 : edit-journal
 : edit-journal-today-daily
 : edit-journal-today-weekly
 : edit-journal-today-quarterly
 : setup}

;; markdown utilities

(local checked-pattern "^(%s*%- )%[[xX]%]")
(local unchecked-pattern "^(%s*%- )%[ %]")

;; matches a list item with a checked checkbox, capturing its indentation
(local checked-item-pattern "^(%s*)%- %[[xX]%]")

(λ line-contains-checked [line]
  "Returns `true` if `line` contains a checked checkbox."
  (not= (line:find checked-pattern) nil))

(λ line-contains-unchecked [line]
  "Returns `true` if `line` contains an unchecked checkbox."
  (not= (line:find unchecked-pattern) nil))

(λ check [line]
  "Checks the first unchecked checkbox in the given string if any."
  (let [(line success) (line:gsub unchecked-pattern "%1[x]" 1)
        success (if (= success 1) true false)]
    {: line : success}))

(λ uncheck [line]
  "Unchecks the first checked checkbox in the given string if any."
  (let [(line success) (line:gsub checked-pattern "%1[ ]" 1)
        success (if (= success 1) true false)]
    {: line : success}))

(λ toggle-check [line]
  "Toggles the first checkbox in the given string if any."
  (if (line-contains-unchecked line) (check line)
      (line-contains-checked line) (uncheck line)
      {: line :success false}))

(λ toggle-check-on-cursor-line []
  (let [buf (vim.api.nvim_buf_get_number 0)
        cursor (vim.api.nvim_win_get_cursor 0)
        cursor-line (- (. cursor 1) 1)
        current-line (or (. (vim.api.nvim_buf_get_lines buf cursor-line
                                                        (+ cursor-line 1) false)
                            1) "")
        {: line : success} (toggle-check current-line)]
    (if success
        (do
          (vim.api.nvim_buf_set_lines buf cursor-line (+ cursor-line 1) false
                                      [line])
          (vim.api.nvim_win_set_cursor 0 cursor)
          nil))))

(λ checked-item-ranges [lines]
  "Returns a list of `{: first : last}` ranges (1-indexed, inclusive) covering
  each checked item in `lines` together with its sub-lines, i.e. any
  immediately following lines with deeper indentation. A blank line ends an
  item."
  (let [ranges []]
    (var i 1)
    (while (<= i (length lines))
      (let [line (. lines i)
            indent (line:match checked-item-pattern)]
        (if indent
            (do
              (var j (+ i 1))
              (while (and (<= j (length lines))
                          (let [line (. lines j)]
                            (and (not (line:match "^%s*$"))
                                 (> (length (line:match "^%s*"))
                                    (length indent)))))
                (set j (+ j 1)))
              (table.insert ranges {:first i :last (- j 1)})
              (set i j))
            (set i (+ i 1)))))
    ranges))

(λ archive-path [source-path]
  "Maps a Markdown file path to its sibling archive path, e.g. mapping
  `foo.md` to `foo.archive.md`."
  (let [(path count) (source-path:gsub "%.md$" :.archive.md)]
    (if (= count 0) (.. source-path :.archive.md) path)))

(λ archive-entry [date source-name lines]
  "Renders the archived `lines` under a dated heading, as a list of lines."
  (vim.list_extend ["" (.. "## " date " (from " source-name ")") ""] lines))

(λ archive-checked-on-current-buffer []
  "Moves every checked item (and its sub-items) from the current buffer into
  its sibling archive file, appended under a dated heading."
  (let [buf (vim.api.nvim_get_current_buf)
        source-path (vim.api.nvim_buf_get_name buf)
        lines (vim.api.nvim_buf_get_lines buf 0 -1 false)
        ranges (checked-item-ranges lines)]
    (if (= source-path "")
        (vim.notify "buffer has no file path; save it first"
                    vim.log.levels.ERROR)
        (= (length ranges) 0)
        (vim.notify "no checked items to archive" vim.log.levels.INFO)
        (let [path (archive-path source-path)
              source-name (vim.fn.fnamemodify source-path ":t")
              archived []]
          (each [_ {: first : last} (ipairs ranges)]
            (for [i first last]
              (table.insert archived (. lines i))))
          (case (io.open path :a)
            file (do
                   (file:write (.. (table.concat (archive-entry (os.date "%Y-%m-%d")
                                                                source-name
                                                                archived)
                                                 "\n")
                                   "\n"))
                   (file:close)
                   ;; remove ranges in reverse to keep earlier indices valid
                   (for [i (length ranges) 1 -1]
                     (let [{: first : last} (. ranges i)]
                       (vim.api.nvim_buf_set_lines buf (- first 1) last false
                                                   [])))
                   (vim.notify (string.format "archived %d item(s) to %s"
                                              (length ranges) path)
                               vim.log.levels.INFO))
            _ (vim.notify (.. "could not open archive file: " path)
                          vim.log.levels.ERROR))))))

{: checked-pattern
 : unchecked-pattern
 : line-contains-checked
 : line-contains-unchecked
 : check
 : uncheck
 : toggle-check
 : toggle-check-on-cursor-line
 : checked-item-ranges
 : archive-path
 : archive-entry
 : archive-checked-on-current-buffer}

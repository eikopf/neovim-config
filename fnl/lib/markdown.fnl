;; markdown utilities

(local checked-pattern "%[x%]")
(local unchecked-pattern "%[ %]")

(λ line-contains-checked [line]
  "Returns `true` if `line` contains a checked checkbox."
  (not= (line:find checked-pattern) nil))

(λ line-contains-unchecked [line]
  "Returns `true` if `line` contains an unchecked checkbox."
  (not= (line:find unchecked-pattern) nil))

(λ check [line]
  "Checks the first unchecked checkbox in the given string if any."
  (let [(line success) (line:gsub unchecked-pattern checked-pattern 1)
        success (if (= success 1) true false)]
    {: line : success}))

(λ uncheck [line]
  "Unchecks the first checked checkbox in the given string if any."
  (let [(line success) (line:gsub checked-pattern unchecked-pattern 1)
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

{: checked-pattern
 : unchecked-pattern
 : line-contains-checked
 : line-contains-unchecked
 : check
 : uncheck
 : toggle-check
 : toggle-check-on-cursor-line}

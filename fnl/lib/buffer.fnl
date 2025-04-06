;; buffer manipulation utilities

(λ create [?opts]
  "Creates a new buffer and returns its handle, or `nil` on error."
  (let [listed (or (?. ?opts :listed) false)
        scratch (or (?. ?opts :scratch) false)
        buf (vim.api.nvim_create_buf listed scratch)]
    (if (not= buf 0) buf nil)))

(λ open [buf ?after]
  "Opens the given buffer in the current window, and calls `?after` with `buf` as a parameter if it isn't `nil`."
  (vim.api.nvim_win_set_buf 0 buf)
  (when ?after (?after buf))
  buf)

(λ rename! [buf name]
  "Sets the name of `buf` to the given `name`."
  (vim.api.nvim_buf_set_name buf name)
  nil)

(λ set! [buf name value]
  "Sets the option `name` to `value` in the given `buf`."
  (vim.api.nvim_set_option_value name value {: buf})
  nil)

(λ set-lines! [buf start end lines ?opts]
  "Replaces the lines in `buf` from `start` to `end` with `lines`."
  (let [strict (or (?. ?opts :strict_indexing) false)]
    (vim.api.nvim_buf_set_lines buf start end strict lines)))

{: create : open : rename! : set! : set-lines!}

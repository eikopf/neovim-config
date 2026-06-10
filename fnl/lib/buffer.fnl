;; buffer manipulation utilities, built around a reified `Buffer` type
;;
;; a `Buffer` wraps a raw buffer handle as `{:bufnr n}` with a metatable
;; carrying methods; the mutating methods return `self`, so calls can be
;; chained with `->` or `doto`.

(local Buffer {})
(set Buffer.__index Buffer)

(set Buffer.__tostring
     (fn [self] (string.format "#<buffer %d>" self.bufnr)))

(λ make [bufnr]
  "Wraps the raw buffer handle `bufnr` as a `Buffer`."
  (setmetatable {: bufnr} Buffer))

(λ create [?opts]
  "Creates a new `Buffer`; `?opts` may set `:listed` and `:scratch`."
  (let [listed (or (?. ?opts :listed) false)
        scratch (or (?. ?opts :scratch) false)
        bufnr (vim.api.nvim_create_buf listed scratch)]
    (assert (not= bufnr 0) "lib.buffer: could not create a new buffer")
    (make bufnr)))

(λ current []
  "Returns the current buffer as a `Buffer`."
  (make (vim.api.nvim_get_current_buf)))

(λ Buffer.open [self ?after]
  "Opens the buffer in the current window, then calls `?after` with the
  buffer as a parameter if it is non-nil."
  (vim.api.nvim_win_set_buf 0 self.bufnr)
  (when ?after (?after self))
  self)

(λ Buffer.rename! [self name]
  "Sets the name of the buffer to the given `name`."
  (vim.api.nvim_buf_set_name self.bufnr name)
  self)

(λ Buffer.name [self]
  "Returns the full name of the buffer."
  (vim.api.nvim_buf_get_name self.bufnr))

(λ Buffer.set! [self name value]
  "Sets the buffer-local option `name` to `value`."
  (vim.api.nvim_set_option_value name value {:buf self.bufnr})
  self)

(λ Buffer.lines [self ?start ?end]
  "Returns the lines of the buffer from `?start` to `?end` (0-indexed,
  end-exclusive), defaulting to the whole buffer."
  (vim.api.nvim_buf_get_lines self.bufnr (or ?start 0) (or ?end -1) false))

(λ Buffer.set-lines! [self start end lines ?opts]
  "Replaces the lines of the buffer from `start` to `end` with `lines`."
  (let [strict (or (?. ?opts :strict_indexing) false)]
    (vim.api.nvim_buf_set_lines self.bufnr start end strict lines))
  self)

{: Buffer : create : current : make}

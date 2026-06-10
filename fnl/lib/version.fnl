;; a thin veneer over vim.version
;;
;; both `(vim.version)` and `vim.version.parse` already return `vim.Version`
;; tables carrying `cmp` and the comparison metamethods (`__eq`, `__lt`,
;; `__le`), and the comparison functions below accept strings as well as
;; `vim.Version` values, so this module only re-exports them.

(λ nvim []
  "Returns the version of the current Neovim instance as a `vim.Version`."
  (vim.version))

{: nvim
 :cmp vim.version.cmp
 :eq vim.version.eq
 :ge vim.version.ge
 :gt vim.version.gt
 :le vim.version.le
 :lt vim.version.lt
 :parse vim.version.parse
 :range vim.version.range}

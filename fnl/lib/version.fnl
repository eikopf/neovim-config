;; a thin wrapper around vim.version

(local mt {:__le vim.version.le :__lt vim.version.lt :__eq vim.version.eq})

(λ make [version]
  "Adds methods and a metatable to the given `version`."
  (doto version
    (setmetatable mt)
    (tset :cmp vim.version.cmp)
    (tset :le vim.version.le)
    (tset :lt vim.version.lt)
    (tset :ge vim.version.ge)
    (tset :gt vim.version.gt)))

(λ nvim []
  "Returns the version of the current Neovim instance."
  (make (vim.version)))

(λ parse [version ?opts]
  "Parses the given `version` string."
  (make (vim.version.parse version ?opts)))

(λ parse* [version ?opts]
  "Parses the given `version` if it is a string, or returns it if it is already a version."
  (if (not= (getmetatable version) mt) (parse version ?opts) version))

(λ cmp [lhs rhs]
  "Compares the given versions, returning -1, 0, or 1. See :help vim.version.cmp."
  (let [lhs (parse* lhs)
        rhs (parse* rhs)]
    (lhs:cmp rhs)))

(λ eq [lhs rhs]
  (= (cmp lhs rhs) 0))

(λ le [lhs rhs]
  (not= (cmp lhs rhs) 1))

(λ lt [lhs rhs]
  (= (cmp lhs rhs) -1))

(λ ge [lhs rhs]
  (not (lt lhs rhs)))

(λ gt [lhs rhs]
  (not (le lhs rhs)))

{: cmp
 : eq
 : ge
 : gt
 : le
 : lt
 : make
 : nvim
 : parse
 : parse*
 :range vim.version.range}

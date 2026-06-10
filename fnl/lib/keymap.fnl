;; some common keymapping functions wrapping which-key.nvim
;;
;; which-key is required lazily inside each function so that loading this
;; module doesn't depend on plugin load order.

(λ group [lhs name ?buffer]
  "Defines `lhs` as a keybinding group with the given `name`."
  (let [wk (require :which-key)]
    (wk.add {1 lhs :group name :buffer ?buffer})))

(λ map [lhs rhs desc ?mode ?buffer]
  "Creates a new keybinding for `lhs`."
  (let [wk (require :which-key)]
    (wk.add {1 lhs 2 rhs : desc :mode (or ?mode :n) :buffer ?buffer})))

(λ map* [mode lhs rhs ?opts]
  "Creates a new keybinding for `lhs` using `vim.keymap.set`."
  (vim.keymap.set mode lhs rhs ?opts))

(λ slot [lhs desc ?mode]
  "Creates an empty keybinding for `lhs`."
  (let [wk (require :which-key)]
    (wk.add {1 lhs : desc :mode (or ?mode :n)})))

{: group : map : map* : slot}

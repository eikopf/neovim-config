;; some common keymapping functions wrapping which-key.nvim

(local wk (require :which-key))

(λ group [lhs name ?buffer]
  "Defines `lhs` as a keybinding group with the given `name`."
  (wk.add {1 lhs :group name :buffer ?buffer}))

(λ map [lhs rhs desc ?mode ?buffer]
  "Creates a new keybinding for `lhs`."
  (wk.add {1 lhs 2 rhs : desc :mode (or ?mode :n) :buffer ?buffer}))

(λ slot [lhs desc ?mode]
  "Creates an empty keybinding for `lhs`."
  (wk.add {1 lhs : desc :mode (or ?mode :n)}))

{: group : map : slot}

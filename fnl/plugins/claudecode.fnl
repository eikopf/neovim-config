;; coder/claudecode.nvim --- neovim integration for claude code

;; the corresponding keymaps are bound in core/keymaps.fnl
(fn setup [_self]
  (let [claudecode (require :claudecode)]
    (claudecode.setup {:terminal {:provider :native}})))

{: setup}

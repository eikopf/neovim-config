;; configuration for when neovim runs inside of neovide

(fn setup [_self]
  (let [system (require :lib.system)]
    ;; font
    (set vim.opt.guifont (match (system.os)
                           system.OS.WINDOWS "Berkeley Mono:h14"
                           system.OS.MACOS "BerkeleyMono Nerd Font:h14:#e-subpixelantialias"
                           _ ""))
    ;; text
    (set vim.g.neovide_text_gamma 0.6)
    (set vim.g.neovide_text_contrast 0.1)
    ;; padding
    (set vim.g.neovide_padding_top 10)
    (set vim.g.neovide_padding_bottom 10)
    (set vim.g.neovide_padding_right 10)
    (set vim.g.neovide_padding_left 10)
    ;; cursor
    (set vim.g.neovide_cursor_animation_length 0.025)
    (set vim.g.neovide_cursor_trail_size 0.2)
    (set vim.g.neovide_hide_mouse_when_typing true)
    (set vim.g.neovide_cursor_animate_command_line false)
    ;; ui
    (set vim.g.neovide_theme :light)))

{: setup}

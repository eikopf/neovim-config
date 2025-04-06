;; configuration for when neovim runs inside of neovide

;; WARN: some themes (e.g. catppuccin) don't set terminal colors, and
;; so using them in neovide becomes borderline painful. as a baseline,
;; nyoom-engineering/oxocarbon.nvim does this correctly.

(local {: OS : get-os} (require :lib.system))
(local {: last} (require :lib.table))

;; font
(set vim.opt.guifont (match (get-os)
                       OS.WINDOWS "Berkeley Mono:h14"
                       OS.MACOS "BerkeleyMono Nerd Font:h14"
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
(set vim.g.neovide_theme :dark)

;; if the final argument to neovim doesn't match the cwd, then
;; the user didn't pass a path manually -- so switch to $HOME
(if (not= (vim.fn.getcwd) (last vim.v.argv))
    (vim.cmd.cd vim.env.HOME))

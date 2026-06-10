;; utilities for inspecting the terminal environment

(local system (require :lib.system))

(λ windows-terminal? []
  "Returns `true` if the current terminal program is Windows Terminal."
  (system.env-set? :WT_SESSION))

(λ ghostty? []
  "Returns `(= :ghostty vim.env.TERM_PROGRAM)`."
  (= :ghostty vim.env.TERM_PROGRAM))

(λ wezterm? []
  "Returns `(= :Wezterm vim.env.TERM_PROGRAM)`."
  (= :WezTerm vim.env.TERM_PROGRAM))

(λ alacritty? []
  "Returns `(= :alacritty vim.env.TERM)`."
  (= :alacritty vim.env.TERM))

(λ iterm2? []
  "Returns `(= :iTerm.app vim.env.TERM_PROGRAM)`."
  (= :iTerm.app vim.env.TERM_PROGRAM))

(λ neovide? []
  "Returns `true` if `vim.g.neovide` is set, and `false` otherwise."
  (if (?. vim.g.neovide) true false))

;; the current terminal program, computed once at load time since it cannot
;; change mid-session
(local current-program (if (alacritty?) :alacritty
                           (ghostty?) :ghostty
                           (iterm2?) :iterm2
                           (neovide?) :neovide
                           (wezterm?) :wezterm
                           (windows-terminal?) :winterm
                           :unknown))

(λ program []
  "Returns the current terminal program as one of `:alacritty`, `:ghostty`,
  `:iterm2`, `:neovide`, `:wezterm`, `:winterm`, or `:unknown`."
  current-program)

;; return public interface
{: program
 : wezterm?
 : alacritty?
 : ghostty?
 : iterm2?
 : neovide?
 : windows-terminal?}

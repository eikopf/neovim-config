;; utilities for inspecting the terminal environment

(λ term-info []
  "Returns the value of the `$TERM` environment variable."
  vim.env.TERM)

(λ term-program []
  "Returns the value of the `$TERM_PROGRAM` environment variable."
  vim.env.TERM_PROGRAM)

(λ running-in-ghostty []
  "Returns `(= :ghostty vim.env.TERM_PROGRAM)`."
  (= :ghostty vim.env.TERM_PROGRAM))

(λ running-in-wezterm []
  "Returns `(= :Wezterm vim.env.TERM_PROGRAM)`."
  (= :WezTerm vim.env.TERM_PROGRAM))

(λ running-in-alacritty []
  "Returns `(= :alacritty vim.env.TERM)`."
  (= :alacritty vim.env.TERM))

(λ running-in-iterm2 []
  "Returns `(= :iTerm.app vim.env.TERM_PROGRAM)`."
  (= :iTerm.app vim.env.TERM_PROGRAM))

(λ running-in-neovide []
  "Returns `true` if `vim.g.neovide` is set, and `false` otherwise."
  (if (?. vim.g.neovide) true false))

;; enum of recognised terminal emulators
(local TERM {:ALACRITTY {}
             :GHOSTTY {}
             :ITERM2 {}
             :NEOVIDE {}
             :WEZTERM {}
             :UNKNOWN {}})

(setmetatable TERM.ALACRITTY {:__tostring #:Alacritty})
(setmetatable TERM.GHOSTTY {:__tostring #:Ghostty})
(setmetatable TERM.ITERM2 {:__tostring #:iTerm2})
(setmetatable TERM.NEOVIDE {:__tostring #:Neovide})
(setmetatable TERM.WEZTERM {:__tostring #:WezTerm})
(setmetatable TERM.UNKNOWN {:__tostring #:unknown})

(λ get-term []
  "Returns a `lib.term.TERM` value corresponding to the current terminal."
  (if (running-in-alacritty) TERM.ALACRITTY
      (running-in-ghostty) TERM.GHOSTTY
      (running-in-iterm2) TERM.ITERM2
      (running-in-neovide) TERM.NEOVIDE
      (running-in-wezterm) TERM.WEZTERM
      TERM.UNKNOWN))

(λ get-term-name []
  "Returns the canonical name of the current terminal."
  (tostring (get-term)))

;; return public interface
{: TERM
 : get-term
 : get-term-name
 : term-info
 : term-program
 : running-in-wezterm
 : running-in-alacritty
 : running-in-ghostty
 : running-in-iterm2
 : running-in-neovide}

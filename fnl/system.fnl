;; utilities for state that differs between systems and OSes

(λ suffix [str sep]
  "Returns the suffix of `str` after `sep`, or `nil` if `sep` doesn't occur in `str`."
  (-?>> (string.find str sep 1 :plain)
        (+ 1)
        (string.sub str)))

(λ hostname []
  "Returns the full hostname of the system."
  (vim.fn.hostname))

(λ hostname-prefix []
  "Returns the first component of the system's hostname."
  (?. (vim.split (hostname) "." {:plain true}) 1))

(λ hostname-domain []
  "Returns the domain portion of the system's hostname."
  (suffix (hostname) "."))

;; fake enum table (distinct tables are always inequal)
(local OS {:MACOS {} :LINUX {} :WINDOWS {}})
(setmetatable OS.MACOS {:__tostring #:MacOS})
(setmetatable OS.LINUX {:__tostring #:Linux})
(setmetatable OS.WINDOWS {:__tostring #:Windows})

(λ get-os []
  "Returns the system's operating system as an element of `system.OS`."
  (case (. (vim.uv.os_uname) :sysname)
    :Darwin OS.MACOS
    :Linux OS.LINUX
    :Windows OS.WINDOWS))

(λ term-info []
  "Returns the value of the `$TERM` environment variable."
  vim.env.TERM)

(λ running-in-wezterm []
  "Returns `(= :Wezterm vim.env.TERM_PROGRAM)`."
  (= :WezTerm vim.env.TERM_PROGRAM))

(λ running-in-alacritty []
  "Returns `(= :alacritty vim.env.TERM)`."
  (= :alacritty vim.env.TERM))

;; return public interface
{: hostname
 : hostname-prefix
 : hostname-domain
 : OS
 : get-os
 : term-info
 : running-in-wezterm
 : running-in-alacritty}


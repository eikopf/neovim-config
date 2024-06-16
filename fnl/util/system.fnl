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
(setmetatable OS.MACOS   {:__tostring   #:MacOS})
(setmetatable OS.LINUX   {:__tostring   #:Linux})
(setmetatable OS.WINDOWS {:__tostring #:Windows})

(λ get-os []
  "Returns the system's OS as an element of `system.OS`."
  (case (. (vim.uv.os_uname) :sysname)
    :Darwin  OS.MACOS
    :Linux   OS.LINUX
    :Windows OS.WINDOWS))

(λ get-os-name []
   "Returns the canonical name of the system's OS."
   (tostring (get-os)))

(λ get-env-var [name]
  "Returns the value an environment variable, or `nil` if it is undefined."
  (. vim.env name))

(λ run-cmd [cmd ?opts ?on-exit]
  "Executes the given system `cmd` asynchronously."
  (vim.system cmd ?opts ?on-exit))

(λ run-cmd-sync [cmd ?opts ?on-exit]
  "Synchronous version of `run-cmd`."
  (let [res (: (vim.system cmd ?opts ?on-exit) :wait)]
    (values (= res.code 0) res.stdout res.stderr)))

;; return public interface
{: hostname
 : hostname-prefix
 : hostname-domain
 : OS
 : get-os
 : get-os-name
 : get-env-var
 : run-cmd
 : run-cmd-sync}


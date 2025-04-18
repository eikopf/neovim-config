;; utilities for interacting with host systems

(local string (require :lib.string))

(λ hostname []
  "Returns the full hostname of the system."
  (vim.fn.hostname))

(λ hostname-prefix []
  "Returns the first component of the system's hostname."
  (string.prefix (hostname) "."))

(λ hostname-domain []
  "Returns the domain portion of the system's hostname."
  (string.suffix (hostname) "."))

;; fake enum table (distinct tables are always inequal)
(local OS {:MACOS {} :LINUX {} :WINDOWS {}})
(setmetatable OS.MACOS {:__tostring #:MacOS})
(setmetatable OS.LINUX {:__tostring #:Linux})
(setmetatable OS.WINDOWS {:__tostring #:Windows})

(λ os []
  "Returns the system's OS as an element of `system.OS`."
  (case (. (vim.uv.os_uname) :sysname)
    :Darwin OS.MACOS
    :Linux OS.LINUX
    :Windows OS.WINDOWS
    :Windows_NT OS.WINDOWS))

(λ macos? []
  "Returns `true` if the host OS is MacOS."
  (= (os) OS.MACOS))

(λ linux? []
  "Returns `true` if the host OS is Linux."
  (= (os) OS.LINUX))

(λ windows? []
  "Returns `true` if the host OS is Windows."
  (= (os) OS.WINDOWS))

(λ os-name []
  "Returns the canonical name of the system's OS."
  (tostring (os)))

(λ env-set? [name]
  "Returns `true` if and only if the given `name` is set in the environment."
  (not= nil (?. vim.env name)))

(λ env-var [name]
  "Returns the value of an environment variable, or `nil` if it is undefined."
  (?. vim.env name))

(λ run-cmd [cmd ?opts ?on-exit]
  "Executes the given system `cmd` asynchronously."
  (vim.system cmd ?opts ?on-exit))

(λ run-cmd-sync [cmd ?opts ?on-exit]
  "Synchronous version of `run-cmd`."
  (let [res (: (vim.system cmd ?opts ?on-exit) :wait)]
    (values (= res.code 0) res.stdout res.stderr)))

;; return public interface
{: env-set?
 : hostname
 : hostname-prefix
 : hostname-domain
 : OS
 : os
 : os-name
 : macos?
 : linux?
 : windows?
 : env-var
 : run-cmd
 : run-cmd-sync}

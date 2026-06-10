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

;; the host OS, computed once at load time since it cannot change mid-session
(local host-os (case (. (vim.uv.os_uname) :sysname)
                 :Darwin :macos
                 :Linux :linux
                 :Windows :windows
                 :Windows_NT :windows))

(λ os []
  "Returns the host OS as one of `:macos`, `:linux`, or `:windows`, or `nil`
  if it is unrecognised."
  host-os)

(λ macos? []
  "Returns `true` if the host OS is MacOS."
  (= host-os :macos))

(λ linux? []
  "Returns `true` if the host OS is Linux."
  (= host-os :linux))

(λ windows? []
  "Returns `true` if the host OS is Windows."
  (= host-os :windows))

(λ env-set? [name]
  "Returns `true` if and only if the given `name` is set in the environment."
  (not= nil (?. vim.env name)))

(λ env-var [name]
  "Returns the value of an environment variable, or `nil` if it is undefined."
  (?. vim.env name))

(λ run-cmd [cmd ?opts ?on-exit]
  "Executes the given system `cmd` asynchronously."
  (vim.system cmd ?opts ?on-exit))

(λ run-cmd-sync [cmd ?opts]
  "Synchronous version of `run-cmd`; returns whether the command succeeded,
  along with its stdout and stderr."
  (let [res (: (vim.system cmd ?opts) :wait)]
    (values (= res.code 0) res.stdout res.stderr)))

;; return public interface
{: env-set?
 : hostname
 : hostname-prefix
 : hostname-domain
 : os
 : macos?
 : linux?
 : windows?
 : env-var
 : run-cmd
 : run-cmd-sync}

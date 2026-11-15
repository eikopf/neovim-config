;; conditional compatibility configurations
;;
;; this is the final portion of the configuration, where ad-hoc code is run
;; based on the host, version, platform, terminal, and so on.

(λ set-default-neovide-path [path]
  "Sets `cwd` to `path` if Neovide is running and no path was passed manually."
  (let [term (require :lib.term)
        table (require :lib.table)]
    (if (term.neovide?)
        ;; if the final argument to neovim doesn't match the cwd, then the user
        ;; didn't pass a path manually, so we default to the given path
        (if (not= (vim.fn.getcwd) (table.last vim.v.argv))
            (vim.cmd.cd path)))))

(fn setup [_self]
  (set-default-neovide-path vim.env.HOME))

{: setup}

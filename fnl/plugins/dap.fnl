;; mfussenegger/nvim-dap -- DAP for neovim

(fn prompt-for-program []
  "Prompts the user for a program to debug."
  (vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) "/") :file))

(fn lldb []
  "Returns a table defining `lldb` as a debug adaptor."
  {:type :executable :command (vim.fn.exepath :lldb) :name :lldb})

(fn base-lldb-config []
  "Returns the standard `lldb` config used by compatible languages."
  {:name :Launch
   :type :lldb
   :request :launch
   :program prompt-for-program
   :cwd "${workspaceFolder}"
   :stopOnEntry false
   :args []})

(fn rust-init-commands []
  "Callback to add Rust types to an `lldb` session on initialisation."
  (let [rustc-sysroot (vim.fn.trim (vim.fn.system "rustc --print sysroot"))
        script-import (.. "command script import " rustc-sysroot
                          :/lib/rustlib/etc/lldb_lookup.py)
        commands-file (.. rustc-sysroot :/lib/rustlib/etc/lldb_commands)]
    (let [commands {}]
      (do
        (with-open [file (io.open commands-file :r)]
          (icollect [line (file:lines) &into commands]
            line))
        (tset commands 1 script-import)
        commands))))

(fn rust-lldb-config []
  "Returns a modified `lldb` config with additional support for Rust types."
  (let [config (base-lldb-config)]
    (do
      (tset config :initCommands rust-init-commands)
      config)))

(fn config []
  (let [dap (require :dap)]
    (do
      (tset dap :adapters {:lldb (lldb)})
      ;; NOTE: language configs must be lists of tables
      (tset dap :configurations
            {:c [(base-lldb-config)]
             :cpp [(base-lldb-config)]
             :rust [(rust-lldb-config)]}))))

{1 :mfussenegger/nvim-dap :cmd :DapContinue : config}


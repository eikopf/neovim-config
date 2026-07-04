;; plugin management via vim.pack
;;
;; this module replaces lazy.nvim with the builtin plugin manager (see
;; :help vim.pack), together with a thin shim for the features it doesn't
;; provide: invoking setup functions, flattening dependencies, running
;; build hooks, and deferred loading. each module under fnl/plugins/
;; returns a spec table in a trimmed dialect of the lazy.nvim spec format:
;;
;;   1              positional "owner/repo" github shorthand
;;   :name          overrides the inferred plugin (and directory) name
;;   :version       a branch, tag, or commit string, or a `vim.version.range`
;;   :dependencies  specs (or shorthand strings) loaded before this plugin;
;;                  a bare name refers to a spec defined in another module
;;   :enabled       boolean or nullary predicate; excludes the spec when false
;;   :init          thunk invoked at startup, even for deferred plugins
;;   :opts          table (or nullary function) passed to `setup` in the
;;                  plugin's main module when it loads
;;   :main          overrides the inferred name of the plugin's main module
;;   :config        thunk invoked when the plugin loads, instead of `setup`
;;   :build         ex command run when the plugin is installed or updated
;;   :ft :cmd :event  deferral triggers; a spec with any of these loads on
;;                  demand instead of at startup
;;   :dir           local checkout; put on the rtp directly, not managed
;;                  by vim.pack

(local autocmd (require :lib.autocmd))

;;; specs

(λ as-list [x]
  "Wraps a scalar `x` in a list, leaving lists unchanged."
  (if (= (type x) :table) x [x]))

(λ enabled? [spec]
  "Returns whether `spec` is enabled; defaults to `true`."
  (case spec.enabled
    nil true
    pred (if (= (type pred) :function) (pred) pred)))

(λ spec-name [spec]
  "Returns the name of `spec`, either explicit or inferred from its source."
  (or spec.name (vim.fs.basename (or spec.dir (. spec 1)))))

(λ main-module [spec]
  "Returns the name of the main module of `spec`, either explicit or
  inferred by dropping a `.nvim` suffix from the plugin's name."
  (or spec.main (pick-values 1 (string.gsub (spec-name spec) "%.nvim$" ""))))

(λ deferred? [spec]
  "Returns whether `spec` should be loaded on demand."
  (not= nil (or spec.ft spec.cmd spec.event)))

(λ pack-spec [spec]
  "Converts `spec` into a `vim.pack` spec (see :help vim.pack.Spec)."
  {:src (.. "https://github.com/" (. spec 1))
   :name spec.name
   :version spec.version})

;;; spec discovery

(λ spec-modules []
  "Returns the names of the plugin spec modules under `lua/plugins/`."
  (let [paths (vim.api.nvim_get_runtime_file "lua/plugins/*.lua" true)
        mods (icollect [_ path (ipairs paths)]
               (->> (string.gsub (vim.fs.basename path) "%.lua$" "")
                    (pick-values 1)
                    (.. :plugins.)))]
    (table.sort mods)
    mods))

(λ collect-specs []
  "Requires every plugin spec module, returning the enabled specs with
  their dependencies flattened, deduplicated by name, and ordered such
  that dependencies precede their dependents."
  (let [by-name {}
        top []
        ordered []
        seen {}]
    ;; register the top-level specs first, so that they take precedence
    ;; over the shorthand strings in dependency lists
    (each [_ mod (ipairs (spec-modules))]
      (let [spec (require mod)]
        (when (enabled? spec)
          (tset by-name (spec-name spec) spec)
          (table.insert top spec))))
    (fn visit [spec]
      (let [spec (or (. by-name (spec-name spec)) spec)
            name (spec-name spec)]
        (when (not (. seen name))
          (tset seen name true)
          (each [_ dep (ipairs (as-list (or spec.dependencies [])))]
            (visit (if (= (type dep) :string) {1 dep} dep)))
          (table.insert ordered spec))))
    (each [_ spec (ipairs top)]
      (visit spec))
    ordered))

;;; loading

;; the names of the plugins that have already been loaded
(local loaded {})

(λ run-setup [spec]
  "Runs the `config` thunk of `spec`, or passes its `opts` to the `setup`
  function of the plugin's main module."
  (case spec
    {: config} (config)
    {: opts} (let [opts (if (= (type opts) :function) (opts) opts)]
               ((. (require (main-module spec)) :setup) opts))
    _ nil))

(λ activate [spec]
  "Loads a deferred plugin: puts it on the rtp, sources its plugin files,
  and runs its setup."
  (let [name (spec-name spec)]
    (when (not (. loaded name))
      (tset loaded name true)
      (vim.cmd.packadd name)
      (run-setup spec))))

;;; the module searcher

;; deferred specs, keyed by the root of their main module
(local by-module {})

(λ module-root [modname]
  "Returns the first dot-separated component of `modname`."
  (pick-values 1 (string.gsub modname "%..*$" "")))

(λ module-searcher [modname]
  "A `package.loaders` searcher that activates the deferred plugin (if any)
  whose main module is a prefix of `modname`, mirroring the require
  behaviour of lazy.nvim."
  (case (. by-module (module-root modname))
    spec (when (not (. loaded (spec-name spec)))
           (tset loaded (spec-name spec) true)
           (vim.cmd.packadd (spec-name spec))
           ;; the plugin is now on the rtp, so the standard searchers can
           ;; resolve the module that is actually being required
           (var real-loader nil)
           (each [_ searcher (ipairs package.loaders) &until real-loader]
             (when (not= searcher module-searcher)
               (let [loader (searcher modname)]
                 (when (= (type loader) :function)
                   (set real-loader loader)))))
           (when real-loader
             (fn [...]
               (let [mod (real-loader ...)]
                 ;; register the module before running setup, since requiring
                 ;; a module while it loads is an error in luajit
                 (tset package.loaded modname (if (= mod nil) true mod))
                 (run-setup spec)
                 mod))))))

;;; deferral triggers

(λ parse-event [event]
  "Splits an `event` string like \"BufReadPre *.lean\" into an event name
  and an optional pattern."
  (case (event:match "^(%S+)%s+(.+)$")
    (name pattern) (values name pattern)
    _ (values event nil)))

(λ replay [cmd call]
  "Replays the invocation `call` of the user command `cmd` (see
  :help nvim_create_user_command)."
  (vim.api.nvim_cmd {:cmd cmd
                     :args call.fargs
                     :bang call.bang
                     :mods call.smods
                     :range (case call.range
                              1 [call.line1]
                              2 [call.line1 call.line2]
                              _ nil)}
                    {}))

(λ register-command-stubs [spec]
  "Registers stub user commands that activate `spec` and then replay
  themselves against the real commands."
  (let [cmds (as-list spec.cmd)]
    (each [_ cmd (ipairs cmds)]
      (vim.api.nvim_create_user_command cmd
                                        (fn [call]
                                          (each [_ c (ipairs cmds)]
                                            (pcall vim.api.nvim_del_user_command
                                                   c))
                                          (activate spec)
                                          (replay cmd call))
                                        {:nargs "*" :bang true :range true}))))

(λ register-triggers [group spec]
  "Registers the ft/cmd/event triggers that load `spec` on demand."
  (each [_ event (ipairs (as-list (or spec.event [])))]
    (let [(name pattern) (parse-event event)]
      (group:on-once name (or pattern "*") #(activate spec))))
  (when spec.ft
    (group:on-once :FileType spec.ft
                   (fn [ev]
                     (activate spec)
                     ;; re-fire the filetype machinery so that the plugin's
                     ;; ftplugin and syntax files apply to this buffer
                     (vim.api.nvim_buf_call ev.buf
                                            #(set vim.bo.filetype
                                                  vim.bo.filetype)))))
  (when spec.cmd
    (register-command-stubs spec)))

;;; build hooks

;; build commands keyed by plugin name
(local build-commands {})

;; build commands queued during startup
(local pending-builds [])

(var startup-finished? false)

(λ on-pack-changed [ev]
  "Queues (or runs) the build command of an installed or updated plugin."
  (let [cmd (. build-commands ev.data.spec.name)]
    (when (and cmd (or (= ev.data.kind :install) (= ev.data.kind :update)))
      (if startup-finished?
          (vim.schedule #(vim.cmd cmd))
          (table.insert pending-builds cmd)))))

(λ flush-builds []
  "Runs the build commands that were queued during startup."
  (set startup-finished? true)
  (each [_ cmd (ipairs pending-builds)]
    (vim.cmd cmd)))

;;; entrypoint

(fn setup [_self]
  (let [specs (collect-specs)
        group (autocmd.group :pack-loader :clear)
        eager []
        deferred []
        local-checkouts []]
    ;; run build hooks whenever vim.pack installs or updates a plugin
    (each [_ spec (ipairs specs)]
      (case spec.build cmd (tset build-commands (spec-name spec) cmd)))
    (autocmd.create :PackChanged "*" on-pack-changed)
    ;; run init thunks before anything is installed or loaded
    (each [_ spec (ipairs specs)]
      (case spec.init init (init)))
    ;; partition the specs by loading strategy
    (each [_ spec (ipairs specs)]
      (table.insert (if spec.dir local-checkouts
                        (deferred? spec) deferred
                        eager)
                    spec))
    ;; install everything up front; deferred plugins stay off the rtp
    ;; until one of their triggers fires
    (vim.pack.add (icollect [_ spec (ipairs eager)] (pack-spec spec))
                  {:confirm false})
    (vim.pack.add (icollect [_ spec (ipairs deferred)] (pack-spec spec))
                  {:confirm false :load (fn [])})
    (each [_ spec (ipairs local-checkouts)]
      (: vim.opt.rtp :prepend (vim.fs.normalize spec.dir)))
    ;; set up the eagerly-loaded plugins immediately
    (each [_ spec (ipairs eager)]
      (tset loaded (spec-name spec) true)
      (run-setup spec))
    (each [_ spec (ipairs local-checkouts)]
      (tset loaded (spec-name spec) true)
      (run-setup spec))
    ;; wire up the triggers and module searcher for the deferred plugins
    (each [_ spec (ipairs deferred)]
      (tset by-module (module-root (main-module spec)) spec)
      (register-triggers group spec))
    (table.insert package.loaders module-searcher)
    ;; plugin files are sourced after init.lua and may define the commands
    ;; that builds rely on, so pending builds are flushed on VimEnter
    (group:on-once :VimEnter "*" flush-builds)))

{: setup}

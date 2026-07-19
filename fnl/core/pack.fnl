;; declarative plugin management via vim.pack
;;
;; every module under fnl/plugins/ returns a spec table declaring one
;; plugin; this module does the plumbing: it installs the sources with
;; vim.pack (see :help vim.pack), runs build hooks, and applies each
;; spec's configuration at startup. the dialect is deliberately minimal
;; and eager --- there is no lazy loading:
;;
;;   :src      github "owner/repo" shorthand
;;   :name     overrides the inferred plugin (and directory) name
;;   :version  a branch/tag string or a `vim.version.range`
;;   :dir      local checkout; put on the rtp, not managed by vim.pack
;;   :deps     extra sources to install: shorthand strings or spec-like
;;             {:src ...} tables, with no further semantics
;;   :build    ex command run when the plugin is installed or updated
;;   :enabled  boolean or nullary predicate; excludes the spec (and its
;;             configuration) when false
;;   :opts     table (or nullary function) passed to `setup` in the
;;             plugin's main module
;;   :main     overrides the inferred name of that module
;;   :setup    thunk run instead of the `:opts` mechanism, for plugins
;;             whose configuration is more than a single `setup` call
;;
;; measured against lazy-loading, eager configuration costs ~50ms of
;; startup; if that becomes too slow on a weaker machine, defer inside
;; the relevant spec's `:setup` thunk (see plugins/idris2.fnl) rather
;; than growing the dialect.

(local autocmd (require :lib.autocmd))

;;; specs

(λ enabled? [spec]
  "Returns whether `spec` is enabled; defaults to `true`."
  (case spec.enabled
    nil true
    pred (if (= (type pred) :function) (pred) pred)))

(λ spec-name [spec]
  "Returns the name of `spec`, either explicit or inferred from its source."
  (or spec.name (vim.fs.basename (or spec.dir spec.src))))

(λ main-module [spec]
  "Returns the name of the main module of `spec`, either explicit or
  inferred by dropping a `.nvim` suffix from the plugin's name."
  (or spec.main (pick-values 1 (string.gsub (spec-name spec) "%.nvim$" ""))))

(λ as-spec [dep]
  "Promotes a shorthand dependency string to a spec table."
  (if (= (type dep) :string) {:src dep} dep))

(λ pack-spec [spec]
  "Converts `spec` into a `vim.pack` spec (see :help vim.pack.Spec)."
  {:src (.. "https://github.com/" spec.src)
   :name spec.name
   :version spec.version})

;;; discovery

(λ collect-specs []
  "Requires every module under fnl/plugins/ in sorted order, returning
  the enabled specs."
  (let [paths (vim.fn.glob (.. (vim.fn.stdpath :config) :/fnl/plugins/*.fnl)
                           false true)]
    (icollect [_ path (ipairs paths)]
      (let [name (string.gsub (vim.fs.basename path) "%.fnl$" "")
            spec (require (.. :plugins. name))]
        (when (enabled? spec) spec)))))

;;; configuration

(λ configure [spec]
  "Runs the `setup` thunk of `spec`, or passes its `opts` to the `setup`
  function of the plugin's main module."
  (case spec
    {: setup} (setup)
    {: opts} (let [opts (if (= (type opts) :function) (opts) opts)]
               ((. (require (main-module spec)) :setup) opts))
    _ nil))

;;; build hooks

;; ex commands run when the keyed plugin is installed or updated
(local build-hooks {})

;; builds queued during startup, before their commands exist
(local pending-builds [])

(var startup-finished? false)

(λ run-build [cmd]
  "Runs the build command `cmd`, reporting failure as a warning."
  (case (pcall vim.cmd cmd)
    (false err) (vim.notify (string.format "build hook %s failed: %s" cmd err)
                            vim.log.levels.WARN)))

(λ on-pack-changed [ev]
  "Queues (or runs) the build hook of an installed or updated plugin."
  (let [cmd (. build-hooks ev.data.spec.name)]
    (when (and cmd (not= ev.data.kind :delete))
      (if startup-finished? (vim.schedule #(run-build cmd))
          (table.insert pending-builds cmd)))))

(λ flush-builds []
  "Runs the builds queued during startup; their commands are defined by
  plugin files, which are only sourced after init.lua."
  (set startup-finished? true)
  (each [_ cmd (ipairs pending-builds)]
    (run-build cmd)))

;;; entrypoint

(fn setup [_self]
  (let [specs (collect-specs)
        pack-specs []
        seen {}]
    ;; run build hooks whenever vim.pack installs or updates a plugin
    (each [_ spec (ipairs specs)]
      (case spec.build cmd (tset build-hooks (spec-name spec) cmd)))
    (-> (autocmd.group :pack :clear)
        (: :on :PackChanged "*" on-pack-changed)
        (: :on-once :VimEnter "*" flush-builds))
    ;; collect the sources, deduplicated by src; top-level specs come
    ;; first so that their versions take precedence over dependencies
    (each [_ spec (ipairs specs)]
      (when (and spec.src (not (. seen spec.src)))
        (tset seen spec.src true)
        (table.insert pack-specs (pack-spec spec))))
    (each [_ spec (ipairs specs)]
      (each [_ dep (ipairs (or spec.deps []))]
        (let [dep (as-spec dep)]
          (when (not (. seen dep.src))
            (tset seen dep.src true)
            (table.insert pack-specs (pack-spec dep))))))
    (vim.pack.add pack-specs {:confirm false})
    ;; local checkouts go straight onto the rtp
    (each [_ spec (ipairs specs)]
      (when spec.dir
        (: vim.opt.rtp :prepend (vim.fs.normalize spec.dir))))
    ;; apply the configurations in sorted module order
    (each [_ spec (ipairs specs)]
      (configure spec))))

{: setup}

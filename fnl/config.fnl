;; configuration entrypoint

(import-macros {: load!} :lib.macros)

;; plugin installation must precede plugin configuration, and both must
;; precede core.compat, which applies the colorscheme
(load! :core.pack)

;;; plugin configuration

;; every module under fnl/plugins/ is a config module with a `setup`
;; method, discovered and loaded here in sorted order
(each [_ path (ipairs (vim.fn.glob (.. (vim.fn.stdpath :config)
                                       :/fnl/plugins/*.fnl)
                                   false true))]
  (let [name (string.gsub (vim.fs.basename path) "%.fnl$" "")]
    (: (require (.. :plugins. name)) :setup)))

;;; core configuration

(load! :core.filetype)
(load! :core.lsp)
(load! :core.options)
(load! :core.autocmds)
(load! :core.keymaps)
(load! :core.journal)
(load! :core.neovide)
(load! :core.compat)

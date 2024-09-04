;; language server configuration

;; NOTE: both rust-analyzer and hls are configured by other plugins

(local servers {})
(set servers.clangd      {}) ;; c/c++
(set servers.clojure_lsp {}) ;; clojure
(set servers.cssls       {}) ;; css
(set servers.tsserver    {}) ;; javascript
(set servers.fennel_ls   {}) ;; fennel
(set servers.html        {}) ;; html
(set servers.jsonls      {}) ;; json
(set servers.julials     {}) ;; julia
(set servers.lua_ls      {}) ;; lua
(set servers.marksman    {}) ;; markdown
(set servers.ocamllsp    {}) ;; ocaml
(set servers.ruff_lsp    {}) ;; python
(set servers.sourcekit   {}) ;; swift
(set servers.sqlls       {}) ;; sql

(λ find-fennel-root-dir [path]
  (. (vim.fs.find [:fnl :git] {:upward true :type :directory : path}) 1))

(set servers.fennel_ls.cmd [(.. (vim.fn.stdpath :data) :/mason/bin/fennel-ls)])
(set servers.fennel_ls.root_dir find-fennel-root-dir)
(set servers.fennel_ls.settings {:fennel-ls {:extra-globals :vim}})

(set servers.sourcekit.capabilities
     {:workspace {:didChangeWatchedFiles {:dynamicRegistration true}}})

;; load lspconfig and cmp capabilities
(local lsp (require :lspconfig))
(local capabilities (let [cmp (require :cmp_nvim_lsp)]
                      (cmp.default_capabilities)))

;; initialize the servers
(each [server settings (pairs servers)]
  ((. lsp server :setup) (vim.tbl_deep_extend :keep settings {: capabilities})))


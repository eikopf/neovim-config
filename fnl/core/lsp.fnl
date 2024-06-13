;; language server configuration

;; NOTE: both rust-analyzer and hls are configured by other plugins

(local servers {})
(set servers.clangd {})
(set servers.cssls {})
(set servers.fennel_ls {})
(set servers.html {})
(set servers.jsonls {})
(set servers.julials {})
(set servers.lua_ls {})
(set servers.marksman {})
(set servers.ruff_lsp {})
(set servers.sourcekit {})
(set servers.sqlls {})

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


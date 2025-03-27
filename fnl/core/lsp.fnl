;; language server configuration

;; NOTE: rust-analyzer is configured by rustaceanvim

(local servers {})

(set servers.clangd {})
(set servers.ts_ls {})
(set servers.fennel_ls {})
(set servers.julials {})
(set servers.lua_ls {})
(set servers.nixd {})
(set servers.ocamllsp {})
(set servers.ruff {})

(λ find-fennel-root-dir [path]
  (. (vim.fs.find [:fnl :git] {:upward true :type :directory : path}) 1))

(set servers.fennel_ls.root_dir find-fennel-root-dir)
(set servers.fennel_ls.settings {:fennel-ls {:extra-globals :vim}})

(set servers.julials.on_new_config
     (fn [new_config _]
       (let [julia (vim.fn.expand "~/.julia/environments/nvim-lspconfig/bin/julia")
             lsp (require :lspconfig)]
         (if (lsp.util.path_is_file julia)
             (tset new_config :cmd 1 julia)))))

;; load lspconfig and cmp capabilities
(local lsp (require :lspconfig))
(local capabilities (let [cmp (require :cmp_nvim_lsp)]
                      (cmp.default_capabilities)))

;; initialize the servers
(each [server settings (pairs servers)]
  ((. lsp server :setup) (vim.tbl_deep_extend :keep settings {: capabilities})))

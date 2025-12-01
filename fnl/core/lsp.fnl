;; language server configuration

(local {: first} (require :lib.table))

;; NOTE: rust-analyzer is configured by rustaceanvim

(local servers {:clangd {}
                :ts_ls {}
                :fennel_ls {}
                :julials {}
                :lua_ls {}
                :nixd {}
                :ocamllsp {}
                :pyright {}})

(set servers.fennel_ls.settings {:fennel-ls {:extra-globals :vim}})
(set servers.fennel_ls.root_dir
     (fn [buf callback]
       (callback (first (vim.fs.find [:fnl :git]
                                     {:upward true
                                      :type :directory
                                      :path (vim.fn.bufname buf)})))))

; TODO: update julials config to use vim.lsp.config. previous config:
; (set servers.julials.on_new_config
;      (fn [new_config _]
;        (let [julia (vim.fn.expand "~/.julia/environments/nvim-lspconfig/bin/julia")
;              lsp (require :lspconfig)]
;          (if (lsp.util.path_is_file julia)
;              (tset new_config :cmd 1 julia)))))

(fn setup [_]
  (each [server config (pairs servers)]
    (do
      (vim.lsp.config server config)
      (vim.lsp.enable server))))

{: servers : setup}

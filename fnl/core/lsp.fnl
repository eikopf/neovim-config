;; language server configuration

;; NOTE: rust-analyzer is configured by rustaceanvim

(local servers {:clangd {}
                :ts_ls {}
                :fennel_ls {}
                :julials {}
                :lua_ls {}
                :nixd {}
                :ocamllsp {}
                :pyright {}})

; TODO: update julials config to use vim.lsp.config. previous config:
; (set servers.julials.on_new_config
;      (fn [new_config _]
;        (let [julia (vim.fn.expand "~/.julia/environments/nvim-lspconfig/bin/julia")
;              lsp (require :lspconfig)]
;          (if (lsp.util.path_is_file julia)
;              (tset new_config :cmd 1 julia)))))

(fn setup [_]
  (each [server config (pairs servers)]
    (vim.lsp.config server config)
    (vim.lsp.enable server)))

{: servers : setup}

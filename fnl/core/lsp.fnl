;; language server configuration

;; servers to install with mason-lspconfig, with corresponding configuration tables as values
(local servers {:beancount {}
                :clangd {}
                :fennel_ls {}
                :gradle_ls {}
                :hls {}
                :html {}
                :jdtls {}
                :jsonls {}
                :jqls {}
                :julials {}
                :kotlin_language_server {}
                :lua_ls {}
                :marksman {}
                :phpactor {}
                :ruff_lsp {}
                :rust_analyzer {}
                :sqlls {}
                :tsserver {}
                :typst_lsp {}
                :zls {}})

;; aggregate language server capabilities
(local capabilities
       (let [cmp-nvim-lsp (require :cmp_nvim_lsp)]
         (cmp-nvim-lsp.default_capabilities (_G.vim.lsp.protocol.make_client_capabilities))))

;; require mason-lspconfig and ensure that the necessary servers are installed
(local mason (require :mason-lspconfig))
(mason.setup {:ensure_installed (_G.vim.tbl_keys servers)})

;; finally, set up the handlers
(mason.setup_handlers {1 (fn [server-name]
                           (let [server (. (require :lspconfig) server-name)]
                             (server.setup {: capabilities
                                            ;; callback invoked when server attaches to buffer,
                                            ;; accepting two arguments: name, then bufnr
                                            :on_attach (fn [_ bufnr]
                                                         (do
                                                           (require :cmp)
                                                           (or (?. servers
                                                                   server-name
                                                                   :on_attach)
                                                               ;; default to (fn [] nil)
                                                               #nil)))
                                            ;; general settings
                                            :settings (. servers server-name)
                                            ;; nil-safe index (equiv. servers[server_name][filetypes])
                                            :filetypes (?. servers server-name
                                                           :filetypes)})))})


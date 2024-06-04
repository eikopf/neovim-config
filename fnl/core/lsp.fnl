;; language server configuration

;; servers to install with mason-lspconfig and their corresponding settings
;; refer to :help lspconfig-setup for valid settings keys
(local servers {:beancount {}
                :clangd {}
                :cssls {}
                :fennel_ls {:cmd [(.. (vim.fn.stdpath :data)
                                      :/mason/bin/fennel-ls)]
                            :root_dir #(. (vim.fs.find [:fnl :git]
                                                       {:upward true
                                                        :type :directory
                                                        :path $})
                                          1)
                            :settings {:fennel-ls {:extra-globals :vim}}}
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
                ;; rust_analyzer is omitted – rustaceanvim configures it separately
                ;; :rust_analyzer {}
                :sqlls {}
                :tsserver {}
                :typst_lsp {}
                :zls {}})

;; require mason-lspconfig and ensure that the necessary servers are installed
(local mason (require :mason-lspconfig))
(mason.setup {:ensure_installed (_G.vim.tbl_keys servers)})

;; load lspconfig and cmp capabilities
(local lsp (require :lspconfig))
(local capabilities (let [cmp (require :cmp_nvim_lsp)]
                      (cmp.default_capabilities)))

;; initialize the servers
(each [server settings (pairs servers)]
  ((. lsp server :setup) (do
                           ;; insert capabilities into the settings
                           (tset settings :capabilities capabilities)
                           settings)))


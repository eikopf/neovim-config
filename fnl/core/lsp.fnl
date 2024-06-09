;; language server configuration

;; servers to install with mason-lspconfig and their corresponding settings
;; refer to :help lspconfig-setup for valid settings keys
(local servers {:clangd {}
                :cssls {}
                :fennel_ls {:cmd [(.. (vim.fn.stdpath :data)
                                      :/mason/bin/fennel-ls)]
                            :root_dir #(. (vim.fs.find [:fnl :git]
                                                       {:upward true
                                                        :type :directory
                                                        :path $})
                                          1)
                            :settings {:fennel-ls {:extra-globals :vim}}}
                ;; hls is configured by haskell-tools
                :html {}
                :jdtls {}
                :jsonls {}
                :julials {}
                :lua_ls {}
                :marksman {}
                :ruff_lsp {}
                ;; rust_analyzer is configured by rustaceanvim
                :sqlls {}
                ;;:tsserver {}
                ;;:typst_lsp {}
                :zls {}})

;; require mason-lspconfig and ensure that the necessary servers are installed
(local mason (require :mason-lspconfig))
(mason.setup {:ensure_installed (vim.tbl_keys servers)})

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


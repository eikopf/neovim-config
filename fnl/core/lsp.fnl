;; language server configuration

;; servers to install with mason-lspconfig and their corresponding settings
;; refer to :help lspconfig-setup for valid settings keys
(local servers {:beancount {}
                :clangd {}
                :cssls {}
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
                ;; rust_analyzer is omitted, since plugins/rustaceanvim.fnl configures it separately
                ;; :rust_analyzer {}
                :sqlls {}
                :tsserver {}
                :typst_lsp {}
                :zls {}})

;; require mason-lspconfig and ensure that the necessary servers are installed
(local mason (require :mason-lspconfig))
(mason.setup {:ensure_installed (_G.vim.tbl_keys servers)})

;; load lspconfig and coq
(local lsp (require :lspconfig))
(local coq (require :coq))

;; for each server, pass its settings to lsp.server.setup
;; and then get coq to broadcast the resulting lsp capabilities
(each [server settings (pairs servers)]
  ;; do lsp[server]["setup"]
  ((. lsp server :setup) ;; pass settings to setup function through coq to broadcast capabilities
                         (coq.lsp_ensure_capabilities settings)))


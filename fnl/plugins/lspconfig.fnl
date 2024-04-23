;; LSP configuration

;; servers to install with mason (WITH NAMES DEFINED BY LSPCONFIG)
(local servers [ :beancount                     ;; beancount
                 :fennel_ls                     ;; fennel
                 :gradle_ls                     ;; gradle
                 :hls                           ;; haskell
                 :html                          ;; html
                 :jdtls                         ;; java
                 :jsonls                        ;; json
                 :jqls                          ;; jq
                 :julials                       ;; julia
                 :kotlin_language_server        ;; kotlin
                 :lua_ls                        ;; lua
                 :marksman                      ;; markdown
                 :phpactor                      ;; php
                 :ruff                          ;; python
                 :ruff_lsp                      ;; python
                 :rust_analyzer                 ;; rust
                 :sqlls                         ;; sql
                 :tsserver                      ;; typescript
                 :typst_lsp                     ;; typst
                 :zls ])                        ;; zig

;; other non-LSP tools to install with mason
;;(local tools [ :codelldb        ;; LLVM debugger
               ;;:jq              ;; commandline json parser
               ;;:ruff            ;; python formatter/linter
               ;;:sql-formatter   ;; sql formatter
               ;;:typstfmt ])     ;; typst formatter

{ 1 :neovim/nvim-lspconfig
  :dependencies [ { 1 :williamboman/mason.nvim :config true }
                  { 1 :williamboman/mason-lspconfig.nvim
                    :config (fn [] 
                              (let [mason (require :mason-lspconfig)] 
                                (mason.setup {:ensure_installed servers}))) }
                  { 1 :j-hui/fidget.nvim :tag :legacy :opts {} }
                  :folke/neodev.nvim ]}

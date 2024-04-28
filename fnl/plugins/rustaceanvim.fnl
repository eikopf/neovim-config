;; rustaceanvim -- additional rust tooling, forked from rust-tools.nvim

;; the primary configuration interface for rustaceanvim is
;; the vim.g.rustaceanvim variable, which is a table of settings
;; with keys documented in :help rustaceanvim.config

(set _G.vim.g.rustaceanvim
     {:server {:on_attach (fn []
                            (let [wk (require :which-key)
                                  bufnr (_G.vim.api.nvim_get_current_buf)]
                              (wk.register {:a ["<cmd>:RustLsp codeAction<cr>"
                                                "Code actions"]
                                            :r ["<cmd>:RustLsp run<cr>" :Run]
                                            :t ["<cmd>:RustLsp testables<cr>1<cr>"
                                                "Select and run testable"]}
                                           {:mode :n
                                            :prefix :<leader>c
                                            :buffer bufnr})))}})

;; additional configuration options are described in :help ft-settings

;; this plugin is internally lazy, so lazy-loading with lazy.nvim is redundant
{1 :mrcjkb/rustaceanvim :version :^4 :lazy false}


;; rustaceanvim -- additional rust tooling, forked from rust-tools.nvim

(local bindings {:a [#(_G.vim.cmd.RustLsp :codeAction) "Code actions"]
                 :r [#(_G.vim.cmd.RustLsp :run) "Run item"]
                 :t [#((. (require :neotest) :run :run) (_G.vim.fn.expand "%"))
                     "Test file"]})

;; the primary configuration interface for rustaceanvim is
;; the vim.g.rustaceanvim variable, which is a callback
;; returning a table of configuration values
(set _G.vim.g.rustaceanvim
     (fn []
       {:server {:on_attach (fn []
                              (let [wk (require :which-key)
                                    bufnr (_G.vim.api.nvim_get_current_buf)]
                                (wk.register bindings
                                             {:mode :n
                                              :prefix :<leader>c
                                              :buffer bufnr})))}}))

;; additional configuration options are described in :help ft-settings

;; this plugin is internally lazy, so lazy-loading with lazy.nvim is redundant
{1 :mrcjkb/rustaceanvim :version :^4 :lazy false}


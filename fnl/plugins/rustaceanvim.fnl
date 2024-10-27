;; rustaceanvim -- additional rust tooling, forked from rust-tools.nvim

(λ run-tests-in-file []
   ((. (require :neotest) :run :run) (_G.vim.fn.expand "%")))

(λ make-bindings []
   (let [wk (require :which-key)
         buffer (vim.api.nvim_get_current_buf)]
     (wk.add {1 :<leader>ca 2 #(vim.cmd.RustLsp :codeAction) :desc "Code actions" : buffer})
     (wk.add {1 :<leader>cx 2 #(vim.cmd.RustLsp        :run) :desc "Execute item" : buffer})
     (wk.add {1 :<leader>ct 2   run-tests-in-file            :desc "Test file"    : buffer})))
     
     
     

;; configuration options passed to rust-analyzer
;; refer to https://rust-analyzer.github.io/manual.html#configuration
;;
;; NOTE: this table is implicitly passed to rust-analyzer with the InitializeParams
;; message, so wrapping it with the :initialization_options key is unnecessary
(local rust-analyzer
       (let [show-item-count 16]
         {:cargo {:features :all}
          :check {:command :clippy
                  :features :all
                  :completions {:termSearch {:enable true}}}
          :hover {:actions {:implementations {:enable true}}
                  :memoryLayout {:niches true
                                 :size :decimal
                                 :alignment :hexadecimal}
                  :show {:enumVariants show-item-count
                         :fields show-item-count
                         :traitAssocItems show-item-count}}
          :procMacro {:enable true :attributes {:enable true}}}))

;; the primary configuration interface for rustaceanvim
(set vim.g.rustaceanvim
     (fn []
       {:server {:on_attach make-bindings
                 :default_settings {: rust-analyzer}}}))

;; additional configuration options are described in :help ft-settings

;; this plugin is internally lazy, so lazy-loading with lazy.nvim is redundant
{1 :mrcjkb/rustaceanvim
 :version :^4
 :lazy false
 :dependencies [:mfussenegger/nvim-dap]}


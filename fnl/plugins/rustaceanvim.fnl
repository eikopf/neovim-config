;; rustaceanvim -- additional rust tooling, forked from rust-tools.nvim

(λ run-tests-in-file []
  ((. (require :neotest) :run :run) (_G.vim.fn.expand "%")))

(λ make-bindings []
  (let [{: map} (require :lib.keymap)
        buffer (vim.api.nvim_get_current_buf)]
    (map :<leader>ca #(vim.cmd.RustLsp :codeAction) "Code actions" :n buffer)
    (map :<leader>cx #(vim.cmd.RustLsp :run) "Execute item" :n buffer)
    (map :<leader>ct run-tests-in-file "Test file" :n buffer)))

;; configuration options passed to rust-analyzer
;; refer to https://rust-analyzer.github.io/manual.html#configuration
(local rust-analyzer
       (let [show-item-count 16]
         {:cargo {:features :all}
          ;; rust-analyzer/rust-analyzer.github.io#211
          :completion {:callable {:snippets :none}}
          :check {:command :clippy :features :all}
          :hover {:actions {:enable true :references {:enable true}}
                  :memoryLayout {:niches true
                                 :size :hexadecimal
                                 :alignment :hexadecimal
                                 :padding :hexadecimal}
                  :show {:enumVariants show-item-count
                         :fields show-item-count
                         :traitAssocItems show-item-count}}
          :procMacro {:enable true :attributes {:enable true}}}))

;; the plugin is internally lazy, configuring itself from vim.g.rustaceanvim
{:src :mrcjkb/rustaceanvim
 :version (vim.version.range :^6)
 :setup (fn []
          (set vim.g.rustaceanvim
               (fn []
                 {:server {:on_attach make-bindings
                           :default_settings {: rust-analyzer}}})))}

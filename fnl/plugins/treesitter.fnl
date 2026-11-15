;; nvim-treesitter

(local langs [:bash
              :c
              :clojure
              :comment
              :css
              :csv
              :diff
              :dockerfile
              :ebnf
              :elixir
              :elm
              :erlang
              :fennel
              :fish
              :git_config
              :git_rebase
              :gitattributes
              :gitcommit
              :gitignore
              :gleam
              :haskell
              :hlsl
              :html
              :ini
              :java
              :javascript
              :jq
              :jsdoc
              :json
              :julia
              :lalrpop
              :latex
              :lua
              :luadoc
              :make
              :markdown
              :markdown_inline
              :ocaml
              :ocaml_interface
              :ocamllex
              :python
              :rust
              :scheme
              :sql
              :toml
              :typescript
              :vim
              :vimdoc
              :wgsl
              :wgsl_bevy
              :xml
              :yaml
              :zig])

;; TODO: the following parsers aren't available on windows
;; - just
;; - linkerscript
;; - roc
;; - ssh_config
;; - tmux
;; - typst
;; - unison
;; (also the agda parser tries and fails to build on windows)

(fn start-highlighting [bufnr]
  ;; Some filetypes have no parser; ordinary syntax highlighting still works.
  (when (vim.api.nvim_buf_is_loaded bufnr)
    (pcall vim.treesitter.start bufnr)))

(fn install-parsers [languages]
  (let [treesitter (require :nvim-treesitter)]
    ;; Installation is asynchronous. Retry highlighting once it finishes so
    ;; buffers opened before their parser was installed also get highlighting.
    (: (treesitter.install languages) :await
       (vim.schedule_wrap
         (fn [_err]
           (each [_ bufnr (ipairs (vim.api.nvim_list_bufs))]
             (start-highlighting bufnr)))))))

(fn on-filetype [event]
  (start-highlighting event.buf)
  (let [lang (vim.treesitter.language.get_lang (. vim.bo event.buf :filetype))
        parsers (require :nvim-treesitter.parsers)]
    (when (and lang (. parsers lang)
               (not (pcall vim.treesitter.language.add lang)))
      (install-parsers [lang]))))

(fn config []
  ;; The main branch separates parser installation from Neovim highlighting.
  (vim.api.nvim_create_autocmd :FileType
                               {:group (vim.api.nvim_create_augroup :treesitter
                                                                    {:clear true})
                                :callback on-filetype})
  (install-parsers langs))

;; plugin spec
{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :branch :main
 :lazy false
 : config}

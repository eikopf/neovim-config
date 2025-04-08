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

(local opts {:ensure_installed langs
             :highlight {:enable true}
             :auto_install false
             :index {:enable true}})

;; callback to pass opts to nvim-treesitter.configs.setup
(fn config []
  (let [ts (require :nvim-treesitter.configs)
        compat (require :core.compat)]
    (ts.setup opts)
    (compat.load-jabber-parser)))

;; plugin spec
{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :event :BufRead
 : config}

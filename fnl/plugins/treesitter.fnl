;; complete list of parsers: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
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

;; complete spec given here: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
(local opts
       {:ensure_installed langs
        :ignore_install [:org]
        :auto_install false
        :index {:enable true}
        :highlight {:enable true :additional_vim_regex_highlighting [:org]}})

;; callback to pass opts to nvim-treesitter.configs.setup
(fn config []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup opts)))

;; plugin spec
{1 :nvim-treesitter/nvim-treesitter :build ":TSUpdate" : config}


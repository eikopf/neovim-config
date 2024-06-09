;; complete list of parsers: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
(local langs [:agda
              :bash
              :beancount
              :bibtex
              :c
              :c_sharp
              :clojure
              :comment
              :css
              :csv
              :d
              :diff
              :dockerfile
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
              :glsl
              :go
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
              :just
              :kdl
              :kotlin
              :latex
              :linkerscript
              :llvm
              :lua
              :luadoc
              :make
              :markdown
              :markdown_inline
              :matlab
              :nix
              :norg
              :ocaml
              :ocaml_interface
              :ocamllex
              :odin
              :perl
              :php
              :phpdoc
              :python
              :r
              :racket
              :roc
              :ruby
              :rust
              :scala
              :scheme
              :sql
              :ssh_config
              :swift
              :tmux
              :toml
              :typescript
              :typst
              :unison
              :uxntal
              :vim
              :vimdoc
              :wgsl
              :wgsl_bevy
              :xml
              :yaml
              :zig])

;; complete spec given here: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
(local opts {:ensure_installed langs
             :ignore_install [:org]
             :auto_install false
             :index {:enable true}
             :highlight {:enable true}})

;; callback to pass opts to nvim-treesitter.configs.setup
(fn config []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup opts)))

;; plugin spec
{1 :nvim-treesitter/nvim-treesitter
 :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
 :build ":TSUpdate"
 : config}


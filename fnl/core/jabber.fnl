;; setup for jabber syntax highlighting

(local path "~/projects/final-year-project/tree-sitter-jabber")

(local config
       {:filetype :jbr
        :install_info {:url path :files [:src/parser.c] :branch :main}})

(fn setup []
  (let [parser-config (: (require :nvim-treesitter.parsers) :get_parser_configs)]
    (vim.treesitter.language.register :jabber :jbr)
    (tset parser-config :jabber config)))

{: setup : path : config}

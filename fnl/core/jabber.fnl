;; setup for jabber syntax highlighting

(local parser-config (: (require :nvim-treesitter.parsers) :get_parser_configs))

(local jabber-path "~/projects/final-year-project/tree-sitter-jabber")

(local jabber-config {:filetype :jbr
                      :install_info {:url jabber-path
                                     :files ["src/parser.c"]
                                     :branch :main}})
                                    
(vim.treesitter.language.register :jabber :jbr)
(tset parser-config :jabber jabber-config)

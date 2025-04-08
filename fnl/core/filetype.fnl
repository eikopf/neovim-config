;; custom filetype handling

(import-macros {: extension!} :lib.macros)

(fn setup [_self]
  (extension! :ebnf :ebnf)
  (extension! :jabber :jbr)
  (extension! :lalrpop :lalrpop)
  (extension! :gitignore :tokeignore))

{: setup}

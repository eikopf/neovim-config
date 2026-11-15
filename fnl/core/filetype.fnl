;; custom filetype handling

(import-macros {: extension!} :lib.macros)

(fn setup [_self]
  (extension! :ebnf :ebnf)
  (extension! :lalrpop :lalrpop)
  (extension! :gitignore :tokeignore)
  (extension! :pollen :pm)
  (extension! :pollen :pp)
  (extension! :pollen :ptree))

{: setup}

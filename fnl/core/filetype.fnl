;; custom filetype handling

(macro extension! [ft extension]
  `(vim.filetype.add {:extension {,ft ,extension}}))

(extension! :lalrpop :lalrpop)
(extension! :ebnf    :ebnf)

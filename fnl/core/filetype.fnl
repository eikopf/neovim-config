;; custom filetype handling

(macro extension! [ft extension]
  `(vim.filetype.add {:extension {,extension ,ft}}))

(extension! :ebnf    :ebnf)
(extension! :jabber  :jbr) 
(extension! :lalrpop :lalrpop)

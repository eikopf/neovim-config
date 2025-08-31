;;; cbochs/grapple.nvim --- a scoped tag navigation system

(local opts {:quick_select :1234567890})

{1 :cbochs/grapple.nvim
 : opts
 :dependencies [{1 :nvim-tree/nvim-web-devicons :lazy true}]
 :cmd :Grapple
 :event [:BufReadPost :BufNewFile]}

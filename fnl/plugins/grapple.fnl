;;; cbochs/grapple.nvim --- a scoped tag navigation system

(local opts {:quick_select :1234567890})

{1 :cbochs/grapple.nvim
 : opts
 :dependencies [:nvim-tree/nvim-web-devicons]
 :cmd :Grapple
 :event [:BufReadPost :BufNewFile]}

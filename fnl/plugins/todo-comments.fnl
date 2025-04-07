;; todo-comments.nvim -- functionality for ALLCAPS-style comment prefixes

{1 :folke/todo-comments.nvim
 :dependencies [:nvim-lua/plenary.nvim]
 :opts {:signs false}
 :cmd [:TodoQuickFix :TodoLocList :TodoTelescope :Trouble]
 :event :BufRead}

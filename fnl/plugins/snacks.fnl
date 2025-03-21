;; folke/snacks.nvim --- a collection of QoL plugins for neovim

(local statuscolumn {:enabled true
                     :folds {:git_hl true}})
             
{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts {: statuscolumn}}

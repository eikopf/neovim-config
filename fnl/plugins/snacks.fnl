;; folke/snacks.nvim --- a collection of QoL plugins for neovim

(local dashboard {:enabled true
                  :sections [{:section :header}
                             {:section :keys :gap 1 :padding 1}
                             {:section :startup}]})
             
{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts {: dashboard}}

;; oil.nvim

(local opts { :view_options { :show_hidden true 
                              :is_always_hidden (fn [name bufnr] 
                                                  (or 
                                                    (= name ".git") 
                                                    (= name "..")))}})

{ 1 "stevearc/oil.nvim"
  :opts opts
  :dependencies "nvim-tree/nvim-web-devicons" }

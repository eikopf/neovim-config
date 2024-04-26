;; oil.nvim

(local opts
       {:view_options {:show_hidden true
                       :is_always_hidden (fn [name _bufnr]
                                           (or (= name :.git) (= name "..")))}})

{1 :stevearc/oil.nvim : opts :dependencies :nvim-tree/nvim-web-devicons}


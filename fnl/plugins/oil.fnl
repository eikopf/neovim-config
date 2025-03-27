;; oil.nvim

(local opts {:view_options {:show_hidden true
                            :is_always_hidden (fn [name _bufnr]
                                                ;; hide .git and .. directories in all contexts
                                                (or (= name :.git)
                                                    (= name "..")))}
             ;; faster up/down bindings
             :keymaps {:L :actions.select :H :actions.parent}})

{1 :stevearc/oil.nvim :dependencies :nvim-tree/nvim-web-devicons : opts}

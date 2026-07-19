;; pwntester/octo.nvim -- github integration for issues and pull requests

(local autocmd (require :lib.autocmd))

;; WARN: octo takes ~30ms to set up, so unlike most plugins its
;; configuration is deferred until after the UI has loaded
{:src :pwntester/octo.nvim
 :deps [:nvim-lua/plenary.nvim
        :nvim-telescope/telescope.nvim
        :nvim-tree/nvim-web-devicons]
 :setup (fn []
          (-> (autocmd.group :octo-setup :clear)
              (: :on-once :UIEnter "*"
                 #(vim.schedule #((. (require :octo) :setup))))))}

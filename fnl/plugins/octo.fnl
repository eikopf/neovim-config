;; pwntester/octo.nvim -- github integration for issues and pull requests

;; WARN: this absolutely *has* to be lazy-loaded -- it takes like 30ms to load!

{1 :pwntester/octo.nvim
 :cmd [:Octo]
 :config #((. (require :octo) :setup))
 :dependencies [:nvim-lua/plenary.nvim
                :nvim-telescope/telescope.nvim
                :nvim-tree/nvim-web-devicons]}

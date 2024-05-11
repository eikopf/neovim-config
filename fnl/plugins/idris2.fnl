;; ShinKage/idris2-nvim -- config for Neovim + LSP + Idris2

(local opts {:autostart_semantic true})

{1 :ShinKage/idris2-nvim
 :dependencies [:neovim/nvim-lspconfig :MunifTanjim/nui.nvim]
 :ft [:idris2 :ipkg]
 :config (fn []
           (let [idris2 (require :idris2)]
             (idris2.setup opts)))}


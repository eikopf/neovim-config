;; coffebar/neovim-project --- project manager with telescope integration

(local projects ["~/projects/*" 
                 "~/projects/scratches/*"])

{1 :coffebar/neovim-project
 :opts {: projects}
 :init #(vim.opt.sessionoptions:append :globals)
 :cmd ["Telescope neovim-project discover"
       "Telescope neovim-project history"
       :NeovimProjectLoadRecent
       :NeovimProjectLoadHist
       :NeovimProjectLoad]
 :dependencies [:nvim-lua/plenary.nvim
                :nvim-telescope/telescope.nvim
                :Shatur/neovim-session-manager]}

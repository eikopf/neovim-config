;; the doom emacs colorscheme (-ish)

;; initialisation callback
(fn init [] 
  (let [g _G.vim.g]
    ;; basic theme configuration
    (set g.doom_one_cursor_coloring false)
    (set g.doom_one_terminal_colors true)
    (set g.doom_one_italic_comments false)
    (set g.doom_one_enable_treesitter true)
    (set g.doom_one_diagnostics_text_color false)
    (set g.doom_one_transparent_background g.transparent_enabled)

    ;; pumblend transparency
    (set g.doom_one_pumblend_enable false)
    (set g.doom_one_pumblend_transparency 20)

    ;; plugin integrations
    (set g.doom_one_plugin_neorg false)
    (set g.doom_one_plugin_barbar false)
    (set g.doom_one_plugin_telescope true)
    (set g.doom_one_plugin_neogit false)
    (set g.doom_one_plugin_nvim_tree false)
    (set g.doom_one_plugin_dashboard false)
    (set g.doom_one_plugin_startify true)
    (set g.doom_one_plugin_whichkey true)))

{ 1 :NTBBloodbath/doom-one.nvim
  :priority 1000
  ;; :config (fn [] (vim.cmd.colorscheme :doom-one))
  :init init }

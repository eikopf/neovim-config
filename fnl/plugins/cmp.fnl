;; nvim-cmp -- completion functionality for neovim

;; core completions are provided by luasnip
(local dependencies [:L3MON4D3/LuaSnip
                     :saadparwaiz1/cmp_luasnip
                     ;; lsp completion capabilities
                     :hrsh7th/cmp-nvim-lsp
                     ;; additional snippets
                     :rafamadriz/friendly-snippets
                     ;; julia-style latex completions
                     :kdheepak/cmp-latex-symbols])

;; callback which loads cmp and returns keymaps
(fn mappings []
  (let [cmp (require :cmp)]
    {:<C-n> (cmp.mapping.select_next_item)
     :<C-p> (cmp.mapping.select_prev_item)
     :<C-f> (cmp.mapping.scroll_docs 4)
     :<C-d> (cmp.mapping.scroll_docs -4)
     :<C-Space> (cmp.mapping.complete {})
     :<CR> (cmp.mapping.confirm {:behaviour cmp.ConfirmBehavior.Replace
                                 :select true})
     ;; this binding used to be for <Tab>, but that drove me insane
     :<S-Tab> (cmp.mapping (fn [fallback]
                             (let [luasnip (require :luasnip)]
                               (if (cmp.visible) (cmp.select_next_item)
                                   (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
                                   (fallback))))
                           [:i :s])}))

;; callback invoked when cmp is loaded
(local config
       (fn []
         (let [cmp (require :cmp)
               luasnip (require :luasnip)]
           (do
             ;; add completions intended for vscode
             (let [llfv (require :luasnip.loaders.from_vscode)]
               (llfv.lazy_load))
             ;; fully init luasnip
             (luasnip.config.setup {})
             ;; configure cmp
             (cmp.setup {:snippet {:expand (fn [args]
                                             (luasnip.lsp_expand (args.body)))}
                         ;; bind keymaps
                         :mapping (cmp.mapping.preset.insert (mappings))
                         ;; define completion sources
                         :source [:nvim_lsp :luasnip :crates :latex_symbols]
                         ;; disable cmp when in comments (unless command mode is active)
                         :enabled (fn []
                                    (let [context (require :cmp.config.context)]
                                      (or (= (_G.vim.api.nvim_get_mode) :mode
                                             :c)
                                          (and (not (context.in_treesitter_capture :comment))
                                               (not (context.in_syntax_group :Comment))))))})))))

;; cmp is lazy-loaded (and should be loaded when LSPs attach)
{1 :hrsh7th/nvim-cmp :lazy true : dependencies : config}


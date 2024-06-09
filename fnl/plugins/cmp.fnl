;; hrsh7th/nvim-cmp -- a neovim completion engine

(fn mappings []
  (let [cmp (require :cmp)
        snip (require :luasnip)]
    {:<C-n> (cmp.mapping.select_next_item)
     :<C-p> (cmp.mapping.select_prev_item)
     :<C-d> (cmp.mapping.scroll_docs -4)
     :<C-f> (cmp.mapping.scroll_docs 4)
     :<C-Space> (cmp.mapping.complete {})
     :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                 :select true})
     :<Tab> (cmp.mapping (fn [fallback]
                           (if (cmp.visible) (cmp.select_next_item)
                               (snip.expand_or_locally_jumpable) (snip.expand_or_jump)
                               (fallback))) [:i :s])
     :<S-Tab> (cmp.mapping (fn [fallback]
                             (if (cmp.visible) (cmp.select_prev_item)
                                 (snip.locally_jumpable -1) (snip.jump -1)
                                 (fallback)))
                           [:i :s])}))

(fn config []
  (let [cmp (require :cmp)
        snip (require :luasnip)
        llfv (require :luasnip.loaders.from_vscode)]
    (do
      (llfv.lazy_load)
      (snip.config.setup {})
      (cmp.setup {:snippet {:expand (fn [args]
                                      (snip.lsp_expand args.body))}
                  :mapping (cmp.mapping.preset.insert (mappings))
                  :sources (cmp.config.sources [{:name :nvim_lsp}
                                                {:name :luasnip}
                                                {:name :ultisnips}
                                                {:name :crates}
                                                {:name :latex_symbols}
                                                {:name :orgmode}])}))))

{1 :hrsh7th/nvim-cmp
 :dependencies [:L3MON4D3/LuaSnip
                :saadparwaiz1/cmp_luasnip
                :hrsh7th/cmp-nvim-lsp
                :rafamadriz/friendly-snippets
                :kdheepak/cmp-latex-symbols]
 : config
 :event :InsertEnter}


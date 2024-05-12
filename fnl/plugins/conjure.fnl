;; Olical/conjure -- interactive evaluation in neovim

;; some of this config was derived from a lua equivalent in https://github.com/Olical/conjure
{1 :Olical/conjure
 :ft [:clojure :fennel :python :julia :lua :racket]
 :dependencies [{1 :PaterJason/cmp-conjure
                 :config (fn []
                           (let [cmp (require :cmp)
                                 config (cmp.get_config)]
                             (do
                               (table.insert config.sources
                                             {:name :buffer
                                              :option {:sources {:name :conjure}}})
                               (cmp.setup config))))}]
 :config (fn []
           ((. (require :conjure.main) :main))
           ((. (require :conjure.mapping) :on-filetype)))
 :init (fn []
         (tset _G.vim.g "conjure#debug" true))}


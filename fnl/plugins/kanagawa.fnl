;; rebelot/kanagawa.nvim --- a colorscheme like the eponymous painting

(local opts 
       {:colors {:theme {:all {:ui {:bg_gutter :none}}}}
        :compile true
        :keywordStyle {:italic false}})

{1 :rebelot/kanagawa.nvim
 : opts}

;; NOTE: with compilation enabled, you MUST run :KanagawaCompile after
;; each change to this configuration. that is, after each change you
;; should first restart neovim, and then execute :KanagawaCompile

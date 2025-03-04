;; [nfnl-macro]

;; TODO: get fennel-ls to play nice with macros (and nfnl in particular)

(fn augroup! [name clear & tail]
  "Creates an autocommand group and threads it though several `autocmd` calls."
  `(let [autocmd# (require :util.autocmd)
         group# (autocmd#.make-augroup ,name ,clear)]
     ,(icollect [_ datum# (ipairs tail)]
        `(->> group# ,datum#))))

{: augroup!}

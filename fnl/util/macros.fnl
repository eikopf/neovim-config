;; fennel-ls: macro-file
;; [nfnl-macro]

(fn concat! [x & xs]
  "Concatenates two or more lists into a single list."
  (local data# x)
  (each [_ item# (ipairs xs)]
      (each [_ datum# (ipairs item#)] 
         (tset data# (+ (length data#) 1) datum#)))
  data#)

(fn augroup! [name clear & tail]
  "Creates an autocommand group and threads it though several `autocmd` calls."
  `(let [autocmd# (require :util.autocmd)
         group# (autocmd#.make-augroup ,name ,clear)]
     ,(icollect [_ datum# (ipairs tail)]
        `(->> group# ,datum#))))

{: augroup!
 : concat!}

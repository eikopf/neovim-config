;; fennel-ls: macro-file
;; [nfnl-macro]

(fn set! [key ?value]
  (assert-compile (not= key nil))
  (local prefix?# (fn [s p] 
                      (= (string.sub s 1 (length p)) p)))
  (case [key ?value]
    [key value] `(tset vim.opt ,key ,value)
    (where [key] (prefix?# key :no))
    `(tset vim.opt ,(string.sub key 3) false)
    [key] `(tset vim.opt ,key true)))

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
 : concat!
 : set!}

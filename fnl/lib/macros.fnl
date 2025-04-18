;; fennel-ls: macro-file
;; [nfnl-macro]

(fn load! [mod ?opts]
  "Loads the given module by invoking its `setup` method."
  (assert-compile (= (type mod) :string))
  `(: (require ,mod) :setup ,?opts))

(fn set! [key ?value]
  "Sets a global option, where
  - if `?value` is not nil then `key` is assigned `?value`;
  - if `key` begins with `:no` then the corresponding key is set to `false`;
  - otherwise `key` is set to `true`.
  "
  (assert-compile (not= key nil))
  (local prefix?# (fn [s p]
                    (= (string.sub s 1 (length p)) p)))
  (case [key ?value]
    [key value] `(tset vim.opt ,key ,value)
    (where [key] (prefix?# key :no)) `(tset vim.opt ,(string.sub key 3) false)
    [key] `(tset vim.opt ,key true)))

(fn extension! [ft extension]
  "Associates the filetype `ft` with the given `extension`."
  `(vim.filetype.add {:extension {,extension ,ft}}))

(fn concat! [x & xs]
  "Concatenates two or more lists into a single list."
  (local data# x)
  (each [_ item# (ipairs xs)]
    (each [_ datum# (ipairs item#)]
      (tset data# (+ (length data#) 1) datum#)))
  data#)

(fn def-autogroup [name clear & tail]
  "Creates an autocommand group and threads it though several `autocmd` calls."
  `(let [autocmd# (require :lib.autocmd)
         group# (autocmd#.group ,name ,clear)]
     ,(icollect [_ datum# (ipairs tail)]
        `(->> group# ,datum#))))

{: def-autogroup : concat! : extension! : load! : set!}

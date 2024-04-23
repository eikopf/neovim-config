;; GLOBAL KEYMAPS
;; keymaps are bound and documented with which-key.nvim
;; following the doom emacs convention, prefix names begin with a + (e.g. +open, +find)
(local wk (require :which-key))

;; NORMAL MODE <LEADER> KEYMAPS

;; keymaps for fuzzy finding -- under the <leader>f namespace
(local find-keymaps { :name :+find 
                      :f    [ "<cmd>Telescope find_files<cr>" "Find files" ] 
                      :g    [ "<cmd>Telescope live_grep<cr>"  "Grep files" ]
                      :b    [ "<cmd>Telescope buffers<cr>"  "Find buffers" ]})

;; keymaps for git -- under the <leader>g namespace
(local git-keymaps { :name :+git 
                     :A    [ "<cmd>Git add -A<cr>"                 "Stage all" ]
                     :c    [ "<cmd>Git commit<cr>"                    "Commit" ]
                     :d    [ "<cmd>Git diff<cr>"                        "Diff" ]
                     :g    [ "<cmd>Git<cr>"                           "Status" ]
                     :p    [ "<cmd>Git push<cr>"                        "Push" ]
                     :s    [ "<cmd>Telescope git_branches<cr>" "Switch branch" ]
                     :u    [ "<cmd>Git reset<cr>"                "Unstage all" ]})

;; keymaps for lazy.nvim -- under the <leader>l namespace
(local lazy-keymaps { :name :+lazy })

;; keymaps for opening operations -- under the <leader>o namespace
(local open-keymaps { :name :+open 
                      :l    [ "<cmd>Lazy<cr>"                                     "Open lazy" ]
                      :t    [ "<cmd>split | resize -10 | terminal<cr>i" "Open terminal split" ]
                      :T    [ "<cmd>terminal<cr>i"                       "Open terminal here" ]})

;; leader-namespaced keymaps are properly bound and prefixed at this bound
(wk.register 
  { :f find-keymaps
    :g  git-keymaps
    :l lazy-keymaps 
    :o open-keymaps } 
  { :mode   :n 
    :prefix :<leader> })

;; OTHER NORMAL MODE KEYMAPS

;; non-namespaced normal mode keymaps are defined seperately
(wk.register { :- [ "<cmd>Oil<cr>" "Open enclosing directory" ] } { :mode :n })

;; TERMINAL MODE KEYMAPS

;; define and document the terminal mode <Esc> fix
(wk.register { :<Esc> [ :<C-\><C-n> "Exit terminal mode" ] } { :mode :t })

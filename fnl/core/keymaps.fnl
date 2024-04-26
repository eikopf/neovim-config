;; GLOBAL KEYMAPS
;; keymaps are bound and documented with which-key.nvim
;; following the doom emacs convention, prefix names begin with a + (e.g. +open, +find)
(local wk (require :which-key))

;; TERMINAL MODE KEYMAPS

;; define and document the terminal mode <Esc> fix
(wk.register {:<Esc> ["<C-\\><C-n>" "Exit terminal mode"]} {:mode :t})

;; NORMAL MODE <LEADER> KEYMAPS

;; keymaps for fuzzy finding -- under the <leader>f namespace
(local find-keymaps
       {:name :+find
        :f ["<cmd>Telescope find_files<cr>" "Find files"]
        :g ["<cmd>Telescope live_grep<cr>" "Grep files"]
        :b ["<cmd>Telescope buffers<cr>" "Find buffers"]})

;; keymaps for git -- under the <leader>g namespace
(local git-keymaps {:name :+git
                    :A ["<cmd>Git add -A<cr>" "Stage all"]
                    :c ["<cmd>Git commit<cr>" :Commit]
                    :d ["<cmd>Git diff<cr>" :Diff]
                    :g [:<cmd>Git<cr> :Status]
                    :p ["<cmd>Git push<cr>" :Push]
                    :s ["<cmd>Telescope git_branches<cr>" "Switch branch"]
                    :u ["<cmd>Git reset<cr>" "Unstage all"]})

;; lsp keymaps -- under the <leader>l namespace
(local lsp-keymaps {:name :+lsp
                    :f ["<cmd>lua require(\"conform\").format({lsp_fallback = true}, nil)<cr>"
                        "Format buffer"]
                    :i [:<cmd>LspInfo<cr> "Show LSP info"]})

;; keymaps for opening operations -- under the <leader>o namespace
(local open-keymaps
       {:name :+open
        :l [:<cmd>Lazy<cr> "Open lazy"]
        :m [:<cmd>Mason<cr> "Open mason"]
        :t [(fn []
              (let [cmd _G.vim.cmd
                    map _G.vim.keymap.set]
                (cmd :15split)
                (cmd :terminal)
                (map :t :<Esc> :<cmd>q<cr> {:buffer true})
                (cmd :startinsert)))
            "Open terminal split"]
        :T [:<cmd>terminal<cr>i "Open terminal here"]})

;; keymaps for toggling settings -- under the <leader>t namespace
(local toggle-keymaps
       {:name :+toggle
        :l ["<cmd>set number!<cr>" "Toggle line numbers"]
        :r ["<cmd>set relativenumber!<cr>" "Toggle relative line numbers"]})

;; keymaps for window operations -- under the <leader>w namespace
;; these have been chosen to match exactly with the <c-w> bindings
(local window-keymaps
       {:name :+window
        :h ["<cmd>wincmd h<cr>" "Go left"]
        :j ["<cmd>wincmd j<cr>" "Go down"]
        :k ["<cmd>wincmd k<cr>" "Go up"]
        :l ["<cmd>wincmd l<cr>" "Go right"]
        :o [:<cmd>only<cr> "Close other windows"]
        :q [:<cmd>q<cr> "Quit window"]
        :s [:<cmd>split<cr> "Horizontal split"]
        :v [:<cmd>vsplit<cr> "Vertical split"]})

;; leader-namespaced keymaps are properly bound and prefixed at this bound
(wk.register ;; table of immediate subnamespaces
             {:f find-keymaps
              :g git-keymaps
              :l lsp-keymaps
              :o open-keymaps
              :t toggle-keymaps
              :w window-keymaps}
             ;; options passed with these keymaps
             {:mode :n :prefix :<leader>})

;; OTHER NORMAL MODE KEYMAPS

;; top-level keymaps for "goto" actions (e.g. goto definition
(local go-keymaps {:name :+goto
                   :d ["<cmd>lua vim.lsp.buf.definition()<cr>"
                       "Goto definition"]})

;; non-namespaced normal mode keymaps are defined seperately
(wk.register {:- [:<cmd>Oil<cr> "Open enclosing directory"]
              :g go-keymaps
              :K ["<cmd>lua vim.lsp.buf.hover()<cr>" "LSP hover"]}
             {:mode :n})


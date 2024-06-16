;; KEYMAPS

;; keymaps are bound and documented with which-key.nvim
;; following the doom emacs convention, prefix names are 
;; lowercased and begin with a "+" (e.g. +open, +find)

(local wk (require :which-key))

;; TERMINAL MODE KEYMAPS

;; define and document the terminal mode <Esc> fix
(wk.register {:<Esc> ["<C-\\><C-n>" "Exit terminal mode"]} {:mode :t})

;; NORMAL MODE <LEADER> KEYMAPS

(λ format-buffer []
  "Formats the current buffer"
  (let [conform (require :conform)]
    (conform.format {:async true :lsp_fallback true})))

;; general code keymaps -- under the <leader>c namespace
(local code-keymaps 
       {:name :+code
        :a "Code actions"
        :d [#(vim.cmd.Trouble :document_diagnostics)   "Show document diagnostics"]
        :D [#(vim.cmd.Trouble :workspace_diagnostics) "Show workspace diagnostics"]
        :f [format-buffer                                          "Format buffer"]
        :r [vim.lsp.buf.rename                                     "Rename symbol"]
        :R [#(vim.cmd.Trouble :lsp_references)                   "Show references"]
        :t                                                             "Run tests"
        :x                                                                :Execute})

;; (quick)fixing keymaps -- under the <leader>f namespace
(local fix-keymaps
       {:name :+fix
        :h [#(vim.cmd.TodoTrouble :keywords=HACK) "Fix HACKs"]
        :t [#(vim.cmd.TodoTrouble :keywords=TODO) "Fix TODOs"]
        :q [#(vim.cmd.Trouble :quickfix) "Fix quickfix items"]})

;; keymaps for git -- under the <leader>g namespace
(local git-keymaps
       {:name :+git
        :A [#(vim.cmd.Git "add -A")                "Stage all"]
        :c [#(vim.cmd.Git :commit)                     :Commit]
        :d [#(vim.cmd.Git :diff)                         :Diff]
        :g [vim.cmd.Git                                :Status]
        :p [#(vim.cmd.Git :push)                         :Push]
        :s [#(vim.cmd.Telescope :git_branches) "Switch branch"]
        :u [#(vim.cmd.Git :reset)                "Unstage all"]})

;; lsp keymaps -- under the <leader>l namespace
(local lsp-keymaps {:name :+lsp
                    :r [vim.cmd.LspRestart "Restart server"]
                    :l [vim.cmd.LspLog   "Show server logs"]
                    :i [vim.cmd.LspInfo     "Show LSP info"]})

;; notes keymaps -- under the <leader>n namespace
(local note-keymaps {:name :+notes :a :Agenda :c :Capture})

;; emulating the behaviour of vterm in doom emacs
(λ open-short-term []
  "Opens a short horizontal terminal split and binds `<Esc>` to `:q`"
  (vim.cmd :ToggleTerm)
  (vim.keymap.set :t :<Esc> :<cmd>q<cr> {:buffer true})
  (vim.cmd :startinsert))

(λ open-full-term []
  "Opens a normal terminal session in the current buffer."
  (vim.cmd :terminal)
  (vim.cmd :startinsert))

(λ goto-dir-and-edit [dir]
  "Sets the `cwd` to `dir` and calls `:edit .`"
  (vim.cmd.cd dir)
  (vim.cmd.edit ".")
  (vim.notify (.. "set cwd to " (vim.fn.expand dir)) vim.log.levels.INFO))

;; keymaps for opening operations -- under the <leader>o namespace
(local open-keymaps
       {:name :+open
        :c [#(goto-dir-and-edit "~/.config/nvim")   "Open config"]
        :l [#(vim.cmd :Lazy)                          "Open lazy"]
        :m [#(vim.cmd :Mason)                        "Open mason"]
        :o [#(goto-dir-and-edit "~/Documents/org") "Open org dir"]
        :p [#(goto-dir-and-edit "~/projects")     "Open projects"]
        :P [#(vim.cmd.Lazy :profile)         "Open lazy profiler"]
        :t [#(open-short-term)              "Open terminal split"]
        :T [#(open-full-term)                "Open terminal here"]})

;; keymaps for proof assistants -- under the <leader>p namespace
;; this is mostly here to mark <leader>p as reserved
(local proof-keymaps {:name :+proof})

;; keymaps for searching -- under the <leader>s namespace
(local search-keymaps
       {:name :+search
        :t [#(vim.cmd.TodoTelescope :keywords=TODO) "Search TODOs"]
        :c [#(vim.cmd.TodoTelescope)       "Search comment labels"]
        :f [#(vim.cmd.Telescope :find_files)        "Search files"]
        :g [#(vim.cmd.Telescope :live_grep)           "Grep files"]
        :b [#(vim.cmd.Telescope :buffers)         "Search buffers"]})

(λ toggle-neotest-summary []
  "Toggles the `neotest` summary buffer."
  (let [nt (require :neotest)]
    (nt.summary.toggle)))

(λ toggle-colorscheme-mode []
   "Toggles the value of `background` between `:light` and `:dark`."
  (set vim.opt.bg
       (case vim.opt.bg._value
         :light :dark
         :dark  :light)))

;; keymaps for toggling settings -- under the <leader>t namespace
(local toggle-keymaps
       {:name :+toggle
        :l [#(vim.cmd.set :number!)                  "Toggle line numbers"]
        :m [toggle-colorscheme-mode              "Toggle colorscheme mode"]
        :t [toggle-neotest-summary                   "Toggle test summary"]
        :p [vim.cmd.ParinferToggle                       "Toggle parinfer"]
        :P [vim.cmd.ParinferToggle!             "Toggle parinfer globally"]
        :r [#(vim.cmd.set :relativenumber!) "Toggle relative line numbers"]})

;; keymaps for window operations -- under the <leader>w namespace
;; these have been chosen to match exactly with the <c-w> bindings
(local window-keymaps
       {:name :+window
        :h [#(vim.cmd.wincmd :h)     "Go left"]
        :j [#(vim.cmd.wincmd :j)     "Go down"]
        :k [#(vim.cmd.wincmd :k)       "Go up"]
        :l [#(vim.cmd.wincmd :l)    "Go right"]
        :o [vim.cmd.only "Close other windows"]
        :q [vim.cmd.q            "Quit window"]
        :s [vim.cmd.split   "Horizontal split"]
        :v [vim.cmd.vsplit    "Vertical split"]})

;; leader-namespaced keymaps are properly bound and prefixed at this bound
(wk.register ;; table of immediate subnamespaces
             {:c code-keymaps
              :f fix-keymaps
              :g git-keymaps
              :l lsp-keymaps
              :n note-keymaps
              :o open-keymaps
              :p proof-keymaps
              :s search-keymaps
              :t toggle-keymaps
              :w window-keymaps}
             ;; options passed with these keymaps
             {:mode :n :prefix :<leader>})

;; OTHER NORMAL MODE KEYMAPS

;; top-level keymaps for "goto" actions (e.g. goto definition
(local go-keymaps
       {:name :+goto :d [#(vim.lsp.buf.definition) "Goto definition"]})

(λ prompt-fennel-eval []
  "Prompts for a Fennel expression and evaluates it."
  (vim.cmd.FnlEval (vim.fn.input {:prompt "eval: " :cancelreturn :nil})))

;; non-namespaced normal mode keymaps
(wk.register {:-  [#(vim.cmd :Oil)      "Open enclosing directory"]
              ";" [prompt-fennel-eval "Evaluate Fennel expression"]
              :g   go-keymaps
              :K  [#(vim.lsp.buf.hover)                "LSP hover"]} 
             {:mode :n})


;; KEYMAPS

;; keymaps are bound and documented with which-key.nvim
(local wk (require :which-key))

(λ group [lhs name]
   "Defines `lhs` as a keybinding group with the given `name`."
   (wk.add {1 lhs :group name}))

(λ map [lhs rhs desc ?mode]
   "Creates a new keybinding for `lhs`."
   (wk.add {1 lhs
            2 rhs
            : desc
            :mode (or ?mode :n)}))

(λ slot [lhs desc ?mode]
   "Creates an empty keybinding for `lhs`."
   (wk.add {1 lhs
            : desc
            :mode (or ?mode :n)}))

(λ format-buffer []
  "Formats the current buffer"
  (let [conform (require :conform)]
    (conform.format {:async true :lsp_fallback true})))

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

(λ prompt-fennel-eval []
  "Prompts for a Fennel expression and evaluates it."
  (vim.cmd.Fnl (vim.fn.input {:prompt "eval: " :cancelreturn :nil})))

;; emacs-style lisp evaluation prompt
(map "<leader>;" prompt-fennel-eval "Evaluate Fennel expression")

;; define and document the terminal mode <Esc> fix
(map :<Esc> "<C-\\><C-n>" "Exit terminal mode" :t)

;; general code keymaps -- under the <leader>c namespace
(group :<leader>c :code)
(map :<leader>cd #(vim.cmd.Trouble :document_diagnostics) "Show local diagnostics")
(map :<leader>cD #(vim.cmd.Trouble :workspace_diagnostics)  "Show all diagnostics")
(map :<leader>cf format-buffer                                     "Format buffer")
(map :<leader>cr vim.lsp.buf.rename                                "Rename symbol")
(map :<leader>cR #(vim.cmd.Trouble :lsp_references)              "Show references")
(slot :<leader>ca "Code actions")
(slot :<leader>ct    "Run tests")
(slot :<leader>cx      "Execute")

;; (quick)fixing keymaps -- under the <leader>f namespace
(group :<leader>f :fix)
(map :<leader>fh #(vim.cmd.TodoTrouble :keywords=HACK) "Fix HACKs")
(map :<leader>ft #(vim.cmd.TodoTrouble :keywords=TODO) "Fix TODOs")
(map :<leader>fq #(vim.cmd.Trouble          :quickfix)  "Quickfix")

;; keymaps for git -- under the <leader>g namespace
(group :<leader>g :git)
(map :<leader>gA #(vim.cmd.Git             "add -A")     "Stage all")
(map :<leader>gc #(vim.cmd.Git             "commit")        "Commit")
(map :<leader>gd #(vim.cmd.Git               "diff")          "Diff")
(map :<leader>gg   vim.cmd.Git                              "Status")
(map :<leader>gp #(vim.cmd.Git               "push")          "Push")
(map :<leader>gs #(vim.cmd.Telescope "git_branches") "Switch branch")
(map :<leader>gu #(vim.cmd.Git              "reset")   "Unstage all")

;; lsp keymaps -- under the <leader>l namespace
(group :<leader>l :lsp)
(map :<leader>lr vim.cmd.LspRestart "Restart server")
(map :<leader>ll vim.cmd.LspLog   "Show server logs")
(map :<leader>li vim.cmd.LspInfo     "Show LSP info")

;; notes keymaps -- under the <leader>n namespace
(group :<leader>n :notes)
(slot :<leader>na :Agenda)
(slot :<leader>nc :Capture)

;; keymaps for opening operations -- under the <leader>o namespace
(group :<leader>o :open)
(map :<leader>oc #(goto-dir-and-edit "~/.config/nvim")   "Open config")
(map :<leader>ol #(vim.cmd :Lazy)                          "Open lazy")
(map :<leader>om #(vim.cmd :Mason)                        "Open mason")
(map :<leader>oo #(goto-dir-and-edit "~/Documents/org") "Open org dir")
(map :<leader>op #(goto-dir-and-edit "~/projects")     "Open projects")
(map :<leader>oP #(vim.cmd.Lazy :profile)         "Open lazy profiler")
(map :<leader>ot #(open-short-term)              "Open terminal split")
(map :<leader>oT #(open-full-term)                "Open terminal here")

;; keymaps for proof assistants -- under the <leader>p namespace
;; this is mostly here to mark <leader>p as reserved
(group :<leader>p :proof)

;; keymaps for searching -- under the <leader>s namespace
(group :<leader>s :search)
(map :<leader>st #(vim.cmd.TodoTelescope :keywords=TODO) "Search TODOs")
(map :<leader>sc #(vim.cmd.TodoTelescope)       "Search comment labels")
(map :<leader>sf #(vim.cmd.Telescope :find_files)        "Search files")
(map :<leader>sg #(vim.cmd.Telescope :live_grep)           "Grep files")
(map :<leader>sb #(vim.cmd.Telescope :buffers)         "Search buffers")

;; keymaps for toggling settings -- under the <leader>t namespace
(group :<leader>t :toggle)
(map :<leader>tl #(vim.cmd.set :number!)                  "Toggle line numbers")
(map :<leader>tm toggle-colorscheme-mode              "Toggle colorscheme mode")
(map :<leader>tt toggle-neotest-summary                   "Toggle test summary")
(map :<leader>tp vim.cmd.ParinferToggle                       "Toggle parinfer")
(map :<leader>tP vim.cmd.ParinferToggle!             "Toggle parinfer globally")
(map :<leader>tr #(vim.cmd.set :relativenumber!) "Toggle relative line numbers")

;; keymaps for window operations -- under the <leader>w namespace
(group :<leader>w :window)
(map :<leader>wh #(vim.cmd.wincmd :h)     "Go left")
(map :<leader>wj #(vim.cmd.wincmd :j)     "Go down")
(map :<leader>wk #(vim.cmd.wincmd :k)       "Go up")
(map :<leader>wl #(vim.cmd.wincmd :l)    "Go right")
(map :<leader>wo vim.cmd.only "Close other windows")
(map :<leader>wq vim.cmd.q           "Close window")
(map :<leader>ws vim.cmd.split   "Horizontal split")
(map :<leader>wv vim.cmd.vsplit    "Vertical split")

;; other normal mode bindings
(map :-  #(vim.cmd :Oil)  "Open enclosing directory")
(map :gd #(vim.lsp.buf.definition) "Goto definition")
(map :K  #(vim.lsp.buf.hover)            "LSP hover")

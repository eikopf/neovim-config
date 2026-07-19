;; plugin installation via vim.pack
;;
;; this module only *installs* plugins: it declares their sources (see
;; :help vim.pack) and runs build hooks when a plugin is installed or
;; updated. plugin *configuration* lives in the modules under fnl/plugins/,
;; which are ordinary config modules loaded from config.fnl.
;;
;; everything is installed and loaded eagerly: measured against deferred
;; loading, the difference is roughly 25ms of startup time, which isn't
;; worth a lazy-loading layer. if this ever becomes too slow on a weaker
;; machine, defer the expensive tail (lean, conjure) with per-plugin
;; FileType autocmds (as in fnl/plugins/idris2.fnl) rather than
;; reintroducing general machinery.

(local autocmd (require :lib.autocmd))
(local system (require :lib.system))

(λ gh [src ?opts]
  "Returns a `vim.pack` spec (see :help vim.pack.Spec) for a github
  shorthand `src` like \"owner/repo\"; `?opts` may set `:name` and
  `:version`."
  {:src (.. "https://github.com/" src)
   :name (?. ?opts :name)
   :version (?. ?opts :version)})

;; NOTE: nvim-mini/mini.starter is currently disabled and hence not listed
;; here (see fnl/plugins/start-up.fnl)
(local plugins [(gh :isti115/agda.nvim)
                (gh :p00f/alabaster.nvim)
                (gh :saghen/blink.cmp {:version (vim.version.range :1.*)})
                (gh :saghen/blink.compat {:version (vim.version.range "*")})
                ;; installed under a historical typo'd name
                (gh :catppuccin/nvim {:name :catpuccin})
                (gh :coder/claudecode.nvim)
                (gh :kdheepak/cmp-latex-symbols)
                (gh :stevearc/conform.nvim)
                (gh :Olical/conjure)
                (gh :hat0uma/csvview.nvim)
                (gh :sainnhe/everforest)
                (gh :antoinemadec/FixCursorHold.nvim)
                (gh :rafamadriz/friendly-snippets)
                (gh :lewis6991/gitsigns.nvim)
                (gh :cbochs/grapple.nvim)
                (gh :mrcjkb/haskell-tools.nvim
                    {:version (vim.version.range :^6)})
                (gh :idris-community/idris2-nvim)
                (gh :bakpakin/janet.vim)
                (gh :Julian/lean.nvim)
                (gh :ledger/vim-ledger)
                (gh :nvim-lualine/lualine.nvim)
                (gh :MunifTanjim/nui.nvim)
                (gh :neovim/nvim-lspconfig)
                (gh :nvim-lua/plenary.nvim)
                (gh :nvim-neotest/neotest)
                (gh :nvim-neotest/nvim-nio)
                (gh :nvim-tree/nvim-web-devicons)
                (gh :nvim-treesitter/nvim-treesitter {:version :main})
                (gh :LhKipp/nvim-nu)
                (gh :gpanders/nvim-parinfer)
                (gh :windwp/nvim-autopairs)
                (gh :tjdevries/ocaml.nvim)
                (gh :pwntester/octo.nvim)
                (gh :stevearc/oil.nvim)
                (gh :mrcjkb/rustaceanvim {:version (vim.version.range :^6)})
                ;; pinned to the release branch
                (gh :nvim-telescope/telescope.nvim {:version :0.1.x})
                (gh :folke/todo-comments.nvim)
                (gh :akinsho/toggleterm.nvim {:version (vim.version.range "*")})
                (gh :folke/trouble.nvim)
                (gh :chomosuke/typst-preview.nvim
                    {:version (vim.version.range :1.*)})
                (gh :tpope/vim-dispatch)
                (gh :tpope/vim-fugitive)
                (gh :clojure-vim/vim-jack-in)
                (gh :otherjoel/vim-pollen)
                (gh :benknoble/vim-racket)
                ;; a fork that fixes a small bug in mhinz/vim-rfc
                (gh :eikopf/vim-rfc)
                (gh :folke/which-key.nvim)])

;; host-specific plugins: tracey is a local checkout on pilatus, and mason
;; only manages language tooling on windows
(when (not= :pilatus (system.hostname-prefix))
  (table.insert plugins (gh :eikopf/tracey.nvim)))

(when (system.windows?)
  (table.insert plugins (gh :mason-org/mason.nvim))
  (table.insert plugins (gh :mason-org/mason-lspconfig.nvim)))

;;; build hooks

;; ex commands run when the keyed plugin is installed or updated
(local build-hooks {:nvim-treesitter ":TSUpdate" :nvim-nu ":TSInstall nu"})

;; builds queued during startup, before their commands exist
(local pending-builds [])

(var startup-finished? false)

(λ run-build [cmd]
  "Runs the build command `cmd`, reporting failure as a warning."
  (case (pcall vim.cmd cmd)
    (false err) (vim.notify (string.format "build hook %s failed: %s" cmd err)
                            vim.log.levels.WARN)))

(λ on-pack-changed [ev]
  "Queues (or runs) the build hook of an installed or updated plugin."
  (let [cmd (. build-hooks ev.data.spec.name)]
    (when (and cmd (not= ev.data.kind :delete))
      (if startup-finished? (vim.schedule #(run-build cmd))
          (table.insert pending-builds cmd)))))

(λ flush-builds []
  "Runs the builds queued during startup; their commands are defined by
  plugin files, which are only sourced after init.lua."
  (set startup-finished? true)
  (each [_ cmd (ipairs pending-builds)]
    (run-build cmd)))

;;; entrypoint

(fn setup [_self]
  (-> (autocmd.group :pack :clear)
      (: :on :PackChanged "*" on-pack-changed)
      (: :on-once :VimEnter "*" flush-builds))
  (vim.pack.add plugins {:confirm false})
  ;; local checkouts go straight onto the rtp
  (when (= :pilatus (system.hostname-prefix))
    (: vim.opt.rtp :prepend (vim.fs.normalize "~/projects/tracey.nvim"))))

{: setup}

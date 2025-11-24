;; conditional compatibility configurations
;;
;; this is the final portion of the configuration, where ad-hoc code is run
;; based on the host, version, platform, terminal, and so on.

(λ disable-nvim-treesitter-git-downloads []
  "Makes `nvim-treesitter` use `curl` and `tar` instead of `git` when possible."
  (let [treesitter-install (require :nvim-treesitter.install)]
    (set treesitter-install.prefer-git false)))

(λ set-windows-treesitter-compilers [compilers]
  "Sets the compilers used by treesitter to compile grammars on Windows."
  (let [system (require :lib.system)]
    (if (system.windows?)
        (let [ts-install (require :nvim-treesitter.install)]
          (tset ts-install :compilers compilers)))))

(λ set-default-neovide-path [path]
  "Sets `cwd` to `path` if Neovide is running and no path was passed manually."
  (let [term (require :lib.term)
        table (require :lib.table)]
    (if (term.neovide?)
        ;; if the final argument to neovim doesn't match the cwd, then the user
        ;; didn't pass a path manually, so we default to the given path
        (if (not= (vim.fn.getcwd) (table.last vim.v.argv))
            (vim.cmd.cd path)))))

(local jabber-path "~/projects/final-year-project/tree-sitter-jabber")

(local jabber-config {:filetype :jbr
                      :install_info {:url jabber-path
                                     :files [:src/parser.c]
                                     :branch :main}})

;; for lazy-loading reasons this function is used in plugins/treesitter.fnl, not here
(λ load-jabber-parser []
  "Loads the Jabber treesitter parser from `path` if it exists."
  (if (vim.uv.fs_stat (vim.fs.normalize jabber-path))
      (let [parsers (: (require :nvim-treesitter.parsers) :get_parser_configs)]
        (vim.treesitter.language.register :jabber :jbr)
        (set parsers.jabber jabber-config))))

(λ patch-neovim-30985 []
  "Fixes neovim/neovim#30985 for versions before v0.11."
  (let [version (require :lib.version)
        current-version (version.nvim)
        v0-11-0 (version.parse :0.11.0)]
    (if (current-version:lt v0-11-0)
        (each [_ method (ipairs [:textDocument/diagnostic
                                 :workspace/diagnostic])]
          (local default-diagnostic-handler (. vim.lsp.handlers method))
          (tset vim.lsp.handlers method
                (fn [err result context config]
                  (if (not= (?. err :code) -32802)
                      (default-diagnostic-handler err result context config))))))))

(λ load-colorscheme-by-term [default]
  "Sets the colorscheme on a per-terminal basis, falling back to the given `default`."
  (let [term (require :lib.term)]
    (vim.cmd.colorscheme (match (term.program)
                           term.TERM.WEZTERM :catppuccin-macchiato
                           term.TERM.GHOSTTY :alabaster
                           term.TERM.NEOVIDE :everforest
                           term.TERM.WINTERM :everforest
                           _ default))))

(λ set-colorscheme-mode-by-term [default]
  "Sets the colorscheme mode on a per-terminal basis, falling back to the given `default`."
  (let [term (require :lib.term)]
    (set vim.opt.bg (match (term.program)
                      term.TERM.WEZTERM :dark
                      term.TERM.GHOSTTY :light
                      term.TERM.NEOVIDE :light
                      term.TERM.WINTERM :dark
                      _ default))))

(fn setup [_self]
  (disable-nvim-treesitter-git-downloads)
  (set-windows-treesitter-compilers [:zig])
  (set-default-neovide-path vim.env.HOME)
  (load-colorscheme-by-term :catppuccin-latte)
  (set-colorscheme-mode-by-term :dark)
  (patch-neovim-30985))

{: load-jabber-parser : setup}

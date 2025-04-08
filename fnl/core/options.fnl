;; neovim global options

(import-macros {: set!} :lib.macros)

(fn setup [_self]
  ;; reasonable defaults
  (set! :backspace :2)
  (set! :laststatus 2)
  (set! :showcmd)
  (set! :autoread)
  ;; tab behaviour
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 2)
  (set! :shiftround)
  (set! :expandtab)
  ;; decrease update times
  (set! :timeoutlen 500)
  (set! :updatetime 250)
  ;; ui options
  (set! :conceallevel 0)
  (set! :scrolloff 3)
  (set! :number)
  (set! :norelativenumber)
  (set! :wrap)
  (set! :termguicolors)
  ;; folding options
  ;; https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
  (set! :foldmethod :expr)
  (set! :foldexpr "v:lua.vim.treesitter.foldexpr()")
  (set! :foldcolumn :0)
  (set! :foldlevel 99)
  (set! :foldlevelstart 99)
  (set! :foldnestmax 4)
  ;; make the neovim clipboard play nicely with the OS's clipboard
  (set! :clipboard :unnamedplus)
  ;; search options
  (set! :ignorecase)
  (set! :smartcase)
  (set! :hlsearch)
  (set! :grepprg "rg --vimgrep")
  ;; this relies on ripgrep being available
  (set! :grepformat "%f:%1:%c:%m")
  (set! :path ["." "**"])
  ;; vim commandline options
  (set! :history 1000)
  ;; history options
  (set! :nobackup)
  (set! :nowritebackup)
  (set! :undofile)
  (set! :noswapfile)
  ;; window options
  (set! :splitbelow)
  (set! :splitright)
  (set! :sidescroll 5)
  (set! :splitkeep :screen)
  (set! :signcolumn :auto))

{: setup}

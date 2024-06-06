(fn set! [key ?value]
  "
  Sets the value of `vim.opt.key` as follows:
  - if `?value` is not `nil`, set it as the value;
  - if `key` begins with `no`, strip the `no` prefix and set it as `false`;
  - if `key` is not `nil`, set the value as `true`;
  - otherwise panic and return `nil`.
  "
  (case [key ?value]
    [key value] (tset vim.opt key value)
    (where [key] (vim.startswith key :no)) (tset vim.opt (string.sub key 3)
                                                 false)
    [key] (tset vim.opt key true)
    _ nil))

;; reasonable defaults
(set! :backspace :2)
(set! :showcmd)
(set! :laststatus 2)
(set! :autoread)
;;(set! :shortmess+ :sWcI)

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
(set! :conceallevel 2)
(set! :scrolloff 3)
(set! :number)
(set! :norelativenumber)
(set! :wrap)

;; make the neovim clipboard play nicely with the OS's clipboard
(set! :clipboard :unnamedplus)

;; search options
(set! :ignorecase)
(set! :smartcase)
(set! :hlsearch)
;; this relies on ripgrep being available
(set! :grepprg "rg --vimgrep")
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
(set! :signcolumn "yes:1")


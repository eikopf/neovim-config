;; VIM OPTIONS
(lambda set! [key ?value]
  "Assigns `value` to `vim.opt.key`, or `true` if `value` is omitted."
  (tset vim.opt key (if (= ?value nil) true ?value)))

;; reasonable defaults
(set! :backspace :2)
(set! :showcmd true)
(set! :laststatus 2)
(set! :autoread true)

;; tab behaviour
(set! :tabstop 4)
(set! :shiftwidth 2)
(set! :shiftround true)
(set! :expandtab true)

;; decrease update times
(set! :timeoutlen 500)
(set! :updatetime 50)

;; ui options
(set! :scrolloff 3)
(set! :number true)
(set! :relativenumber false)
(set! :wrap true)

;; make the neovim clipboard play nicely with the OS's clipboard
(set! :clipboard :unnamedplus)

;; search options
(set! :ignorecase true)
(set! :smartcase true)
(set! :hlsearch true)

;; vim commandline options
(set! :history 1000)

;; history options
(set! :backup false)
(set! :writebackup false)
(set! :undofile true)
(set! :swapfile false)

;; window options
(set! :splitbelow true)
(set! :splitright true)
(set! :sidescroll 5)


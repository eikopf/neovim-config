;; VIM OPTIONS
;; NOTE: the _G prefix is required to access global mutable state
;; assigning values to keys in this table is equivalent to invoking <Cmd>set {key} {value}<cr>
(local opt _G.vim.opt)

;; reasonable defaults
(set opt.backspace :2)
(set opt.showcmd true)
(set opt.laststatus 2)
;; auto-load file changes from outside of vim
(set opt.autoread true)

;; tab behaviour
;; use four spaces for tabs
(set opt.tabstop 4)
;; number of spaces used during autoindent
(set opt.shiftwidth 2)
;; round indents to an integer multiple of the shiftwidth
(set opt.shiftround true)
;; convert tabs into spaces (number is defined by tabstop)
(set opt.expandtab true)

;; decrease update times
(set opt.timeoutlen 500)
(set opt.updatetime 50)

;; ui options
;; the number of lines to keep above/below cursor where possible
(set opt.scrolloff 3)
;; use line numbers
(set opt.number true)
;; don't use relative numbers
(set opt.relativenumber false)

;; make the neovim clipboard play nicely with the OS's clipboard
(set opt.clipboard :unnamedplus)

;; search options
;; case-insensitive search by default
(set opt.ignorecase true)
;; if search includes a capital letter, then search with case
(set opt.smartcase true)
;; highlight search results
(set opt.hlsearch true)

;; vim commandline options
(set opt.history 1000)

;; history options
(set opt.backup false)
(set opt.writebackup false)
(set opt.undofile true)
(set opt.swapfile false)

;; window options
(set opt.splitbelow true)
(set opt.splitright true)

;; text wrapping options
;; disable linewrapping, equivalent to (set nowrap true)
(set opt.wrap false)
;; make scrolling long lines faster
(set opt.sidescroll 5)


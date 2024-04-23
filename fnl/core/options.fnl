;; VIM OPTIONS
;; NOTE: the _G prefix is required to access global mutable state
;; assigning values to keys in this table is equivalent to invoking <Cmd>set {key} {value}<cr>
(local opt _G.vim.opt)      

;; reasonable defaults
(set opt.backspace "2")
(set opt.showcmd true)
(set opt.laststatus 2)
(set opt.autoread true) 	;; auto-load file changes from outside of vim

;; tab behaviour
(set opt.tabstop 4) 		;; use four spaces for tabs
(set opt.shiftwidth 2)      ;; number of spaces used during autoindent
(set opt.shiftround true)   ;; round indents to an integer multiple of the shiftwidth
(set opt.expandtab true)    ;; convert tabs into spaces (number is defined by tabstop)

;; decrease update times
(set opt.timeoutlen 500)
(set opt.updatetime 50)

;; ui options
(set opt.scrolloff 3) 		;; the number of lines to keep above/below cursor where possible
(set opt.number true)		;; use line numbers
(set opt.relativenumber false) 	;; don't use relative numbers

;; make the neovim clipboard play nicely with the OS's clipboard
(set opt.clipboard :unnamedplus)

;; search options
(set opt.ignorecase true)	;; case-insensitive search by default
(set opt.smartcase true)	;; if search includes a capital letter, then search with case
(set opt.hlsearch true) 	;; highlight search results

;; vim commandline options
(set opt.history 1000)

;; window options
(set opt.splitbelow true)
(set opt.splitright true)

;; text wrapping options
(set opt.wrap false)        ;; disable linewrapping, equivalent to (set nowrap true)
(set opt.sidescroll 5)      ;; make scrolling long lines faster

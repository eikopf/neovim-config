;; complete list of parsers: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
(local langs [ :agda		;; why would i *run* it? i already know it works
	       :bash
	       :beancount	;; accounting for unrepentant nerds
	       :bibtex
	       :c		;; is __phantomderp okay?
	       :c_sharp		;; bro trust me it isn't java i swear bro plea-
	       :clojure		;; please stop trying to save the JVM
	       :comment 	;; highlighting for comment tags (e.g. TODO)
	       :css
	       :csv
	       :d		;; just kinda... odd?
	       :diff
	       :dockerfile
	       :elixir		;; oddly good for a frankensteinian abomination
	       :elm		;; evan PLEASE we need a new compiler release
	       :erlang
	       :fennel		;; clojure? i hardly know her!
	       :fish		;; *glub* *bloop* *glub*
	       ;; :gdscript	;; godot's scripting language
	       ;; :gdshader	;; godot's shader language
	       :git_config
	       :git_rebase
	       :gitattributes
	       :gitcommit
	       :gitignore
	       :gleam		;; a frontend for a frontend for erlang
	       :glsl
	       :go		;; (with extreme reluctance)
	       :haskell		;; a monad? why, it's just an endofun- *gunshot*
	       :hlsl
	       :html
	       :ini
	       :java		;; (even more reluctantly)
	       :javascript	;; the world's first accidental programming language
	       :jq		;; concerningly well-made
	       :jsdoc		;; for when you're *terrified* of type theory
	       :json
	       :julia		;; the only good LLVM frontend
	       :just		;; I Can't Believe It's Not CMake!
	       :kdl		;; the inoffensive choice for configuration
	       :kotlin		;; jetbrains, for the love of god, support the LSP
	       :latex		;; a compiler target masquerading as a language
	       :linkerscript
	       :llvm		;; i choose to believe that chris lattner is a scalie
	       :lua		;; the only good dynamically-typed imperative language
	       :luadoc
	       :make		;; a divine punishment for stroustrup's sins
	       :markdown
	       :markdown_inline
	       :matlab		;; (with a level of reluctance never before seen in a human being)
	       :nix		;; barely a programming language
	       :norg 		;; the neovim org-mode plugin: now with fewer features!
	       :ocaml		;; hey, what if we removed the interesting parts of haskell?
	       :ocaml_interface
	       :ocamllex
	       :odin		;; borrow-checkers are communism. obviously.
	       :perl
	       :php		;; a terrible language from the dark ages
	       :phpdoc
	       :python		;; a dozen dialects have no hope of saving it
	       :r		;; better than matlab, worse than julia
	       :racket		;; scheme++
	       :roc		;; richard feldman's elm 2: electric boogaloo
	       :ruby		;; you can NEVER have enough keywords
	       :rust		;; foo.unwrap().map(Clone::clone).unwrap().deref().clone()
	       :scala 		;; java, but if it only had 14 users
	       :scheme		;; lisp, but if it was good
	       :sql		;; the only perfect language to ever exist
	       :ssh_config	;; the OpenSSH config format
	       :swift		;; a good language trapped in a *terrible* IDE
	       :tmux
	       :toml		;; the config format designed entirely to cause controversy
	       :typescript	;; look, at least it isn't javascript
	       :typst		;; *smirks* your time will come, donald...
	       :unison		;; one collision and it's all over
	       :uxntal		;; a forth so cute that it's *almost* not awful
	       :vim		;; odersky *wishes* he could alienate as many users as vimlang
	       :vimdoc
	       :wgsl		;; https://xkcd.com/927/
	       :wgsl_bevy
	       :xml		;; only a committee could make something this awful
	       :yaml		;; very slightly better than xml (but only just)
	       :zig ])		;; the only memory-unsafe language designed by a non-fascist

;; complete spec given here: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
(local opts { :ensure_installed langs
       	      :auto_install false
	      :index { :enable true }
	      :highlight { :enable true }})

;; callback to pass opts to nvim-treesitter.configs.setup
(fn config []
  (let [ ts (require "nvim-treesitter.configs")]
    (ts.setup opts)))

;; plugin spec
{ 1 "nvim-treesitter/nvim-treesitter"
  :dependencies [ "nvim-treesitter/nvim-treesitter-textobjects" ]
  :build ":TSUpdate"
  :config config }

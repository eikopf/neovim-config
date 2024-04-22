;; list of parsers to install
(local langs [ :c 
	       :lua
	       :fennel
	       :julia 
	       :rust 
	       :java
	       :kotlin
	       :haskell
	       :python
	       :javascript
	       :typescript ])

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

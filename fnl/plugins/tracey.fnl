;; local version of eikopf/tracey.nvim

(λ open-quickfix []
  (let [trouble (require :trouble)]
    (trouble.open :qflist)))

{:dir "~/projects/tracey.nvim"
 :opts {:web_port 3010 :query_layout {:height 30} :open_quickfix open-quickfix}}

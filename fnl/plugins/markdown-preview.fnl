;; iamcco/markdown-preview.nvim -- a plugin for previewing .md files in the browser

{1 :iamcco/markdown-preview.nvim
 :cmd [:MarkdownPreviewToggle :MarkdownPreview :MarkdownPreviewStop]
 :ft [:markdown]
 :build (fn []
          ((. _G.vim.fn "mkdp#util#install")))}


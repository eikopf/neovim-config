;; chomosuke/typst-preview.nvim --- a live previewer for typst projects

;; NOTE: (see `:help typst-preview` for canonical docs)
;; on first download, typst-preview downloads several binaries to render and
;; display typst files; this requires access to curl. these files can be
;; updated manually with `:TypstPreviewUpdate`.

{1 :chomosuke/typst-preview.nvim
 :ft :typst
 :version :1.*
 :opts {:follow_cursor false}}

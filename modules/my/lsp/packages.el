;; -*- no-byte-compile: t; -*-
;;; my/lsp/packages.el

(when (featurep! :tools lsp)
  (package! lsp-treemacs :pin "bd2c3727dd1e46e972477f11ba84999697ed842c"))

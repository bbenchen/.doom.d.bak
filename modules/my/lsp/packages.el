;; -*- no-byte-compile: t; -*-
;;; my/lsp/packages.el

(when (featurep! :tools lsp)
  (package! lsp-treemacs))

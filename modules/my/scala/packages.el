;; -*- no-byte-compile: t; -*-
;;; my/scala/packages.el

(when (and (featurep! :tools lsp) (not (featurep! :tools lsp +eglot)))
  (package! lsp-metals :pin "5468b638cd81b7d9ce9edc652c281b28bd775c23"))

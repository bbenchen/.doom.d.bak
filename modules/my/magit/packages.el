;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (executable-find "svn")
  (package! magit-svn :pin "2cff1a30a30f2b3963342a7d185ec13fc12279c3"))

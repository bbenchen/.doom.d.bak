;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (executable-find "svn")
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

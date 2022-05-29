;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (and (executable-find "svn")
         (executable-find "git-svn"))
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "87982991aa68d9b5c782bc082877d2d0ae35f6af")

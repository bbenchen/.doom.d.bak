;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (and (executable-find "svn")
         (executable-find "git-svn"))
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "9e7517cfee9272e9e4822b4efc3fac7e32d7bb38")

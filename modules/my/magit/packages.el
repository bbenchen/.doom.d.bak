;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (and (executable-find "svn")
         (executable-find "git-svn"))
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "f5c0b5ef2ae46062ba13dd03215cdfc49d0fd30b")

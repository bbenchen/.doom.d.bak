;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (and (executable-find "svn")
         (executable-find "git-svn"))
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "b86822f460a54c60fdfede62d4a86bd4991baa21")

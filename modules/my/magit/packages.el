;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (and (executable-find "svn")
         (executable-find "git-svn"))
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "f5c0fc350db07ca89839c6bec7196945dba495eb")

;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (executable-find "svn")
  (package! magit-svn :pin "350493217afdb7637564e089f475909adecd9208"))

(package! blamer :pin "2078d9b4ce3dc31469afa1c93e805acb56bd4466")

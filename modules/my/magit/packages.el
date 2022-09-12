;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (modulep! +svn)
  (package! magit-svn :pin "b8277081db90977247ae3900ea6afeb0ca644d36"))

(package! blamer :pin "99b43779341af0d924bfe2a9103993a6b9e3d3b2")

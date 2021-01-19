;; -*- no-byte-compile: t; -*-
;;; my/magit/packages.el

(if (executable-find "svn")
  (package! magit-svn
    :recipe (:host github :repo "cxb811201/magit-svn")
    :pin "01af1e7c226d5b8db2c84f19e3c15e8d51a89d5b"))

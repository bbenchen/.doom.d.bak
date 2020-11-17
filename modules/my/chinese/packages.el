;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "9d7f06d2324e8dbe6d7daab5eabb20e8da236ded")
(when (featurep! +childframe)
  (package! posframe :pin "395aca928b00c8f76aaeb65a85481c99e88c6873"))

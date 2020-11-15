;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "d2e2f65bea672273cbcbce4a9161264c383a41c2")
(when (featurep! +childframe)
  (package! posframe :pin "395aca928b00c8f76aaeb65a85481c99e88c6873"))

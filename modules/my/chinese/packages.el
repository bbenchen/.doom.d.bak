;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "345e8c5bd6ef6f381880c4c315506dc6a5bc4cca")
(when (featurep! +childframe)
  (package! posframe :pin "b3028b01a96699b1dfc9b2b5f4e3ba2bc1aa8317"))

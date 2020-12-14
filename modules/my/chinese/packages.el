;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "0faa6e40d272fa79a4ce4f39901a811fc8191de0")
(when (featurep! +childframe)
  (package! posframe :pin "e1552c82dffaadc5e7de09a44880a498197ffbee"))

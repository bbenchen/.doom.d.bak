;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "2bc3035c626d65d9e3d5b54814bc28f8db18ab3e")
(when (featurep! +childframe)
  (package! posframe :pin "e1552c82dffaadc5e7de09a44880a498197ffbee"))

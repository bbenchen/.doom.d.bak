;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "9d7f06d2324e8dbe6d7daab5eabb20e8da236ded")
(when (featurep! +childframe)
  (package! posframe :pin "9e9b16b0b27d1ca1973773db9bcdfada9475f34a"))

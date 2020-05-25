;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "daf956df30d4007f70a4495560d656e517ab69a9")
(when (featurep! +childframe)
  (package! posframe :pin "093b29a53cbeda6d637ccc9ef4dfc47123e79b9e"))

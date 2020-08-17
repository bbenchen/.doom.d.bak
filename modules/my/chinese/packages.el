;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "aab21695f1dee0db3ddf0f0c834b94aecec7057c")
(when (featurep! +childframe)
  (package! posframe :pin "b28210748d982ca1c30debb3b3861063e7223c6c"))

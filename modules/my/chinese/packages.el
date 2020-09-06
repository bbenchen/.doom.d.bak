;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "9d139b56b45e91b787031f5b86c3462287d6ef29")
(when (featurep! +childframe)
  (package! posframe :pin "b28210748d982ca1c30debb3b3861063e7223c6c"))

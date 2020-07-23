;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "345e8c5bd6ef6f381880c4c315506dc6a5bc4cca")
(when (featurep! +childframe)
  (package! posframe :pin "922e4d239f7a083213d856de67a9686a091b1e27"))

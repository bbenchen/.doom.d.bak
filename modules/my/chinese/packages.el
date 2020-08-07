;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "345e8c5bd6ef6f381880c4c315506dc6a5bc4cca")
(when (featurep! +childframe)
  (package! posframe :pin "6d604a71deb45295f7b6ff3f98e06aeece9888be"))

;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "345e8c5bd6ef6f381880c4c315506dc6a5bc4cca")
(when (featurep! +childframe)
  (package! posframe :pin "c4459028fbe6740315ff1ed6f37e8c4decd3d050"))

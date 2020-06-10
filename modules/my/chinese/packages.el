;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "2a0b116d56bf54456eb5d6e8e80a7a6cf6944863")
(when (featurep! +childframe)
  (package! posframe :pin "c4459028fbe6740315ff1ed6f37e8c4decd3d050"))

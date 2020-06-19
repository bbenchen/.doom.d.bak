;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "3cf39be4341ecdfd5e8faedcd42213e2c8c9f8a3")
(when (featurep! +childframe)
  (package! posframe :pin "c4459028fbe6740315ff1ed6f37e8c4decd3d050"))

;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "51870af814c6e9ce1a5aa8d33758f5b571950102")
(when (featurep! +childframe)
  (package! posframe :pin "c4459028fbe6740315ff1ed6f37e8c4decd3d050"))
